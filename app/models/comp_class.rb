class CompClass < ApplicationRecord
  belongs_to :cafedra
  has_many :class_softwares, dependent: :destroy
  has_many :installed_softwares, through: :class_softwares
  has_many :request_soft_auds, dependent: :destroy
  has_many :request_softs, through: :request_soft_auds

  validates :aud_number, presence: true, uniqueness: true

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

end