class Post < ApplicationRecord
  validates :title, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  validate :end_day_check

  def end_day_check
    if self.start_day.nil? || self.end_day.nil?
      return
    end
    errors.add(:end_day, "は開始日以前の登録はできません") if
    self.start_day > self.end_day
  end
end
