class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :user, optional: true
  has_many :teams
end
