class Cafedra < ApplicationRecord
  belongs_to :faculty
  has_many :comp_classes, dependent: :destroy
  has_many :request_softs, dependent: :destroy
  validates :name, presence: true

  delegate :name, to: :faculty, prefix: true


  # Позволяем искать и сортировать по полю faculty.name
  def self.ransackable_attributes(auth_object = nil)
    ["name", "add_note"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["faculty"]
  end

end