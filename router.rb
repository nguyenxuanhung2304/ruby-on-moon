require 'singleton'
require 'pry'

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
    if blk
      @routes[path] = blk
    elsif path.include? '/'
      resource_name, controller_klass, action = make_controller_klass(path)
      @routes[path.prepend('/')] = lambda do |env|
        controller = controller_klass.new(env, resource_name)
        controller.render("views/#{resource_name}/#{action}.html.erb")
        controller.send(action.to_sym)
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

  private

  def load_controller(resource_name)
    controller_file_path = "./controllers/#{resource_name}_controller.rb"
    raise ArgumentError, "Controller not found: #{file_path}" unless File.exist?(controller_file_path)

    require_relative controller_file_path
  end

  def constantize(class_name)
    klass = Object.const_get(class_name)
    raise NameError unless klass.is_a?(Class)

    klass
  end

  def make_controller_klass(path)
    resource_name, action = path.split('/')
    load_controller(resource_name)
    controller_klass = constantize("#{resource_name.capitalize}Controller")
    return resource_name, controller_klass, action
  end
end
