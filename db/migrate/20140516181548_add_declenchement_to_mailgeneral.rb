class AddDeclenchementToMailgeneral < ActiveRecord::Migration
  def change

  	add_column :mailgenerals, :declenchement, :boolean

  	add_column :mailgenerals, :grade1, :integer

  	add_column :mailgenerals, :grade2, :integer

  	add_column :mailgenerals, :grade3, :integer

  	add_column :mailgenerals, :grade4, :integer


  end

end
