class CreateClassSoftwares < ActiveRecord::Migration[8.0]
  def change
    create_table :class_softwares do |t|
      t.references :comp_class, null: false, foreign_key: true
      t.references :installed_software, null: false, foreign_key: true

      t.timestamps
    end
    add_index :class_softwares, [:comp_class_id, :installed_software_id], unique: true, name: 'index_class_software_unique'
  end
end