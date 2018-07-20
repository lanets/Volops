class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  belongs_to :team
  belongs_to :event
end
