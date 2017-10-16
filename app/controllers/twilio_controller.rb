class TwilioController < ApplicationController
  def voice
    twiml = Twilio::TwiML::VoiceResponse.new do |r|
      r.say("Calling #{params['Member']} from the #{params['Chamber']}, please wait.", voice: 'woman', language: 'en')
      if params['To'] and params['To'] != ''
        number = params['To']
        r.dial(caller_id: ENV['TWILIO_CALLER_ID']) do |d|
          if number =~ /^[\d\+\-\(\) ]+$/
            d.number(number)
          else
            d.client(number)
          end
        end
      else
        r.say('Thanks for calling!')
      end
    end

    render xml: twiml
  end

  def token
    capability     = Twilio::JWT::ClientCapability.new ENV['TWILIO_ACCOUNT_SID'],
                                                       ENV['TWILIO_AUTH_TOKEN']
    outgoing_scope = Twilio::JWT::ClientCapability::OutgoingClientScope.new(ENV['TWILIO_TWIML_APP_SID'])
    incoming_scope = Twilio::JWT::ClientCapability::IncomingClientScope.new('congress-browser')
    capability.add_scope(outgoing_scope)
    capability.add_scope(incoming_scope)

    result = {
      token: capability.to_jwt
    }

    render json: result
  end

end
