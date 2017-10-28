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
	elseif (damage<cur_shld) then
		caster:SetMana(cur_shld-damage)
		caster:SetHealth(caster:GetHealth() + damage)
	else
		caster:SetMana(0)
		print(damage-cur_shld)
		caster:SetHealth(caster:GetHealth() + cur_shld + (damage-cur_shld)*overkill_reduction ) 
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