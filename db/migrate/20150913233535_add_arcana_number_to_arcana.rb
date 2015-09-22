class AddArcanaNumberToArcana < ActiveRecord::Migration
  def change
  	change_table :arcanas do |t|
  		t.string :number
  	end
  end
end
