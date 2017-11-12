function skilled_personnel_cooldown(event)
	local cd = event.cd
	local caster = event.caster
	
	for i=0,6 do
		local ability = caster:GetAbilityByIndex(i)
		if ability ~= nil then
			local cooldown = ability:GetCooldownTimeRemaining()
			if cooldown > cd then 
				ability:EndCooldown() 
				ability:StartCooldown(cooldown - cd)
			elseif cooldown>0 then ability:EndCooldown() end
		end
	end 

	for i=0,5 do
		local ability = caster:GetItemInSlot(i)
		if ability ~= nil then
			local cooldown = ability:GetCooldownTimeRemaining()
			if cooldown > cd then ability:StartCooldown(cooldown - cd)
			elseif cooldown>0 then ability:EndCooldown() end
		end
	end 	
end

