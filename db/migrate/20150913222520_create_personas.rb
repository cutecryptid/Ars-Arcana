class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :name
      t.integer :base_level
      t.references :arcana

      t.timestamps null: false
    end
  end
end
