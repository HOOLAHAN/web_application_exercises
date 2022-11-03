require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = params[:name]
    if @name.include?('href' || 'https')
      return "You shall not PASS!!!" 
    else
      return erb(:hello)
    end
  end
end