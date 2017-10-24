require 'json'
require 'rainbow'

module Puppet # :nodoc:
  module Dockerfile # :nodoc:
    def info(message)
      puts Rainbow("==> #{message}").green
    end

    def warn(message)
      puts Rainbow("==> #{message}").yellow
    end

    def error(message)
      puts Rainbow("==> #{message}").red
    end

    def current_git_sha
      `git rev-parse HEAD`.strip
    end

    def previous_git_sha
      `git rev-parse HEAD~1`.strip
    end

    def highlight_issues(value)
      value.nil? ? Rainbow('     ').bg(:red) : value
    end

    def method_missing(method_name, *args)
      if method_name =~ /^get_(.+)_from_label$/
        get_value_from_label(*args, Regexp.last_match(1))
      elsif method_name =~ /^get_(.+)_from_dockerfile$/
        get_value_from_dockerfile(*args, Regexp.last_match(1))
      elsif method_name =~ /^get_(.+)_from_env$/
        get_value_from_env(*args, Regexp.last_match(1))
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      patterns = [
        /^get_(.+)_from_label$/,
        /^get_(.+)_from_dockerfile$/,
        /^get_(.+)_from_env$/
      ]
      method_name.to_s =~ Regexp.union(patterns) || super
    end

    def get_value_from_label(image, value)
      labels = JSON.parse(`docker inspect -f "{{json .Config.Labels }}" #{REPOSITORY}/#{image}`)
      labels["#{NAMESPACE}.#{value.tr('_', '-')}"]
    rescue # rubocop:disable Lint/RescueWithoutErrorClass
      nil
    end

    def get_value_from_dockerfile(image, value)
      text = File.read("#{image}/Dockerfile")
      text[/^#{value.upcase} (.*$)/, 1]
    end

    def get_value_from_variable(image, var)
      text = File.read("#{image}/Dockerfile")
      var[0] = ''
      text[/#{var}=(["a-zA-Z0-9\.]+)/, 1]
    end

    def get_value_from_base_image(image, value)
      base_image = get_value_from_dockerfile(image, 'from')
      base_image_without_version = base_image.split(':')[0]
      base_image_without_repo = base_image_without_version.split('/')[1]
      get_value_from_env(base_image_without_repo, value)
    end

    def get_value_from_env(image, value)
      text = File.read("#{image}/Dockerfile")
      all_labels = text.scan(/org\.label-schema\.(.+)=(.+) \\?/).to_h
      version = all_labels[value]
      # Versions might be ENVIRONMENT variable references
      version = get_value_from_variable(image, version) if version.start_with?('$')
      # Environment variables might be set in the higher-level image
      version = get_value_from_base_image(image, value) if version.nil?
      version.gsub(/\A"|"\Z/, '')
    end
  end
end
