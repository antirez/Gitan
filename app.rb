require 'rubygems'
require 'sinatra'
require 'yauth'
require 'uri'
require File.join(File.dirname(__FILE__), 'gitan_config')

set :sessions, true

Yauth::Strategy.install!

Yauth.location = File.join(File.dirname(__FILE__), "users.yml")

use Warden::Manager do |manager|
  manager.default_strategies :yauth_users
  manager.failure_app = Yauth::FailureApp.new($sitename)
end

before do
  request.env['warden'].authenticate! # execution stop and auth is required
end

helpers do
end

get '/' do
    @repos = Dir.open($reporoot).to_a
    erb :repolist
end

get '/info/:repo' do
    @repo = params[:repo]
    erb :repoinfo
end

get '/commit/:repo/:rev' do
    @repo = params[:repo]
    @rev = params[:rev]
    erb :commitinfo
end

post '/create' do
    throw :halt, [ 400, 'Bad Request' ] if !params[:reponame]
    throw :halt, [ 400, 'Name Too Short' ] if params[:reponame].length < 3
    reponame = params[:reponame].gsub(/[^A-z]/,"_")
    path = $reporoot + "/" + reponame + ".git"
    throw :halt, [ 400, 'Repository exists' ] if File.exists? path
    system("mkdir #{path}; cd #{path}; git init --bare")
    redirect '/'
end

