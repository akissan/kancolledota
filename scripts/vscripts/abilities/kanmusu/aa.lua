function aa_increase(event)
	local caster = event.caster
	if event.target ~= nil then caster = event.target end
	local ability = event.ability
	local value = event.aa_value
	if caster.aa ~= nil then caster.aa = caster.aa + value else caster.aa = value end
	print("increased")
end

function aa_decrease(event)
	local caster = event.caster
	if event.target ~= nil then caster = event.target end
	local ability = event.ability
	local value = event.aa_value
	if caster.aa ~= nil then caster.aa = caster.aa - value else caster.aa = 0 end
	print("decreased")
end

function aa_refresh( event )
	local caster = event.caster
	if event.target ~= nil then caster = event.target end
	local ability = event.ability
	local value = 0
	if ability:GetLevel() ~= 1 then 
		local value = ability:GetLevelSpecialValueFor("aa_value", ability:GetLevel() - 2 )
	end
	if caster.aa ~= nil then caster.aa = caster.aa - value else caster.aa = 0 end
	value = ability:GetLevelSpecialValueFor("aa_value", ability:GetLevel() - 1 )
	if caster.aa ~= nil then caster.aa = caster.aa + value else caster.aa = value end
	print("refresed")
end

function aa_print( event )
	local caster = event.caster
	if event.target ~= nil then caster = event.target end
	if caster.aa ~= nil then 
	print(caster.aa)
	else print("AA error") end
end