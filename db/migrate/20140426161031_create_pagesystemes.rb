class CreatePagesystemes < ActiveRecord::Migration
  def change
    create_table :pagesystemes do |t|
      t.boolean :ouverture_invitation 
      t.timestamps
    end
  end
end
