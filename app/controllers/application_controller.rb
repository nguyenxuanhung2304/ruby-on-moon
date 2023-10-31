require 'erb'

# The `ApplicationController` class serves as a base controller
class ApplicationController
  # @!attribute [r] env, params, resource_name
  # @return [Hash] The environment hash containing information about the HTTP request.
  # @return [Hash]  The request parameters parsed from the query string.
  # @return [String] The name of the resource associated with the controller.
  attr_reader :env, :params, :resource_name

  # Initialize a new instance of ApplicationController
  #
  # @param env [Hash] The environment hash containing information about the HTTP request.
  # @param resource_name [String] The name of the resource associated with the controller.
  def initialize(env, resource_name)
    @env = env
    @params = build_params(env)
    @resource_name = resource_name
  end

  # Renders a view template using ERB (Embedded Ruby) rendering engine.
  #
  # @param view_template [String] The path to the ERB view template file.
  # @return [String] The rendered HTML content.
  def render(view_template)
    erb = ERB.new(File.read(view_template))
    erb.result(binding)
  end

  private

  # Parses query string from the environment and converts it into a hash of parameters.
  #
  # @param env [Hash] The environment hash containing information about the HTTP request.
  # @return [Hash] A hash of request parameters.
  def build_params(env)
    query_string = env['QUERY_STRING']
    return {} if query_string.empty?

    URI.decode_www_form(query_string).to_h
  end
end
