class Arcana < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: :slugged
	has_many :personas, dependent: :destroy
	has_many :arcana_fusion_twos
	has_many :arcana_fusion_threes
end
