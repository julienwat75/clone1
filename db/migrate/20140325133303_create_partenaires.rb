class CreatePartenaires < ActiveRecord::Migration
  def change
    create_table :partenaires do |t|

     t.string  :nom
     t.string  :email
     t.string  :adresse
     t.string  :telephone
     t.string  :ville
     t.timestamps
    end
  end
end
