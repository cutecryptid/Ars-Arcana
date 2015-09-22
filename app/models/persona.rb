class Persona < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	belongs_to :arcana
	has_many :special_fusions

	def fusion_cost(fusion)
    	cost = 0
    	fusion.each do |ingr|
    		level = ingr.base_level
    		cost += (27 * level * level) + (126 * level) + 2147
    	end
    	return cost
    end

	def fuse2(persona1, persona2)
		arcana1 = persona1.arcana
		arcana2 = persona2.arcana

		level = 1 + ((persona1.base_level + persona2.base_level)/2).floor
		arcana_combo = ArcanaFusionTwo.where(:arcana1_id => arcana1.id, :arcana2_id => arcana2.id).first
		personas = arcana_combo.arcana.personas

		i = 0
		personas.each do |per|
			if (per.base_level >= level)
				next if per.special == 1
				break
			end
			i += 1
		end

		if (arcana1 == arcana2)
			i -= 1
		end

		if (personas[i] == persona1 || personas[i] == persona2)
			i -= 1
		end

		return personas[i]
	end

	def fuse3(persona1, persona2, persona3)
		arcana1 = persona1.arcana
		arcana2 = persona2.arcana
		arcana3 = persona3.arcana

		level = 5 + ((persona1.base_level + persona2.base_level + persona3)/3).floor
		arcana_combo = ArcanaFusionTwo.where(:arcana1_id => arcana1.id, :arcana2_id => arcana2_id).first
		arcana_combo_final = ArcanaFusionThree.where(:arcana1_id => arcana_combo.arcana.id, :arcana2_id => arcana3.id).first
		personas = arcana_combo.arcana.personas

		found = false
		i = 0
		personas.each do |per|
			if (per.base_level >= level)
				next if per.special == 1
				found = true
				break
			end
			i += 1
		end
		return nil if !found

		if(arcana1 == arcana && arcana2 == arcana && arcana3 == arcana)
			while (persona1.name == personas[i].name || persona2.name == personas[i].name || persona3.name == personas[i].name)
				i += 1
				return nil if (!personas[i])
			end
		end

		return personas[i]
	end

	def filter2Way(persona1, persona2, result)
    	return true if (persona1.name == self.name)
   		return true if (persona2.name == self.name)
    	return false if (result.name == self.name)
    	return true
    end

	def persona_recipes2(arcana)
		recipes = []
		combos = arcana.arcana_fusion_twos.includes(:arcana1).includes(:arcana2)
		combos.each do |combo|
			personas1 = combo.arcana1.personas
			personas2 = combo.arcana2.personas
			j = 0
			k = 0
			personas1.each do |p1|
				ar1 = p1.arcana
				personas2.each do |p2|
					ar2 = p2.arcana
					next if (ar1 == ar2 && (p1.base_level >= p2.base_level))
					result = fuse2(p1,p2)
					next if !result
					next if filter2Way(p1,p2,result)
					recipes << {:cost => fusion_cost([p1, p2]), :ingr => [p1, p2]}
				end
			end
		end
		return recipes
	end

	def persona_recipes3(arcana1, arcana2)
		recipes = []
		step1Recipes = persona_recipes2(arcana1)
		step1Recipes.each do |s1Recipe|
			p1 = s1Recipe[:ingr][0]
			p2 = s1Recipe[:ingr][1]
			personas = arcana2.personas
			personas.each do |p3|
				if persona3IsValid(p1,p2,p3)
					result = fuse3(p1,p2,p3)
					next if (!result || result.name != self.name)
					recipes << {:cost => fusion_cost([p1, p2, p3]), :ingr => [p1, p2, p3]}
				end
			end
		end
		return recipes
	end

	def persona3IsValid(p1,p2,p3)
		ar1 = p1.arcana
		ar2 = p2.arcana
		ar3 = p3.arcana

		return false if (p3 == p1)
		return false if (p2 == p1)

		return false if (p3.base_level < p1.base_level)
		return false if (p3.base_level < p2.base_level)

		if p3.base_level == p1.base_level
			return ar3.IntNumber < ar1.IntNumber
		end

		if p3.base_level == p2.base_level
			return ar3.IntNumber < ar2.IntNumber
		end

		return true
	end

	def get_recipes
		recipes = []
		self_arcana = self.arcana

		recipes += persona_recipes2(self_arcana)
		combos = self_arcana.arcana_fusion_threes.includes(:arcana1).includes(:arcana2)

		combos.each do |combo|
			ar1 = combo.arcana1
			ar2 = combo.arcana2
			recipes += persona_recipes3(ar1, ar2)
			if ar2 != ar1
				recipes += persona_recipes3(ar2, ar1)
			end
		end

		return recipes.sort_by { |h| h[:cost] }
	end
end
