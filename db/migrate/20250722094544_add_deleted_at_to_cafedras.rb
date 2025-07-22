class AddDeletedAtToCafedras < ActiveRecord::Migration[8.0]
  def change
    add_column :cafedras, :deleted_at, :datetime
    add_index :cafedras, :deleted_at

  end
end
