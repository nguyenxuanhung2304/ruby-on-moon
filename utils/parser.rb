require 'pry'

module Parser
  def resource_controller
    resource_name, controller_klass, action = make_controller_klass
    instance_klass = controller_klass.new(env, resource_name)
    view_template = "views/#{resource_name}/#{action}.html.erb"
    [instance_klass, view_template, action]
  end

  private

  def constantize(class_name)
    klass = Object.const_get(class_name)
    raise NameError unless klass.is_a?(Class)

    klass
  end

  def make_controller_klass
    resource_name, action = path.split(%r{/}).reject(&:empty?)
    controller_klass = constantize("#{resource_name.capitalize}Controller")
    [resource_name, controller_klass, action]
  end
end
