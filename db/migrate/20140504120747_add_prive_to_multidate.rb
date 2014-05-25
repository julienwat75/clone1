class AddPriveToMultidate < ActiveRecord::Migration
  def change

  	add_column :multidates, :privee, :boolean

  end
end
