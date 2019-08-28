class UserLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location, dependent: :destroy
end
