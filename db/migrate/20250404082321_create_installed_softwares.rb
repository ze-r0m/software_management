class CreateInstalledSoftwares < ActiveRecord::Migration[8.0]
  def change
    create_table :installed_softwares do |t|
      t.string :name
      t.string :version
      t.date :start_date
      t.date :finish_date

      t.timestamps
    end
  end
end
