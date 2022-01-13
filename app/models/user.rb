class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :icon,presence:true, on: :update
  validates :name,presence:true, on: :update
  validates :introduction,presence:true, on: :update

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :icon, IconUploader
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
end
