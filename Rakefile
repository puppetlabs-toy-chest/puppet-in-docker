require 'mkmf'
require 'time'

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'rainbow'
require 'table_print'

require_relative 'lib/puppet/dockerfile'
require_relative 'lib/tableprint/formatters'

include Puppet::Dockerfile

REPOSITORY = ENV['DOCKER_REPOSITORY'] || 'puppet'
NO_CACHE = ENV['DOCKER_NO_CACHE'] || false
TAG = ENV['DOCKER_IMAGE_TAG'] || 'latest'
NAMESPACE = ENV['DOCKER_NAMESPACE'] || 'org.label-schema'

IMAGES = Dir.glob('*').select { |f| File.directory?(f) && File.exist?("#{f}/Dockerfile") && !File.exist?("#{f}/.ignore") }

MICROBADGER_TOKENS = {
  'puppet-agent'            => 'n4wMgsk5mHUoJM1IpygaYiDeTwc=',
  'puppet-agent-alpine'     => 'Q0FbCSv_eOLoUkAA20dCGSCsxFU=',
  'puppet-agent-centos'     => 'x1NxmFkzHLvhYpR25s4g0pN_M9c=',
  'puppet-agent-debian'     => 'vqtjj3MKBeZXi2W4vFwQcZmseJc=',
  'puppet-agent-ubuntu'     => '0UWrSJA_m7mYXTyW3tm9yhWcEzM=',
  'factor'                  => 'xa-Yc1xoqs_b_QCaIq55gj-bme4=',
  'puppetdb'                => 'z76OPnge96LMvIELFWknSYJbs24=',
  'puppetdb-postgres'       => 'eo8WFlTPNL1IdbiGiDjb7yntZUw=',
  'puppetserver-standalone' => 'XpINInOKHSl0ce5dBthyqs_vnxw=',
  'puppetserver'            => 'G0BfSGbPoc9eqAmToDhnv8et5ag=',
  'puppetboard'             => '2bDFb5JXgC6_l3dqHxv64HOZRm0=',
  'puppetexplorer'          => 'hCiz0KejqgjngwrOoNoi3QrNeEM=',
  'puppet-inventory'        => '-qatAsCRU2aPh2vXrudqj0g6Brs='
}.freeze

RuboCop::RakeTask.new

task :docker do
  raise 'These tasks require docker to be installed' unless find_executable 'docker'
end

desc 'List all Docker images along with some data about them'
task :list do
  images = IMAGES.collect do |name|
    sha = get_vcs_ref_from_label(name)
    sha = Rainbow(sha).yellow unless sha == current_git_sha || sha == previous_git_sha
    {
      name: name,
      version: get_version_from_label(name),
      from: get_from_from_dockerfile(name),
      sha: sha,
      build: get_build_date_from_label(name),
      maintainer: get_maintainer_from_dockerfile(name)
    }.each_with_object({}) do |(k, v), h|
      h[k] = highlight_issues(v)
      h
    end
  end
  tp.set :max_width, 40
  tp images
end

desc 'Garbage collect unused docker filesystem layers'
task gc: :docker do
  sh 'docker rmi $(docker images -f "dangling=true" -q)' unless `docker images -f "dangling=true" -q`.empty?
end

IMAGES.each do |image|
  namespace image.to_sym do |_args|
    RSpec::Core::RakeTask.new(spec: [:docker]) do |t|
      t.pattern = "#{image}/spec/*_spec.rb"
    end

    desc 'Run Hadolint against the Dockerfile'
    task lint: :docker do
      info "Running Hadolint to check the style of #{image}/Dockerfile"
      sh "docker run --rm -i lukasmartinelli/hadolint < #{image}/Dockerfile"
    end

    desc 'Build docker image'
    task build: :docker do
      version = get_version_from_env(image)
      path = "#{REPOSITORY}/#{image}"
      info "Building #{path}:latest"
      cmd = "cd #{image} && docker build -t #{path}:latest"
      info "Ignoring layer cache for #{path}" if NO_CACHE
      cmd += ' --no-cache' if NO_CACHE
      sh "#{cmd} ."
      if version
        info "Building #{path}:#{version}"
        sh "cd #{image} && docker build -t #{path}:#{version} ."
      end
    end

    desc 'Pull all tags of image'
    task pull: :docker do
      path = "#{REPOSITORY}/#{image}"
      sh "docker pull -a '#{path}'"
    end

    task push: :docker do
      version = get_version_from_label(image)
      path = "#{REPOSITORY}/#{image}"
      if version
        info "Pushing #{path}:#{version} to Docker Hub"
        sh "docker push '#{path}:#{version}'"
      else
        warn "No version specified in Dockerfile for #{path}"
      end
      info "Pushing #{path}:latest to Docker Hub"
      sh "docker push '#{path}:latest'"
    end

    desc 'Publish docker image'
    task publish: [
      :push,
      :update_microbadger
    ]

    task test: [
      :lint,
      :spec
    ]

    desc 'Update Dockerfile label content for new version'
    task :rev do
      replacements = {
        "#{NAMESPACE}.vcs-ref" => current_git_sha,
        "#{NAMESPACE}.build-date" => Time.now.utc.iso8601
      }
      file_name = "#{image}/Dockerfile"
      text = File.read(file_name)
      replacements.each do |key, value|
        original = text.clone
        text = text.gsub(/#{key}=\"[a-z0-9A-Z\-:]*\"/, "#{key}=\"#{value}\"")
        info "Updating #{key} in #{file_name}" unless original == text
      end
      File.open(file_name, 'w') { |file| file.puts text }
    end

    task :update_microbadger do
      if MICROBADGER_TOKENS.key? image
        address = "https://hooks.microbadger.com/images/#{REPOSITORY}/#{image}/#{MICROBADGER_TOKENS[image]}"
        puts address
        uri = URI.parse(address)
        response = Net::HTTP.post_form(uri, {})
        if response.code == '200'
          info "microbadger.com updating badges for #{image}"
        else
          warn "issue updating microbadger.com badges for #{image}"
        end
      else
        warn "missing microbadger.com webhook URL for #{image}"
      end
    end
  end
end

[:test, :lint, :build, :publish, :rev, :pull].each do |task_name|
  desc "Run #{task_name} for all images in repository in parallel"
  multitask task_name => IMAGES.collect { |image| "#{image}:#{task_name}" }
end

[:spec].each do |task_name|
  desc "Run #{task_name} for all images in repository"
  task task_name => IMAGES.collect { |image| "#{image}:#{task_name}" }
end

task default: [
  :rubocop,
  :lint,
  :spec
]
