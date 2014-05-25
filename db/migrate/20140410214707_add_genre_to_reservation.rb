class AddGenreToReservation < ActiveRecord::Migration
  def change

  	add_column :reservations, :genre, :string

  end
end
