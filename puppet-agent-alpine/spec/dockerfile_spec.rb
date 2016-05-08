require 'serverspec'
require 'docker'

describe 'Dockerfile' do
  before(:all) do
    root = File.dirname(File.dirname(__FILE__))
    image = Docker::Image.build_from_dir(root)

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, image.id
  end

  describe package('puppet') do
    it { is_expected.to be_installed.by('gem') }
  end

  describe file('/usr/bin/puppet') do
    it { should exist }
    it { should be_executable }
  end

  describe command('/usr/bin/puppet help') do
    its(:exit_status) { should eq 0 }
  end
end
