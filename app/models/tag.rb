class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :topics,   through: :taggings
end
