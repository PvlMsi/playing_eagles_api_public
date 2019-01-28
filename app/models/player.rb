class Player < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :game
  has_many :opinion

  validates :game, presence: true
  validates :position, presence: true

  delegate :fullname, to: :user, prefix: false

  def sign_me(user_id)
    self.user_id = user_id
    save
  end
end
