class User < ActiveRecord::Base
  has_secure_password
  has_many :books
# Every user must have a username, email and password
  validates :username,:email,:password, presence: true
 # The same email can't belong to multiple users
  validates :email, uniqueness: true
end
