class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # deviseの設定はそのまま
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

