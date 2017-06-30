shared_context 'with a docker container with a dummy cmd' do
  before(:all) do
    @image = Docker::Image.build_from_dir(CURRENT_DIRECTORY)
    @container = Docker::Container.create(
      'Image' => @image.id,
      'Cmd' => ['sh', '-c', 'while true; do sleep 1; done']
    )
    @container.start

    set :backend, :docker
    set :docker_container, @container.id
  end

  after(:all) do
    @container.kill
    @container.delete(force: true)
  end
end
