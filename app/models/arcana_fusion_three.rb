class ArcanaFusionThree < ActiveRecord::Base
	belongs_to :arcana, foreign_key: "result_arcana_id"
end
