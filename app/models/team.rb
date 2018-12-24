# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :bigint(8)
#


class Team < ApplicationRecord
  has_and_belongs_to_many :event, optional: true
  has_many :users, through: :events
  has_many :requirements
  has_many :teams_applications
end
