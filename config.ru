require 'rack'
require_relative './app'

use Rack::Reloader, 0

use Rack::Static, urls: ['/public']

run App.new
