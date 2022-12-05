class Comment < ApplicationRecord
  belongs_to :blog
  validates :talk, presence: true
end
