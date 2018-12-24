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

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures first name presence' do
      user = User.new(
        last_name: 'Last',
        number: '514-123-4567',
        birthday: '1962-06-26',
        email: 'hello@example.com',
        password: "allo123",
        password_confirmation: "allo123",
        role: "user"
        ).save
      expect(user).to eq(false)
    end

    it 'ensures last name presence' do
      user = User.new(
        first_name: 'First',
        number: '514-123-4567',
        birthday: '1962-06-26',
        email: 'hello@example.com',
        password: "allo123",
        password_confirmation: "allo123",
        role: "user"
        ).save
      expect(user).to eq(false)
    end

    it 'ensures phone number presence' do
      user = User.new(
        first_name: 'First',
        last_name: 'Last',
        birthday: '1962-06-26',
        email: 'hello@example.com',
        password: "allo123",
        password_confirmation: "allo123"
        ).save
      expect(user).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new(
        first_name: 'First',
        last_name: 'Last',
        number: '514-123-4567',
        birthday: '1962-06-26',
        password: "allo123",
        password_confirmation: "allo123"
        ).save
      expect(user).to eq(false)
    end

    it 'should have saved successfully' do
      user = User.new(
        first_name: 'First',
        last_name: 'Last',
        number: '514-123-4567',
        birthday: '1962-06-26',
        email: 'hello@example.com',
        password: "allo123",
        password_confirmation: "allo123"
        )
      user.skip_confirmation!
      user_save = user.save
      expect(user_save).to eq(true)
    end

  end

  context 'scope tests' do 
  end
end
