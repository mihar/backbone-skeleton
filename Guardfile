guard 'haml', :input => 'src/haml', :output => 'public/' do
    watch(/^.+(\.html\.haml)\Z/)
end
guard 'sass', :input => 'src/sass', :output => 'public/css'
guard 'coffeescript', :input => 'src/javascript', :output => 'public/js'
guard :jammit, :config_path => 'config/assets.yml' do
  watch(%r{^public/js/(.*)\.js$})
  watch(%r{^public/css/(.*)\.css$})
end