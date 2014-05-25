class AddHtmlToMailgenaral < ActiveRecord::Migration
  def change

  	add_column :mailgenerals, :mailhtml, :boolean

  end
end
