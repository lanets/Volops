class Shift < ApplicationRecord
  belongs_to :event, optional: true
  has_and_belongs_to_many :users
  has_many :requirements
  has_many :availabilities

  def shift_name
    "#{start_time.strftime('%a %b %d %k:%M%P')} - #{end_time.strftime('%a %b %d %k:%M%P')}"
  end
end
