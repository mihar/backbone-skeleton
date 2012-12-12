guard 'haml', :input => 'src/haml', :output => 'public/' do
    watch %r{^.+(\.html\.haml)\Z}
end

guard 'haml-coffee', :input => 'src/templates', :output => 'public/js/templates' do
  watch %r{^.+(\.js\.hamlc)\Z}
end

guard 'sass', :input => 'src/sass', :output => 'public/css'

guard 'coffeescript', :input => 'src/coffeescript', :output => 'public/js'

guard :jammit, :config_path => 'config/assets.yml' do
  watch %r{^public/js/(.*)\.js$}
  watch %r{^public/css/(.*)\.css$}
end