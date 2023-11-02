require 'pry'
require 'sequel'

# The main application class responsible for handling incoming requests.
class App
  attr_reader :logger

  # Initialize the application.
  def initialize
    # FIXME: Consider loading this outside of App#initialize
    require_relative 'config/routes'
  end

  # Handle incoming HTTP requests.
  #
  # @param env [Hash] The environment data of the HTTP request.
  # @return [Array] An array containing HTTP response status, headers, and body.
  def call(env)
    headers = { 'Content-Type' => 'text/html' }

    response_html = router.build_response(env)

    [200, headers, [response_html]]
  end

  private

  # Retrieve the shared router instance for handling routing.
  #
  # @return [Router] The shared Router instance.
  def router
    Router.instance
  end
end
