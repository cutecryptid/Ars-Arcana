class AddIntNumberToArcana < ActiveRecord::Migration
  def change
    add_column :arcanas, :IntNumber, :integer
  end
end
