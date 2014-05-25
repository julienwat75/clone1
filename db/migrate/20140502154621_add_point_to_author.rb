class AddPointToAuthor < ActiveRecord::Migration
  def change

  	add_column :authors, :point_positif, :integer

  	add_column :authors, :point_negatif, :integer


  end
end
