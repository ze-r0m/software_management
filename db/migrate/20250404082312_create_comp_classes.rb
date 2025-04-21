class CreateCompClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :comp_classes do |t|
      t.string :aud_number, null: false
      t.integer :count_seat
      t.integer :count_comp_seat
      t.integer :count_comp
      t.text :spec_purpose
      t.boolean :projector
      t.boolean :panel
      t.boolean :ch_board
      t.text :add_note
      t.references :cafedra, null: false, foreign_key: true

      t.timestamps
    end
    add_index :comp_classes, :aud_number, unique: true
  end
end