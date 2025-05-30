class User < ApplicationRecord
  belongs_to :role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  attr_accessor :change_password

  # Валидации
  validates :username,
            presence: { message: "не может быть пустым" },
            uniqueness: { message: "уже занят" },
            length: { in: 2..20, message: "должен быть от 2 до 20 символов" }

  validates :role_id, presence: { message: "должна быть выбрана" }

  validate :password_presence_if_needed

  # По умолчанию новый пользователь — модератор (если роль не указана)
  after_initialize do
    if new_record? && role.nil?
      self.role = Role.find_by(name: 'moderator')
    end
  end

  private

  # Проверка пароля только если нужно сменить пароль (change_password == '1')
  def password_presence_if_needed
    return unless change_password.to_s == '1'

    if password.blank?
      errors.add(:password, "не может быть пустым")
    end

    if password_confirmation.blank?
      errors.add(:password_confirmation, "не может быть пустым")
    end

    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:password_confirmation, "не совпадает с паролем")
    end
  end
end
