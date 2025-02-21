class ReceiveMessageController < ApplicationController
  def create
    twilio_service = TwilioService.new
    resource = twilio_service.get_resource url: params[:MediaUrl0]

    openai_service = OpenaiService.new
    response = openai_service.transcribe_audio file: resource

    message = twilio_service.send_message to: params[:From], body: response['text']

    render json: { message: }, status: :ok
  end
end
