class User < ApplicationRecord
  has_secure_password
  has_many :document

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password

end
