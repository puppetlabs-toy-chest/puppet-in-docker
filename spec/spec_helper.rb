require 'serverspec'
require 'docker'

# Load any shared examples or context helpers
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
