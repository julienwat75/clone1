class AddLimitePayanteToAuthor < ActiveRecord::Migration
  def change

  	add_column :authors, :limite_payante, :boolean

  end
end
