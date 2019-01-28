class Pitch < ApplicationRecord
  has_many :caretakers
  has_many :scheduled_events do
    def get_by_date(date)
      todays(date)
    end
  end
  has_many :games
  has_and_belongs_to_many :users

  default_scope { order(:city, :address) }

  validates :city, presence: true
  validates :address, presence: true
  validates :opening_hour, presence: true
  validates :closing_hour, presence: true
end
