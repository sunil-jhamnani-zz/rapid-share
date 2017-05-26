class User < ApplicationRecord
  has_secure_password
  has_many :document

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_length_of :email, :maximum => 256
  validates_format_of :email, :with => /^.+@.+$/, :multiline => true
  validates_presence_of :password
  validates_length_of :password, :minimun =>6, :maximum => 20

end
