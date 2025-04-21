class ClassSoftware < ApplicationRecord
  belongs_to :comp_class
  belongs_to :installed_software
  validates_uniqueness_of :comp_class_id, scope: :installed_software_id
end