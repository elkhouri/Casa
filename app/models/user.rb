class User < ActiveRecord::Base
  validates :name, presence:true
  validates :ID_num, presence:true, uniqueness:true
  has_secure_password
  validates :password, length: { minimum: 6 }
end
