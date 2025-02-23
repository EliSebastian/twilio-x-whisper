

# Twilio x Whisper

Twilio x Whisper is a Ruby on Rails application that enables receiving voice messages via WhatsApp using Twilio, processing them with the OpenAI Whisper API for transcription, and returning the transcribed text to the sender.

## Features

-   Receives voice messages from WhatsApp using Twilio.
-   Sends the audio to the OpenAI Whisper API for transcription.
-   Returns the transcribed text to the sender via WhatsApp.
-   Implemented with Ruby on Rails.

## Prerequisites

Before deploying the project, ensure you have installed:

-   Ruby 3.x
-   Rails 8.x
-   Twilio Account (to send and receive WhatsApp messages)
-   OpenAI API Key (to use Whisper)

## Required Environment Variables

To ensure the project runs correctly, configure the following environment variables in a `.env` file:

```
TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_WHATSAPP_NUMBER=your_twilio_whatsapp_number
OPEN_AI_TOKEN=your_openai_api_key
```

## Deployment Steps

1.  Clone the repository:
    
    ```sh
    git clone https://github.com/your_username/twilio_x_whisper.git
    cd twilio_x_whisper
    
    ```
    
2.  Install dependencies:
    
    ```sh
    bundle install
    
    ```
  
    
3.  Configure environment variables:
    
    -   Create a `.env` file in the project's root directory.
    -   Add the variables listed in the previous section.
    
4.  Start the development server:
    
    ```sh
    rails server
    
    ```
    
5.  Configure Twilio Webhooks:
    
    -   In the Twilio console, go to the WhatsApp settings.
    -   Set the webhook URL to `https://your_application_url/receive_message`.
7.  Test the integration by sending a voice message to your Twilio WhatsApp number.
    

## Production Deployment

To deploy in production, you can use services like Heroku, Render, or a VPS. Ensure that you:

-   Set up the environment variables in the production environment.
-   Properly configure webhooks in Twilio with your production application URL.

## Contributions

If you'd like to contribute to the project, you can fork it, create a branch with your changes, and submit a pull request.

## License

This project is licensed under the MIT License.
