require 'sinatra'
require 'sinatra/reloader' if development?
require 'octokit'
require 'json'

TARGET_REPO = "mosson/simple-create-issue"

get '/' do
  erb :index
end

post '/' do
  client = Octokit::Client.new login: ENV["GITHUB_USER"], password: ENV["GITHUB_PASSWORD"]
  api_response = client.create_issue TARGET_REPO, params[:title], params[:body] unless params[:title].nil? && params[:body].nil?
  redirect api_response.html_url
end
