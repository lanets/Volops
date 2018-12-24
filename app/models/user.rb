# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  first_name             :string(255)      not null
#  last_name              :string(255)      not null
#  number                 :string(255)      not null
#  birthday               :date
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string(255)      default("user")
#


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

  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :number, presence: true
  validates :birthday, presence: true
  validates :email, presence: true

  ROLES = %i[user admin].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
