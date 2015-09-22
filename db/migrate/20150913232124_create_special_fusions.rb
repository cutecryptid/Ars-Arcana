class CreateSpecialFusions < ActiveRecord::Migration
  def change
    create_table :special_fusions do |t|
    	t.integer 'components', array: true
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
