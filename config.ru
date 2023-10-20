require 'rack'
require_relative 'app'
require_relative 'loader'

Loader.new.load

use Rack::Reloader, 0

use Rack::Static, urls: ['/public', '/favicon.ico']

use Logging

run App.new
