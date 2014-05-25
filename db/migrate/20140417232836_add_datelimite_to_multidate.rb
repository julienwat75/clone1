class AddDatelimiteToMultidate < ActiveRecord::Migration
  def change

  	add_column :multidates, :datelimite, :datetime

  end
end
