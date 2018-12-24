# frozen_string_literal: true

# == Schema Information
#
# Table name: shifts
#
#  id         :bigint(8)        not null, primary key
#  start_time :datetime
#  end_time   :datetime
#  event_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Shift < ApplicationRecord
  belongs_to :event, optional: true
  has_and_belongs_to_many :users
  has_many :requirements
  has_many :availabilities

  def shift_name
    "#{start_time.strftime('%A %B %d - %k:%M')} to #{end_time.strftime('%A %B %d - %k:%M')}"
  end
end
