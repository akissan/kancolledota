function Shield(event)

 	local ability = event.ability
 	local caster = event.caster
	local min_capacity = caster:GetMaxMana()  * 0.1
	local overkill_reduction = ability:GetLevelSpecialValueFor("overkill_protection_tooltip", ability:GetLevel() - 1 ) * 0.01
	local damage = event.Damage
	local manaburn = 0
	local cur_shld = caster:GetMana()


	if (cur_shld < min_capacity) then
		caster:SetMana(math.max(cur_shld-damage,0))
		caster.HealthToHeal = 0
	elseif (damage<cur_shld) then
		caster:SetMana(cur_shld-damage)
		caster.HealthToHeal = damage
		if caster:GetHealth() < damage then
			caster:SetHealth(caster:GetHealth() + damage) 
			caster.HealthToHeal = 0
		end
 	else
		caster:SetMana(0)
		caster.HealthToHeal = cur_shld + (damage-cur_shld)*overkill_reduction 
	end

	if caster.HealthToHeal > 0 then
		SendOverheadEventMessage(caster, 12 , caster, caster.HealthToHeal , nil) 
	end
end

function Shield_visual( event )
	
	local ability = event.ability
	local caster = event.caster
	local min_capacity = caster:GetMaxMana()  * 0.1
	local cur_shld = caster:GetMana() 
	local modifier = event.modif

	if caster:HasModifier(modifier) == false and cur_shld>min_capacity then
        ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
    elseif caster:HasModifier(modifier) == true and cur_shld<min_capacity then
    	caster:RemoveModifierByName(modifier)
    end
end

function Shield_heal( event )
	local caster = event.caster
	caster:SetHealth(caster.HealthToHeal + caster:GetHealth() ) 
end