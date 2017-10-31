shield_mod = class({})

function shield_mod:DeclareFunctions(  )
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}

	return funcs
end

function shield_mod:OnTakeDamage( keys )
	if IsServer() then 
		for key, value in pairs(keys) do print(key, value) end
		if keys.damage_type ~= DAMAGE_TYPE_PHYSICAL then return else
			local damage = keys.damage
			local hero = self:GetParent()
			local cur_shield = hero:GetMana()  
			local max_shield = hero:GetMaxMana()
			local ability = self:GetAbility()
			local overkill_reduction = ability:GetLevelSpecialValueFor("overkill_protection_tooltip", ability:GetLevel() - 1 ) * 0.01

			print(overkill_reduction)
			print(ability)
			if cur_shield < max_shield/10 then hero:SetMana(math.max(cur_shield - damage, 0)) return else
				if damage < cur_shield then
					hero:SetMana(cur_shield - damage)
					hero:Heal(damage, hero)
				else 
					hero:SetMana(0)
					hero:Heal(cur_shield + (damage - cur_shield)*overkill_reduction, hero )
				end
			end
		end
	end
end
