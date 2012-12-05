require "./server/init"
disable :logging
set :root, File.dirname(__FILE__) + "/../"

get "/favicon.ico" do
  ""
end

get "/*" do
  send_file "public/index.html"
end