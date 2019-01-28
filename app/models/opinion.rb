class Opinion < ApplicationRecord
  belongs_to :player
  belongs_to :issuing_user, class_name: 'User', optional: true
end
