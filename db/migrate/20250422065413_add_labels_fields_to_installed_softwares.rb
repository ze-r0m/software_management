class AddLabelsFieldsToInstalledSoftwares < ActiveRecord::Migration[8.0]
  def change
    add_column :installed_softwares, :keyholder, :text
    add_column :installed_softwares, :is_server, :boolean, default: false
    add_column :installed_softwares, :note, :string, limit: 8
  end
end
