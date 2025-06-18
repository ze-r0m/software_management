class InstalledSoftware < ApplicationRecord
  has_many :class_softwares, dependent: :destroy
  has_many :comp_classes, through: :class_softwares, source: :comp_class

  # TODO:проверить все поля валидации, провалидировать сроки лицензии

  validates :name, length: { maximum: 32 }, presence: true
  validates :version, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }, presence: true
  validates :note, length: { maximum: 8 }, allow_blank: true

  validates :keyholder, length: { maximum: 64 }, allow_blank: true
  validates :usage_basis, length: { maximum: 255 }, allow_blank: true

  VALID_PURPOSES = ["учебное", "обеспечивающее"]
  validate :purpose_is_valid

  validate :comp_class_ids_are_valid

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

  def purpose_is_valid
    if purpose.present?
      wrong_values = purpose - VALID_PURPOSES
      if wrong_values.any?
        errors.add(:purpose, "содержит недопустимые значения")
      end
    end
  end

  def comp_class_ids_are_valid
    return if comp_class_ids.blank?

    # Убедимся, что все ID существуют в базе
    valid_ids = CompClass.where(id: comp_class_ids).pluck(:id).map(&:to_s)
    invalid_ids = comp_class_ids.reject { |id| valid_ids.include?(id.to_s) }

    if invalid_ids.any?
      errors.add(:comp_classes, "содержит неверные аудитории")
    end
  end

  # Позволить использовать этот скоуп в Ransack
  def self.ransackable_scopes(_auth_object = nil)
    [:without_classes]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comp_classes"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "version", "start_date", "finish_date", "keyholder", "is_server", "pc_count_sum", "quantity" , "usage_basis"]
  end

end