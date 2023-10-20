require 'pry'

class App
  attr_reader :logger

  def initialize
    # FIXME: load config/routes outside initialize method
    require_relative 'config/routes'
  end

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
