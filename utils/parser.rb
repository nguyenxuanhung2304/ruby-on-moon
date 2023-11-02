# A module providing utility methods for parsing and handling resource controllers.
module Parser
  # Extract the resource controller, instance class, view template, and action from the request path.
  #
  # @return [Array] An array containing instance class, view template, and action.
  def resource_controller
    resource_name, controller_klass, action = make_controller_klass
    instance_klass = controller_klass.new(env, resource_name)
    view_template = "app/views/#{resource_name}/#{action}.html.erb"
    [instance_klass, view_template, action]
  end

  private

  # Constantize a class name to retrieve the actual class object.
  #
  # @param class_name [String] The name of the class to constantize.
  # @return [Class] The constantized class object.
  # @raise [NameError] if the class is not found or not a valid class.
  def constantize(class_name)
    klass = Object.const_get(class_name)
    raise NameError unless klass.is_a?(Class)

    klass
  end

  # Parse the path to extract resource name and action, and constantize the controller class.
  #
  # @return [Array] An array containing resource name, controller class, and action.
  def make_controller_klass
    resource_name, action = path.split(%r{/}).reject(&:empty?)
    controller_klass = constantize("#{resource_name.capitalize}Controller")
    [resource_name, controller_klass, action]
  end
end
