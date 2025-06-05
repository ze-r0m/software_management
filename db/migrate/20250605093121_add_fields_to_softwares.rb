class AddFieldsToSoftwares < ActiveRecord::Migration[8.0]
  def change
    add_column :installed_softwares, :quantity, :integer
    add_column :installed_softwares, :usage_basis, :string
    add_column :installed_softwares, :purpose, :text
  end
end
