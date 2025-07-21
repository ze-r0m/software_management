class CompClass < ApplicationRecord
  belongs_to :cafedra
  has_many :class_softwares, dependent: :destroy
  has_many :installed_softwares, through: :class_softwares
  has_many :request_soft_auds, dependent: :destroy
  has_many :request_softs, through: :request_soft_auds

  validates :aud_number, presence: true, uniqueness: true
  validates :aud_number, format: {
    with: /\A\d{1,2}-\d{2,3}[а-я]?\z/i,
    message: "может быть только в таких форматах:  Ц-ЦЦЦ, Ц-ЦЦЦб, ЦЦ-ЦЦЦ, ЦЦ-ЦЦЦб"
  }

  validates :cafedra_id, presence: true
  validates :count_seat, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :count_comp, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :count_comp_seat, presence: true, numericality: { only_integer: true, greater_than: 0 }

  delegate :name, to: :cafedras, prefix: true

  # Позволяем искать и сортировать
  def self.ransackable_attributes(auth_object = nil)
    ["aud_number", "count_seat", "count_comp_seat", "count_comp", "spec_purpose", "projector",
     "panel", "ch_board"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["cafedra"]
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