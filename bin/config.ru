require 'sinatra'
require 'sinatra/json'
require 'haml'
require 'require_all'
require 'mongoid'

require_all 'app/**/*.rb'
Mongoid.load!('config/mongoid.yml', :development)

set :public_folder, Proc.new { File.join(Dir.pwd, 'app', 'presentation', 'web', 'public') }
set :views, Proc.new { File.join(Dir.pwd, 'app', 'presentation', 'web', 'vues') }

run Sinatra::Application
