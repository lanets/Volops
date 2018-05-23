class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  
  ROLES = %w[user moderator admin]

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
end
