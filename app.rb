require 'rubygems'
require 'sinatra'
require 'httpauth'
require 'uri'
require 'gitan'

require 'gitan_config'

class Gitan < Sinatra::Base
  dir = File.dirname(File.expand_path(__FILE__))

  set :views, "#{dir}/views"
  set :public, "#{dir}/public"
  set :static, true

  before do
      # Nothing to do so far
  end

  helpers do
    include Sinatra::Authorization
  end

  get '/' do
      require_administrative_privileges
      @repos = Dir.open($reporoot).to_a
      erb :repolist
  end

  get '/info/:repo' do
      require_administrative_privileges
      @repo = params[:repo]
      erb :repoinfo
  end

  get '/commit/:repo/:rev' do
      require_administrative_privileges
      @repo = params[:repo]
      @rev = params[:rev]
      erb :commitinfo
  end

  post '/create' do
      require_administrative_privileges
      throw :halt, [ 400, 'Bad Request' ] if !params[:reponame]
      throw :halt, [ 400, 'Name Too Short' ] if params[:reponame].length < 3
      reponame = params[:reponame].gsub(/[^A-z]/,"_")
      path = $reporoot + "/" + reponame + ".git"
      throw :halt, [ 400, 'Repository exists' ] if File.exists? path
      system("mkdir #{path}; cd #{path}; git init --bare")
      redirect '/'
  end

end