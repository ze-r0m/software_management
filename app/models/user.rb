class User < ApplicationRecord
  belongs_to :role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  # если нужно, чтобы по-умолчанию новый юзер — модератор
  after_initialize do
    if new_record? && role.nil?
      self.role = Role.find_by(name: 'moderator')
    end
  end
end
