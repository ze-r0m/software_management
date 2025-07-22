class Cafedra < ApplicationRecord
  belongs_to :faculty
  has_many :comp_classes, dependent: :destroy
  has_many :request_softs, dependent: :destroy
  delegate :name, to: :faculty, prefix: true

  validates :name,
            presence: { message: "не может быть пустым" },
            uniqueness: { message: "уже существует" },
            length: { maximum: 255, message: "не может быть длиннее %{count} символов" }

  validates :add_note,
            length: { maximum: 255, message: "не может быть длиннее %{count} символов" }


  # Позволяем искать и сортировать по полю faculty.name
  def self.ransackable_attributes(auth_object = nil)
    ["name", "add_note"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["faculty"]
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