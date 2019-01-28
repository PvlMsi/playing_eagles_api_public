class SendMessageWorker
  include Sidekiq::Worker

  def perform(user_id, game_id)
    TwilioService.new.send_sms(user_id, game_id)
  end
end
