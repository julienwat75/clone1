class AddDatelimiteToResa < ActiveRecord::Migration
  def change

  	add_column :reservations, :datelimite, :datetime

  end
end
