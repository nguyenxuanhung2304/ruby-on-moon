require 'singleton'
require 'pry'
require 'zeitwerk'
require_relative '../utils/parser'

class Router
  attr_reader :path
  attr_reader :env

  include Singleton
  include Parser

  def initialize
    # FIXME: use loader in app.rb instead of here
    loader = Zeitwerk::Loader.new
    loader.push_dir('controllers')
    loader.push_dir('utils')
    loader.setup
    @routes = {}
  end

  class << self
    def draw(&blk)
      Router.instance.instance_exec(&blk)
    end
  end

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

  def resources(resource_name)
    resource_name = resource_name.to_s if resource_name.is_a? Symbol

    get("#{resource_name}/index")
    get("#{resource_name}/show")
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || -> { "no route found for #{path}" }
    handler.call(env)
  end
end
