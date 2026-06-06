class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rooms, dependent: :destroy
  mount_uploader :icon, ImageUploader
  has_many :reservations, dependent: :destroy
end
