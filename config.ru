require 'bundler/setup'
require 'sinatra/base'
require 'dotenv'
require 'mongoid'

# Load environment variables and libraries
Dotenv.load

# Load App
require './app'

if ENV['RACK_ENV'] == 'development'
  require 'pry'
elsif ENV['RACK_ENV'] == 'production'
  use Rack::Deflater #Enable GZip Compression
end

run BudgetApp
