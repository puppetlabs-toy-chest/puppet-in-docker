require 'mkmf'
require 'time'

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'colorize'
require 'table_print'

require_relative 'lib/puppet/dockerfile'
require_relative 'lib/tableprint/formatters'

include Puppet::Dockerfile

REPOSITORY = ENV['DOCKER_REPOSITORY'] || 'puppet'
NO_CACHE = ENV['DOCKER_NO_CACHE'] || false
TAG = ENV['DOCKER_IMAGE_TAG'] || 'latest'
NAMESPACE = ENV['DOCKER_NAMESPACE'] || 'com.puppet'

IMAGES = Dir.glob('*').select { |f| File.directory?(f) && File.exist?("#{f}/Dockerfile") && !File.exist?("#{f}/.ignore") }

RuboCop::RakeTask.new

task :docker do
  raise 'These tasks require docker to be installed' unless find_executable 'docker'
end

desc 'List all Docker images along with some data about them'
task :list do
  images = IMAGES.collect do |name|
    sha = get_git_sha_from_label(name)
    sha = sha.yellow unless sha == current_git_sha
    {
      name: name,
      version: get_version_from_label(name),
      from: get_from_from_dockerfile(name),
      sha: sha,
      build: get_buildtime_from_label(name),
      maintainer: get_maintainer_from_dockerfile(name)
    }.each_with_object({}) do |(k, v), h|
      h[k] = highlight_issues(v)
      h
    end
  end
  tp.set :max_width, 40
  tp images
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
      version = get_version_from_label(image)
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

    desc 'Publish docker image'
    task publish: :docker do
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

    task test: [
      :lint,
      :spec
    ]

    desc 'Update Dockerfile label content for new version'
    task :rev do
      replacements = {
        "#{NAMESPACE}.git.sha" => current_git_sha,
        "#{NAMESPACE}.buildtime" => Time.now.utc.iso8601
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
  end
end

[:test, :lint, :build, :publish, :rev].each do |task_name|
  desc "Run #{task_name} for all images in repository in parallel"
  multitask task_name => IMAGES.collect { |image| "#{image}:#{task_name}" }
end

task default: [
  :rubocop,
  :test
]
