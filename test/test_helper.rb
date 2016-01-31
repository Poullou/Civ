require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
require 'require_all'
require 'mongoid'
require 'sinatra'
require 'sinatra/json'

require_all 'app/**/*.rb'
Mongoid.load!('config/mongoid.yml', :test)

def purge_database
  Mongoid.purge!
end
