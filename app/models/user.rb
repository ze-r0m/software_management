class User < ApplicationRecord
  belongs_to :role
  validates :username, :email, presence: true, uniqueness: true
end