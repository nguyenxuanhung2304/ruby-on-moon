require 'singleton'
require 'pry'
require 'zeitwerk'

class Router
  include Singleton

  def initialize
    # FIXME: use loader in app.rb instead of here
    loader = Zeitwerk::Loader.new
    loader.push_dir('controllers')
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
      resource_name, controller_klass, action = make_controller_klass(path)
      @routes[path.prepend('/')] = lambda do |env|
        controller = controller_klass.new(env, resource_name)
        controller.send(action.to_sym)
        controller.render("views/#{resource_name}/#{action}.html.erb")
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

  def constantize(class_name)
    klass = Object.const_get(class_name)
    raise NameError unless klass.is_a?(Class)

    klass
  end

  def make_controller_klass(path)
    resource_name, action = path.split('/')
    controller_klass = constantize("#{resource_name.capitalize}Controller")
    return resource_name, controller_klass, action
  end
end
