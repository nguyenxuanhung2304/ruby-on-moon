require 'rack'
require_relative 'loader'
require_relative 'app'

Loader.new.load

use Rack::Reloader, 0

use Rack::Static, urls: ['/public', '/favicon.ico']

use Logging

run App.new
