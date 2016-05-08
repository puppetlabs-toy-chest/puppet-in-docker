require 'serverspec'
require 'docker'

describe 'Dockerfile' do
  before(:all) do
    root = File.dirname(File.dirname(__FILE__))
    image = Docker::Image.build_from_dir(root)

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  describe package('puppet-agent') do
    it { is_expected.to be_installed }
  end

  describe file('/opt/puppetlabs/bin/puppet') do
    it { should exist }
    it { should be_executable }
  end

  describe command('/opt/puppetlabs/bin/puppet help') do
    its(:exit_status) { should eq 0 }
  end
end
