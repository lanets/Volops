class Shift < ApplicationRecord
  belongs_to :event, optional: true
  has_and_belongs_to_many :users
  has_many :requirements

  def shift_name
    "#{start_time} - #{end_time}"
  end
end
