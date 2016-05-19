shared_context 'with a docker container' do
  before(:all) do
    @container = Docker::Container.create('Image' => @image.id)
    @container.start
  end

  after(:all) do
    @container.kill
    @container.delete(force: true)
  end
end
