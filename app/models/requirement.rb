# frozen_string_literal: true

class Requirement < ApplicationRecord
  belongs_to :shift
  belongs_to :team
  belongs_to :event, optional: true
end
