class Drone < ApplicationRecord
  belongs_to :profile
  has_many :match_drones, dependent: :destroy
end
