class RequestSoftAud < ApplicationRecord
  belongs_to :request_soft
  belongs_to :comp_class
  validates_uniqueness_of :request_soft_id, scope: :comp_class_id
end