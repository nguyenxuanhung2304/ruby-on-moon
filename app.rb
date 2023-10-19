require_relative './router'
require_relative './config/routes'

class App
  def call(env)
    headers = {
      'Content-Type' => 'text/html'
    }

    status = 200

    response_html = router.build_response(env)

    [status, headers, [response_html]]
  end

  private

  def get_title(env)
    query_string = env['QUERY_STRING']
    query_string.split('=')[1] || 'Ruby on Moon'
  end

  def router
    Router.instance
  end
end
