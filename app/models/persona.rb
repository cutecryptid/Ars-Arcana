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

	def fuse2(arcana, persona1, persona2, arcana1, arcana2)
		level = 1 + ((persona1.base_level + persona2.base_level)/2).floor
		personas = arcana.personas

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

	def fuse3(arcana, persona1, persona2, persona3, arcana1, arcana2, arcana3)
		level = 5 + ((persona1.base_level + persona2.base_level + persona3.base_level)/3).floor
		arcana_combo = ArcanaFusionTwo.where(:arcana1_id => arcana1.id, :arcana2_id => arcana2.id).first
		personas = arcana.personas

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
			while (persona1 == personas[i] || persona2 == personas[i] || persona3 == personas[i])
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

	def persona_recipes2(persona, arcana)
		recipes = []
		combos = arcana.arcana_fusion_twos.includes(:arcana1).includes(:arcana2)
		combos.each do |combo|
			ar1 = combo.arcana1
			ar2 = combo.arcana2
			personas1 = ar1.personas.sort_by{|p| p.base_level}
			personas2 = ar2.personas.sort_by{|p| p.base_level}
			personas1.each do |p1|
				personas2.each do |p2|
					next if (ar1 == ar2 && (p1.base_level >= p2.base_level))
					result = fuse2(arcana, p1,p2, ar1, ar2)
					next if !result
					next if filter2Way(p1,p2,result)
					recipes << {:cost => fusion_cost([p1, p2]), :ingr => [p1, p2]}
				end
			end
		end
		return recipes
	end

	def arcana_recipes(arcana)
		recipes = []
		combos = arcana.arcana_fusion_twos
		combos.each do |combo|
			ar1 = combo.arcana1
			ar2 = combo.arcana2
			personas1 = ar1.personas.sort_by{|p| p.base_level}
			personas2 = ar2.personas.sort_by{|p| p.base_level}
			personas1.each do |p1|
				personas2.each do |p2|
					next if (ar1 == ar2 && (p1.base_level >= p2.base_level))
					result = fuse2(arcana, p1,p2, ar1, ar2)
					next if !result
					recipes << {:cost => fusion_cost([p1, p2]), :ingr => [p1, p2]}
				end
			end
		end
		return recipes
	end

	def persona_recipes3(persona, arcana)
		recipes = []
		combos = arcana.arcana_fusion_threes.includes(:arcana1).includes(:arcana2)
		combos.each do |combo|
			artmp = combo.arcana1
			ar3 = combo.arcana2
			recipes += aux_recipes3(ar3, artmp, persona)
			if artmp != ar3
				recipes += aux_recipes3(artmp, ar3, persona)
			end
		end
		return recipes
	end

	def aux_recipes3(arcana1,arcana2, persona)
		recipes = []
		pers = arcana1.personas
		ar3 = arcana2
		step1Recipes = arcana_recipes(ar3)
		step1Recipes.each do |rec|
			p1 = rec[:ingr][0]
			p2 = rec[:ingr][1]
			ar1 = p1.arcana
			ar2 = p2.arcana
			pers.each do |p3|
				result = fuse3(arcana, p1, p2, p3, ar1, ar2, ar3)
				next if (!result || result != persona)
				recipes << {:cost => fusion_cost([p1, p2, p3]), :ingr => [p1, p2, p3]}
			end
		end
		return recipes
	end

	def persona3IsValid(p1,p2,p3,ar1,ar2,ar3)
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

		recipes += persona_recipes2(self, self_arcana)
		#recipes += persona_recipes3(self, self_arcana)

		return recipes.sort_by { |h| h[:cost] }
	end
end
