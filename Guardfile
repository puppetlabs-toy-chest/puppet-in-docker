notification :off

guard :rake, task: :default do
  watch('Rakefile')
  watch(%r{^lib\/.+\.rb$})
  watch(%r{^.+\/Dockerfile$})
end
