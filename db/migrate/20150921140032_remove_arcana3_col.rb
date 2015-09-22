class RemoveArcana3Col < ActiveRecord::Migration
  def change
  	remove_column :arcana_fusion_threes, :arcana3
  end
end
