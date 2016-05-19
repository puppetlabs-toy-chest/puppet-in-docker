shared_context 'with a docker image' do
  before(:all) do
    @image = Docker::Image.build_from_dir(CURRENT_DIRECTORY)

    set :os, family: @os || :debian
    set :backend, :docker
    set :docker_image, @image.id
  end
end
