class AddSlugToArcanas < ActiveRecord::Migration
  def change
    add_column :arcanas, :slug, :string
  end
end
