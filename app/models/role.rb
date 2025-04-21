class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :role_name, presence: true, uniqueness: true
end