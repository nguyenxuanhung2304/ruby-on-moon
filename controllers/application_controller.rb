require 'erb'

class ApplicationController
  attr_reader :env, :params, :resource_name

  def initialize(env, resource_name)
    @env = env
    @params = build_params(env)
    @resource_name = resource_name
  end

  # def index
  #   render :index
  # end
  #
  def show
    # render :show
  end

  def render(view_template)
    erb = ERB.new(File.read(view_template))
    puts "view_template = #{view_template}"
    erb.result(get_binding)
  end


  private

  def build_params(env)
    query_string = env['QUERY_STRING']
    return {} if query_string.empty?

    URI.decode_www_form(query_string).to_h
  end

  def get_binding
    binding
  end
end
