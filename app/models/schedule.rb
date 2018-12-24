# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  shift_id   :bigint(8)
#  team_id    :bigint(8)
#  event_id   :bigint(8)
#  comment    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#  mandatory  :boolean
#


class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  belongs_to :team
  belongs_to :event
end
