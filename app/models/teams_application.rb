# frozen_string_literal: true

# == Schema Information
#
# Table name: teams_applications
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  event_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint(8)
#  priority   :integer
#


class TeamsApplication < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :user, optional: true
  belongs_to :team
end
