function air_radar( event )
	local caster = event.caster
	local radius = event.radius
	local ability = event.ability
	
	local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius,  DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_CREEP, 0, 0, false)
	local modifier = event.modifier
	for i,unit in pairs(units) do 
		local label = unit:GetUnitLabel()
		if label == "dive_bomber" or label == "torpedo_bomber" or label == "fighter" then
			ability:ApplyDataDrivenModifier(caster, unit, modifier, { Duration = event.duration }) 
			AddFOWViewer(caster:GetTeamNumber(), unit:GetAbsOrigin(), radius/10, event.duration, false)
		end
	end
end

LinkLuaModifier("modifier_cast_range_radar","mechanics/modifier_cast_range_radar.lua", LUA_MODIFIER_MOTION_NONE)

function add_modifier( event )

	local caster = event.caster
	local ability = event.ability
	local modifier = "modifier_cast_range_radar"

	if caster:HasModifier( modifier ) then
		caster:RemoveModifierByName( modifier )
	end
	caster:AddNewModifier(caster, ability, modifier , {} ) 
	print("add_cast_range")
end

function remove_modifier( event )
	local caster = event.caster
	caster:RemoveModifierByName("modifier_cast_range_radar")
	print("removed_cast_range")
	for i=0,5 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetSharedCooldownName() == "surface_radar" then 
			add_modifier({caster = caster, ability = item})
			print("replaced_cast_range")
		end
	end
end