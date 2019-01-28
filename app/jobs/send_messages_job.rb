class SendMessagesJob < ApplicationJob
  queue_as :default

  def perform
    games = Game.upcoming.select { |g| g.date.to_date == Date.current }
    games.each do |game|
      game.players.joins(:user).where.not(user: nil, users: { phone_number: nil }).each do |player|
        SendMessageWorker.perform_async(player.user.id, game.id)
      end
    end
  end
end
