class Team < ApplicationRecord
  has_and_belongs_to_many :event, optional: true
  has_many :users, through: :events
  has_many :requirements
end
