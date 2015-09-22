class CreateArcanaFusionTwos < ActiveRecord::Migration
  def change
    create_table :arcana_fusion_twos do |t|
      t.belongs_to :arcana1, :class_name => "Arcana"
      t.belongs_to :arcana2, :class_name => "Arcana"
      t.belongs_to :result_arcana, :class_name => "Arcana"

      t.timestamps null: false
    end
  end
end
