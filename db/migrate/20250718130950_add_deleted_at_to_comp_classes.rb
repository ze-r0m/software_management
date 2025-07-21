class AddDeletedAtToCompClasses < ActiveRecord::Migration[8.0]
  def change
    add_column :comp_classes, :deleted_at, :datetime
    add_index :comp_classes, :deleted_at
  end
end
