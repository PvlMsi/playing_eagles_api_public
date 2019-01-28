class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  belongs_to :pitch
  belongs_to :user

  after_create :create_positions

  scope :upcoming, -> { where('date >= ?', Time.now).order(date: :asc) }
  scope :todays, ->(date) { select{ |g| g.date.to_date == date } }

  def create_positions
    2.times do
      players.create(position: 0) # goal_keeper
      forwards = ((players_quantity - 1) / 2).times { players.create(position: 2) }
      (players_quantity - 1 - forwards).times { players.create(position: 1) } # defenders
    end
  end

  def seats_left
    players.where(user: nil)
  end

  def seats_taken
    players.where.not(user: nil)
  end
end
