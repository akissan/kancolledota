function Check_night(event)	
	local caster = event.caster
	local modifier = event.modifier
	local ability = event.ability
	--GameRules:SetTimeOfDay(120)
	if not GameRules:IsDaytime() then ability:ApplyDataDrivenModifier(caster, caster, modifier, {}) end
end