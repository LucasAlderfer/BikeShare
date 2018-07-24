class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :role, require: true
  has_secure_password

  enum role: ['default', 'admin']
  has_many :orders
end
