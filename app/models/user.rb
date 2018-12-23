# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :events
  has_many :teams, through: :events
  has_many :teams_applications
  has_many :shifts
  has_many :availabilities

  ROLES = %i[user admin].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
