require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'using alpine'
  include_context 'with a docker container with a dummy cmd'

  describe package('curl') do
    it { is_expected.to be_installed }
  end

  describe command('curl --version') do
    its(:stdout) { is_expected.to contain('curl') }
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe package('py-pip') do
    it { is_expected.to be_installed }
  end

  describe package('puppetboard') do
    it { is_expected.to be_installed.by('pip') }
  end

  describe package('gunicorn') do
    it { is_expected.to be_installed.by('pip') }
  end

  describe file('/usr/bin/gunicorn') do
    it { should exist }
    it { should be_executable }
  end
end
