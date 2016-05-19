require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'using alpine'
  include_context 'with a docker image'

  describe package('puppet') do
    it { is_expected.to be_installed.by('gem') }
  end

  describe file('/usr/bin/puppet') do
    it { should exist }
    it { should be_executable }
  end

  describe 'Dockerfile#running' do
    include_context 'with a docker container'

    describe command('/usr/bin/puppet help') do
      its(:exit_status) { should eq 0 }
    end
  end
end
