class User < ApplicationRecord
  has_secure_password
  has_many :games
  has_many :players
  has_and_belongs_to_many :pitches
  has_many :opinions, through: :players
  has_many :issued_opinions, class_name: 'Opinion'
  has_many :scheduled_events

  validates :email, presence: true, uniqueness: true

  def fullname
    "#{first_name} #{last_name}"
  end
end
