require 'rack'
require_relative './app'

use Rack::Reloader, 0

use Rack::Static, urls: ['/public', '/favicon.ico']

run App.new
