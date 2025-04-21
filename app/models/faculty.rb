class Faculty < ApplicationRecord
  has_many :cafedras, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  # Разрешаем Ransack искать по этим полям
  def self.ransackable_attributes(auth_object = nil)
    ["name", "add_note"]
  end
end