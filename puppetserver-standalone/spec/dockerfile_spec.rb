require 'serverspec'
require 'docker'

describe 'Dockerfile' do
  before(:all) do
    root = File.dirname(File.dirname(__FILE__))
    @image = Docker::Image.build_from_dir(root)

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, @image.id
  end

  it 'uses the correct version of Ubuntu' do
    os_version = command('lsb_release -a').stdout
    expect(os_version).to include('Ubuntu 14.04')
  end

  describe package('puppetserver') do
    it { is_expected.to be_installed }
  end

  describe user('puppet') do
    it { should exist }
  end

  describe file('/opt/puppetlabs/bin/puppetserver') do
    it { should exist }
    it { should be_executable }
  end

  describe command('/opt/puppetlabs/bin/puppetserver --help') do
    its(:exit_status) { should eq 0 }
  end

  describe 'Dockerfile#config' do
    it 'should expose the puppetserver port' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to include("8140/tcp")
    end
  end

  describe 'Dockerfile#running' do
    before(:all) do
      @container = Docker::Container.create('Image' => @image.id)
      @container.start
    end

    describe process('bash') do
      its(:user) { should eq "root" }
      its(:pid) { should eq 1 }
      its(:args) { should match(/foreground/) }
      it { should be_running }
    end

    describe process('java') do
      its(:user) { should eq "puppet" }
      it { should be_running }
    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
    end
  end
end
