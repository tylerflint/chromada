require 'sinatra'

class GitDeployApp < Sinatra::Base

  post '/deploy' do
    push = JSON.parse(params[:payload])
    "I got some JSON: #{push.inspect}"
  end

end