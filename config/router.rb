require 'singleton'

# The `Router` class is responsible for routing HTTP requests to the appropriate handlers.
#
# This class handles the configuration of routes and dispatches requests based on those routes.
class Router
  # @!attribute [r] path
  #   @return [String] The path of the current request.
  attr_reader :path

  # @!attribute [r] env
  #   @return [Hash] The environment hash containing information about the HTTP request.
  attr_reader :env

  # Includes the Singleton module to ensure that there is only one instance of the Router class.
  include Singleton

  # Includes the Parser module for route parsing functionality.
  include Parser

  # Initializes a new instance of Router.
  #
  # The Router instance is used to configure and manage routes for HTTP requests.
  def initialize
    @routes = {}
  end

  class << self
    # Defines routes using a block.
    #
    # @yield [blk] The block containing route definitions.
    def draw(&blk)
      Router.instance.instance_exec(&blk)
    end
  end

  # Defines a GET route for the specified path.
  #
  # @param path [String] The path to match for the route.
  # @param blk [Proc] (optional) A block to execute when the route is matched.
  def get(path, &blk)
    if blk
      @routes[path] = blk
    elsif path.include? '/'
      @routes[path.prepend('/')] = lambda do |env|
        @path = env['REQUEST_PATH']
        @env = env
        controller, view_template, action = resource_controller
        controller.send(action.to_sym)
        controller.render(view_template)
      end
    end
  end

  # Defines RESTful routes for a resource.
  #
  # @param resource_name [String, Symbol] The name of the resource.
  def resources(resource_name)
    resource_name = resource_name.to_s if resource_name.is_a? Symbol

    get("#{resource_name}/index")
    get("#{resource_name}/show")
  end

  # Builds a response for the given environment.
  #
  # @param env [Hash] The environment hash containing information about the HTTP request.
  # @return [String] The response for the HTTP request.
  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || -> { "no route found for #{path}" }
    handler.call(env)
  end
end
