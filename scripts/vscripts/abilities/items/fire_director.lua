function detect( event )
	local caster = event.caster
	local radius = event.radius
	local ability = event.ability
	local particleName = "particles/units/heroes/hero_gyrocopter/gyro_base_attack.vpcf"
	local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 700,  DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false)
	
	for i,unit in pairs(units) do 
		local label = unit:GetUnitLabel()
		if label == "dive_bomber" or label == "torpedo_bomber" or label == "fighter" then
			local info = 
			{
				Target = unit,
				Source = caster,
				Ability = ability,	
				EffectName = particleName,
				iMoveSpeed = 1100,
				vSpawnOrigin = caster:GetAbsOrigin(),
				bDodgeable = true,
			}
			ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end