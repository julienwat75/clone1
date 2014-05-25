class AddPrixNormalToMultidate < ActiveRecord::Migration
  def change
  	 add_column :multidates, :prix_normal, :float
  end
end
