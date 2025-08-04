class CreateCafedras < ActiveRecord::Migration[8.0]
  def change
    create_table :cafedras do |t|
      t.string :name, null: false
      t.text :description
      t.references :faculty, null: false, foreign_key: true

      t.timestamps
    end
    add_index :cafedras, :name, unique: true
  end
end