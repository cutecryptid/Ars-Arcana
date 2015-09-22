class ArcanaFusionTwo < ActiveRecord::Base
	belongs_to :arcana, foreign_key: "result_arcana_id"
	has_one :arcana1, class_name: "Arcana", foreign_key: "id", primary_key: "arcana1_id"
	has_one :arcana2, class_name: "Arcana", foreign_key: "id", primary_key: "arcana2_id"
end
