class TwilioService
  def initialize
    account_sid = ENV['TWILIO_ACC_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @from = ENV['TWILIO_SENDER_NUMBER']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def send_sms(user_id, game_id)
    game = Game.find(game_id)
    user = User.find(user_id)
    @client.messages.create(
      from: @from,
      to: user.phone_number,
      body:
        "Czesc #{user.first_name}!\n" \
        "Pamietaj, ze dzisiaj o godzinie #{game.date.strftime('%H:%M')} " \
        "grasz mecz na boisku #{game.pitch.address}, #{game.pitch.city}"
    )
  end
end