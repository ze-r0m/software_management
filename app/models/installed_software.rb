class InstalledSoftware < ApplicationRecord
  has_many :class_softwares, dependent: :destroy
  has_many :comp_classes, through: :class_softwares, source: :comp_class

  validates :name, :version, presence: true

  scope :without_classes, -> {
    where.not(id: ClassSoftware.select(:installed_software_id).distinct)
  }

  serialize :purpose, coder:JSON

  ransacker :pc_count_sum do
    Arel.sql(
      '(SELECT COALESCE(SUM(comp_classes.count_comp), 0)
      FROM class_softwares
      INNER JOIN comp_classes ON comp_classes.id = class_softwares.comp_class_id
      WHERE class_softwares.installed_software_id = installed_softwares.id)'
    )
  end

  def pc_count_sum
    comp_classes.sum(:count_comp)
  end

  # Позволить использовать этот скоуп в Ransack
  def self.ransackable_scopes(_auth_object = nil)
    [:without_classes]
  end


  def self.ransackable_associations(auth_object = nil)
    ["comp_classes"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "version", "start_date", "finish_date", "keyholder", "is_server", "pc_count_sum", "quantity"]
  end

end