class SpecialFusion < ActiveRecord::Base
  belongs_to :persona
  serialize :ingr
end
