class CreateFaculties < ActiveRecord::Migration[8.0]
  def change
    create_table :faculties do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :faculties, :name, unique: true
  end
end
