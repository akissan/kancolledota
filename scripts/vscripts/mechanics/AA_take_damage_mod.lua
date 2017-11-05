AA_take_damage_mod = class({})


function AA_take_damage_mod:DeclareFunctions(  )
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}

	return funcs
end

function AA_take_damage_mod:IsHidden() 
	return true
end

function AA_take_damage_mod:OnTakeDamage( keys )
	if IsServer() and self:GetParent() == keys.unit and keys.damage_flags ~= DOTA_DAMAGE_FLAG_REFLECTION then 
		--for key, value in pairs(keys) do print(key, value) end
		
		local caster = self:GetParent()
		local enemy = keys.attacker
		local dmg = keys.damage
		local aa = 0
		if enemy.aa ~= nil then aa = enemy.aa  end 
		local abil = keys.ability

		print(math.log(		math.abs(aa)) * math.log(math.abs(aa)) * 10 / math.abs(math.sqrt(math.sqrt(math.abs(dmg/2))) - 1)    ) 
		
		local damage =
			{
				victim = caster,
				attacker = enemy,
				damage = math.log(math.abs(aa)) * math.log(math.abs(aa)) * 10 / math.abs(math.sqrt(math.sqrt(math.abs(dmg/2))) - 1)    ,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
				ability = abil
			}

		ApplyDamage( damage )
	end
end
