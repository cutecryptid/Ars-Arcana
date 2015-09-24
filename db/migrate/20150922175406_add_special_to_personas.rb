class AddSpecialToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :special, :boolean
  end
end
