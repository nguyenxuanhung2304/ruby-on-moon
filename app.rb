require_relative 'config/routes'
require 'logger'
require 'pry'
require 'fileutils'

class App
  attr_reader :logger

  def call(env)
    headers = { 'Content-Type' => 'text/html' }

    response_html = router.build_response(env)

    [200, headers, [response_html]]
  end

  private

  def router
    Router.instance
  end
end
