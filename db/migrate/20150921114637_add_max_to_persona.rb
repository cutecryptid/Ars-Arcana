class AddMaxToPersona < ActiveRecord::Migration
  def change
  	add_column :personas, :max, :boolean
  end
end
