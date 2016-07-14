require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile#running' do
  include_context 'with a docker image'
  include_context 'with a docker container'

  describe command('/opt/puppetlabs/bin/puppet inventory --help') do
    its(:exit_status) { should eq 0 }
  end
end
