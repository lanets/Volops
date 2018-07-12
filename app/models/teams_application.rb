class TeamsApplication < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :user, optional: true
  has_one :team
end
