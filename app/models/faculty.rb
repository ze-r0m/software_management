class Faculty < ApplicationRecord
  has_many :cafedras, dependent: :destroy
  validates :name,
            presence: { message: "не может быть пустым" },
            uniqueness: { message: "уже существует" },
            length: { maximum: 255, message: "не может быть длиннее %{count} символов" }
  validates :add_note,
            length: { maximum: 255, message: "не может быть длиннее %{count} символов" }

  # Разрешаем Ransack искать по этим полям
  def self.ransackable_attributes(auth_object = nil)
    ["name", "add_note"]
  end

  # Мягкое удаление
  scope :not_deleted, -> { where(deleted_at: nil) }

  def soft_delete!
    update(deleted_at: Time.current)
  end

  def restore!
    update(deleted_at: nil)
  end

  def soft_deleted?
    deleted_at.present?
  end
end