class TwilioService
  def initialize
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']

    @client = Twilio::REST::Client.new @account_sid, @auth_token
  end

  def get_resource(url:)
    api_request url
  end

  def send_message(to:, body:)
    message = @client.messages.create \
      body:,
      to:,
      from: "whatsapp:#{ENV['TWILIO_WHATSAPP_NUMBER']}"
    message.sid
  end

  private

  def api_request(url)
    @uri = URI.parse url
    request = build_request

    response = Net::HTTP.start @uri.hostname, @uri.port, use_ssl: @uri.scheme == 'https', max_redirects: 3 do |http|
      http.request request
    end

    handle_redirection(response) || save_resource(response)
  end

  def build_request
    request = Net::HTTP::Get.new @uri
    request.basic_auth @account_sid, @auth_token
    request
  end

  def handle_redirection(response)
    if response.is_a? Net::HTTPRedirection
      location = response['location']
      return api_request location
    end

    nil
  end

  def save_resource(resource)
    extension = extension_by content_type: resource.content_type
    file = Tempfile.new ['resource', extension]
    file.binmode
    file.write resource.body
    file.rewind
    file
  end

  def extension_by(content_type:)
    mappings = {
      audio: audio_mappings,
      image: image_mappings,
      video: video_mappings,
      document: document_mappings
    }

    content_type_mapping = mappings.values.reduce(&:merge)
    content_type_mapping[content_type] || raise('Unsupported content type')
  end

  def audio_mappings
    {
      'audio/mpeg' => '.mp3', 'audio/ogg' => '.ogg', 'audio/wav' => '.wav', 'audio/webm' => '.webm'
    }
  end

  def image_mappings
    {
      'image/jpeg' => '.jpg', 'image/png' => '.png', 'image/gif' => '.gif'
    }
  end

  def video_mappings
    {
      'video/mp4' => '.mp4', 'video/webm' => '.webm', 'video/ogg' => '.ogv'
    }
  end

  def document_mappings
    {
      'application/pdf' => '.pdf', 'application/msword' => '.doc', 'application/vnd.ms-excel' => '.xls'
    }
  end
end
