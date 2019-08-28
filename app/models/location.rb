class Location < ApplicationRecord
  has_many :user_locations
  has_one :user, through: :user_locations
end
