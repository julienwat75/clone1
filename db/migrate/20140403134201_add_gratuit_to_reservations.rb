class AddGratuitToReservations < ActiveRecord::Migration
  def change

  	add_column :reservations, :gratuit, :boolean
  end
end
