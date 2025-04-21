class RequestSoft < ApplicationRecord
  belongs_to :cafedra
  has_many :request_soft_auds, dependent: :destroy
  has_many :comp_classes, through: :request_soft_auds

  validates :soft_name, :version, :count, presence: true
end