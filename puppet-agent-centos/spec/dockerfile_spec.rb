require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'using centos'
  include_context 'with a docker image'

  describe yumrepo('puppet5') do
    it { should exist }
  end

  describe package('puppet-agent.x86_64') do
    it { is_expected.to be_installed }
  end

  describe file('/opt/puppetlabs/bin/puppet') do
    it { should exist }
    it { should be_executable }
  end

  describe 'Dockerfile#running' do
    include_context 'with a docker container'

    describe command('/opt/puppetlabs/bin/puppet help') do
      its(:exit_status) { should eq 0 }
    end
  end
end
