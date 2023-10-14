require 'erb'

class App
  def call(env)
    headers = {
      'Content-Type' => 'text/html'
    }

    status = 200

    html_response = File.read('views/index.html')

    [status, headers, [html_response]]
  end
end
