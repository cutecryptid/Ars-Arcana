class Arcana < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: :slugged
	has_many :personas, dependent: :destroy
	has_many :arcana_fusion_twos, foreign_key: "result_arcana_id"
	has_many :arcana_fusion_threes, foreign_key: "result_arcana_id"
end
