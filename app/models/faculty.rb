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
end