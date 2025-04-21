class CreateRequestSoftAuds < ActiveRecord::Migration[8.0]
  def change
    create_table :request_soft_auds do |t|
      t.references :request_soft, null: false, foreign_key: true
      t.references :comp_class, null: false, foreign_key: true

      t.timestamps
    end
    add_index :request_soft_auds, [:request_soft_id, :comp_class_id], unique: true, name: 'index_request_soft_auds_unique'
  end
end