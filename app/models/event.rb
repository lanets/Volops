# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  # belongs_to :user, optional: true
  has_many :teams
  has_many :teams_applications
  has_many :shifts
  has_many :requirements
  has_many :schedules
end
