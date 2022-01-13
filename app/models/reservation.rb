class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def how_long
    (end_date.to_i - start_date.to_i) / 60 / 60 / 24 
  end

  def total_amount
    room.price * number_of_people * (end_date.to_i - start_date.to_i) / 60 / 60 / 24
  end

  validates :start_date, presence:true
  validates :end_date, presence:true
  validates :number_of_people, presence:true, numericality: {greater_than: 0,less_than: 100, message: "は1~99の値を入力してください"}
  validate :start_date_after_today
  validate :end_date_after_today
  validate :end_date_after_start_day

  def start_date_after_today
    return if start_date.blank?
    errors.add(:start_date, "は今日より後の日付を選択してください") if start_date < Date.today
  end
  
  def end_date_after_today
    return if end_date.blank?
    errors.add(:end_date, "は今日より後の日付を選択してください") if end_date < Date.today
  end
  
  def end_date_after_start_day
    return if start_date.blank? || end_date.blank?
    errors.add(:end_date, "は開始日より後の日付を選択してください") if start_date > end_date
  end  
end
