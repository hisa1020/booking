class Room < ApplicationRecord
  mount_uploader :img, ImgUploader

  belongs_to :users, optional: true
  has_many :reservations, dependent: :destroy

  validates :name,presence:true
  validates :context,presence:true
  validates :price,presence:true, numericality: {greater_than: 99,less_than: 10000001, message: "は100~10,000,000の値を入力してください"}
  validates :address,presence:true
  validates :img,presence:true
  
end
