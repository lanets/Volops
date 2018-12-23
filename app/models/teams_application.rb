# frozen_string_literal: true

class TeamsApplication < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :user, optional: true
  belongs_to :team
end
