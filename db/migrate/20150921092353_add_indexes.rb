class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :personas, :slug, unique: true
  	add_index :arcanas, :slug, unique: true
  end
end
