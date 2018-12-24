# frozen_string_literal: true

# == Schema Information
#
# Table name: availabilities
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  shift_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Availability < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :shift
end
