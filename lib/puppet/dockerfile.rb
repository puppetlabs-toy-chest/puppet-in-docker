require 'json'

module Puppet # :nodoc:
  module Dockerfile # :nodoc:
    def info(message)
      puts "==> #{message}".colorize(:green)
    end

    def warn(message)
      puts "==> #{message}".colorize(:yellow)
    end

    def error(message)
      puts "==> #{message}".colorize(:red)
    end

    def get_version_from_label(image)
      labels = JSON.parse(`docker inspect -f "{{json .Config.Labels }}" #{REPOSITORY}/#{image}`)
      labels["#{NAMESPACE}.version"]
    rescue JSON::ParserError
      nil
    end
  end
end
