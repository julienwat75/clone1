class AddCodeToMultidate < ActiveRecord::Migration
  def change
   add_column :multidates, :code, :string
  end
end
