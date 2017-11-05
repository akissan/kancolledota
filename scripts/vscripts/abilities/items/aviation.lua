function modfi_to_my_aviation( event )

	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1

	local ownerID = caster:GetPlayerID()
--	print(ownerID)
	local playerID = target:GetPlayerOwnerID()
--	print(playerID)

	local duration = ability:GetLevelSpecialValueFor("think_interval", ability_level)
	local modifier = event.modifier

	-- If the unit is owned by a player then apply the unit modifier
	if ownerID == playerID then
		ability:ApplyDataDrivenModifier(caster, target, modifier, {Duration = duration}) 
	end
end