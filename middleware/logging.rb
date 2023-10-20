require 'logger'

class Logging
  attr_reader :logger, :path, :env

  include Parser

  def initialize(app)
    @app = app
    @logger = make_logger
  end

  def call(env)
    @path = env['REQUEST_PATH']
    @env = env
    make_log
    @app.call(env)
  end

  private

  def make_logger
    file_path = 'log/development.log'
    unless File.exist?(file_path)
      FileUtils.mkdir_p('log')
      File.new(file_path, 'w')
    end
    Logger.new(file_path)
  end

  def make_log
    instance_klass, view_template, action = resource_controller
    request_method = env['REQUEST_METHOD']
    logger.info "Started: [#{request_method}] #{path}"
    logger.info "#{instance_klass.class.name}##{action}"
    logger.info "Rendered: #{view_template}"
  end
end
