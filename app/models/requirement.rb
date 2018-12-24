# frozen_string_literal: true

# == Schema Information
#
# Table name: requirements
#
#  id         :bigint(8)        not null, primary key
#  shift_id   :bigint(8)
#  mandatory  :integer
#  optional   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint(8)
#  team_id    :bigint(8)
#


class Requirement < ApplicationRecord
  belongs_to :shift
  belongs_to :team
  belongs_to :event, optional: true
end
