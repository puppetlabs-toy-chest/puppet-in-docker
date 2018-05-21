require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'using alpine'
  include_context 'with a docker container with a dummy cmd'

  describe file('/usr/local/bin/pip') do
    it { should exist }
    it { should be_executable }
  end

  describe package('puppetboard') do
    it { is_expected.to be_installed.by('pip') }
  end

  describe package('gunicorn') do
    it { is_expected.to be_installed.by('pip') }
  end

  describe file('/usr/local/bin/gunicorn') do
    it { should exist }
    it { should be_executable }
  end
end
