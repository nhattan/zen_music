class OneSignal
  attr_accessor :message

  def initialize options = {}
    @message = options[:message]
  end

  def response
    response = http.request(request)
    response_body = JSON.parse response.body
    if response.code == '200'
    else
    end
  end

  def params
    {
      "app_id" => ENV["APP_ID"],
      "contents" => {"en" => message},
      "included_segments" => ["All"]
    }
  end

  def request
    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json',
                                  'Authorization' => "Basic #{ENV['API_KEY']}")
    request.body = params.as_json.to_json
    request
  end

  private

  def http
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http
  end

  def uri
    URI.parse('https://onesignal.com/api/v1/notifications')
  end
end
