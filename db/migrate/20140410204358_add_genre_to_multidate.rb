class AddGenreToMultidate < ActiveRecord::Migration
  def change

  	add_column :multidates, :genre, :string

  end
end
