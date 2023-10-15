require 'singleton'

class Router
  include Singleton

  def initialize
    @routes = {}
  end

  class << self
    def draw(&blk)
      Router.instance.instance_exec(&blk)
    end
  end

  def get(path, &blk)
    @routes[path] = blk
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || -> { "no route found for #{path}" }
    handler.call(env)
  end
end
