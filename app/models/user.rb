class User < ApplicationRecord
  belongs_to :role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  attr_accessor :change_password

  # если нужно, чтобы по-умолчанию новый юзер — модератор
  after_initialize do
    if new_record? && role.nil?
      self.role = Role.find_by(name: 'moderator')
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_sign_in_at", "current_sign_in_ip",
     "email", "encrypted_password", "id", "id_value", "last_sign_in_at",
     "last_sign_in_ip", "remember_created_at", "reset_password_sent_at",
     "reset_password_token", "role_id", "sign_in_count", "updated_at", "username"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[role]
  end
end
