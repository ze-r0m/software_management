class Cafedra < ApplicationRecord
  belongs_to :faculty
  has_many :comp_classes, dependent: :destroy
  has_many :request_softs, dependent: :destroy
  delegate :name, to: :faculty, prefix: true

  validates :name,
            presence: { message: "не может быть пустым" },
            uniqueness: { message: "уже существует" },
            length: { maximum: 255, message: "не может быть длиннее %{count} символов" }

  # TODO:: перевод поля по связи
  # validates :faculty, presence: { message: "должен быть выбран" }

  validates :add_note,
            length: { maximum: 255, message: "не может быть длиннее %{count} символов" }


  # Позволяем искать и сортировать по полю faculty.name
  def self.ransackable_attributes(auth_object = nil)
    ["name", "add_note"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["faculty"]
  end

end