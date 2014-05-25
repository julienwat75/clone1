class AddTypeToMailgeneral < ActiveRecord::Migration
  def change

  	add_column :mailgenerals, :type_mail, :string

  end
end
