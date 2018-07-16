class Availability < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :shift
end
