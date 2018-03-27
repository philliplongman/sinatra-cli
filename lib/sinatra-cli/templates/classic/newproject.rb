require "sinatra"

get "/" do
  @name = "world"
  erb :index
end

get "/:name" do
  @name = params["name"]
  erb :index
end
