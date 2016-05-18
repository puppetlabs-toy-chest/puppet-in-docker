require 'json'
require 'colorize'

module Puppet # :nodoc:
  module Dockerfile # :nodoc:
    def info(message)
      puts "==> #{message}".green
    end

    def warn(message)
      puts "==> #{message}".yellow
    end

    def error(message)
      puts "==> #{message}".red
    end

    def current_git_sha
      `git rev-parse HEAD`.strip
    end

    def previous_git_sha
      `git rev-parse HEAD~1`.strip
    end

    def highlight_issues(value)
      value.nil? ? '     '.on_red : value
    end

    def method_missing(method_name, *args)
      if method_name =~ /^get_(.+)_from_label$/
        get_value_from_label(*args, Regexp.last_match(1))
      elsif method_name =~ /^get_(.+)_from_dockerfile$/
        get_value_from_dockerfile(*args, Regexp.last_match(1))
      end
    end

    def get_value_from_label(image, value)
      labels = JSON.parse(`docker inspect -f "{{json .Config.Labels }}" #{REPOSITORY}/#{image}`)
      labels["#{NAMESPACE}.#{value.tr('_', '.')}"]
    rescue
      nil
    end

    def get_value_from_dockerfile(image, value)
      text = File.read("#{image}/Dockerfile")
      text[/^#{value.upcase} (.*$)/, 1]
    end
  end
end
