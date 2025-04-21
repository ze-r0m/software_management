class CreateRequestSofts < ActiveRecord::Migration[8.0]
  def change
    create_table :request_softs do |t|
      t.string :soft_name, null: false
      t.string :version, null: false
      t.integer :count, null: false
      t.decimal :price, precision: 10, scale: 2
      t.text :contact
      t.references :cafedra, null: false, foreign_key: true

      t.timestamps
    end
  end
end