require 'sinatra'

class TickerApi < Sinatra::Base

  get "/ticker" do
    "hi"
  end
  
  get "/ticker/what" do
    "what what!"
  end
  
end