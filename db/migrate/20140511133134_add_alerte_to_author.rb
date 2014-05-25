class AddAlerteToAuthor < ActiveRecord::Migration
  def change

  	add_column :authors, :alerte, :boolean

  end
end
