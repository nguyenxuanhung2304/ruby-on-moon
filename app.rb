require 'erb'

class App
  def call(env)
    headers = {
      'Content-Type' => 'text/html'
    }

    status = 200

    title = get_title(env)
    response_html = ERB.new(html_template).result(binding)

    [status, headers, [response_html]]
  end

  private

  def html_template
    File.read('views/index.html.erb')
  end

  def get_title(env)
    query_string = env['QUERY_STRING']
    query_string.split('=')[1] || 'Weby'
  end
end
