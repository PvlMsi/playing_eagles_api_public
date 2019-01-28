class ScheduledEvent < ApplicationRecord
  belongs_to :pitch

  scope :todays, ->(date) { select { |se| se.today?(date) } }

  validates :pitch, presence: true
  validates :first_date, presence: true
  validates :last_date, presence: true
  validates :interval, presence: true
  validates :interval_type, presence: true
  validates :starting_hour, presence: true
  validates :finishing_hour, presence: true
  validates_inclusion_of :canceled, in: [true, false]

  INTERVAL_TYPES = [
    daily: 0,
    weekly: 1,
    monthly: 2
  ].freeze

  def today?(date)
    ((date.to_date - first_date.to_date).to_i % 7).zero?
  end
end
