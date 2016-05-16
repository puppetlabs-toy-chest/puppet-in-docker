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

  describe package('postgresql-common') do
    it { is_expected.to be_installed }
  end

  describe package('postgresql-9.5') do
    it { is_expected.to be_installed }
  end

  describe package('postgresql-contrib-9.5') do
    it { is_expected.to be_installed }
  end

  describe command('postgres --help') do
    its(:exit_status) { should eq 0 }
  end

  describe group('postgres') do
    it { should exist }
  end

  describe user('postgres') do
    it { should exist }
  end
end
