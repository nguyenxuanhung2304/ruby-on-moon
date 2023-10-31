# The `Logging` class is responsible for logging information about HTTP requests and responses.
#
# This middleware class logs request and response details to a log file, including information
# about the route, controller, and view being processed.
class Logging
  # @!attribute [r] logger
  #   @return [Logger] The logger instance used for logging.
  attr_reader :logger

  # @!attribute [r] path
  #   @return [String] The path of the current request.
  attr_reader :path

  # @!attribute [r] env
  #   @return [Hash] The environment hash containing information about the HTTP request.
  attr_reader :env

  # Includes the Parser module for route parsing functionality.
  include Parser

  # Initializes a new instance of Logging.
  #
  # @param app [Object] The application or middleware to which this logger is attached.
  def initialize(app)
    @app = app
    @logger = make_logger
  end

  # Logs information about the HTTP request and response.
  #
  # @param env [Hash] The environment hash containing information about the HTTP request.
  # @return [Array] The HTTP response.
  def call(env)
    @path = env['REQUEST_PATH']
    @env = env
    make_log
    @app.call(env)
  end

  private

  # Creates a logger instance for logging.
  #
  # @return [Logger] A Logger instance for logging.
  def make_logger
    file_path = 'log/development.log'
    unless File.exist?(file_path)
      FileUtils.mkdir_p('log')
      File.new(file_path, 'w')
    end
    Logger.new(file_path)
  end

  # Logs information about the request and response.
  def make_log
    instance_klass, view_template, action = resource_controller
    request_method = env['REQUEST_METHOD']
    logger.info "Started: [#{request_method}] #{path}"
    logger.info "#{instance_klass.class.name}##{action}"
    logger.info "Rendered: #{view_template}"
  end
end
