class OpenaiService
  def initialize
    @client = OpenAI::Client.new access_token: ENV['OPEN_AI_TOKEN']
  end

  def transcribe_audio(file:)
    response = @client.audio.transcribe \
    parameters: {
      model: 'whisper-1',
      file: File.open(file.path, 'rb'),
      language: 'es'
    }
    response
  end
end
