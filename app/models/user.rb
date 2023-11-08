class User < ApplicationRecord
include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role:{user:0, admin:1}
  before_validation :set_default_role, on: :create

  has_many :leases
  has_many :books, through: :leases

  devise :database_authenticatable, :registerable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
         
  private
  def set_default_role
    self.role ||= :user
  end
end
