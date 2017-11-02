
class_ability_index = 1

function Plane_slots_create(event)
	--GameRules:SetTimeOfDay(0)
	local caster = event.caster
	local ability = caster:GetAbilityByIndex(class_ability_index)
	local modifier = event.modifier
	local plane_count = event.plane_count
	caster.max_plane_slots = plane_count 
	caster.cur_plane_slots = plane_count

	ability:ApplyDataDrivenModifier(caster, caster, modifier,{})
	caster:SetModifierStackCount(modifier, caster, plane_count)
end


function Carry_slots_create(event)

	local caster = event.caster
	local ability = caster:GetAbilityByIndex(class_ability_index)
	local modifier = event.modifier
	local carry = event.carry
	caster.max_carry = carry 
	caster.cur_carry = 0

	ability:ApplyDataDrivenModifier(caster, caster, modifier,{})
	caster:SetModifierStackCount(modifier, caster, carry)
end

function Check_NP( event )

	local caster = event.caster
	local ability = caster:GetAbilityByIndex(class_ability_index)
	local modifier = event.modifier
	local modifier_visual = event.modifier_visual
	local buff_count  = 0
	local NP_multiplier = event.NP_multiplier
	local cur_count = 0

	if not GameRules:IsDaytime() then

		ability:ApplyDataDrivenModifier(caster, caster, modifier_visual, {})
		buff_count = math.floor(caster:GetAgility() * NP_multiplier) 

	else

		if caster:HasModifier(modifier_visual) then caster:RemoveModifierByName(modifier_visual) end
		buff_count = 0
	end

	for i=0, caster:GetModifierCount() do
		if caster:GetModifierNameByIndex(i) == modifier then 
			cur_count = cur_count + 1
		end
	end
	--print(cur_count," ", buff_count)
	if cur_count > buff_count then 
		for i=1, cur_count - buff_count do caster:RemoveModifierByName(modifier) end
	elseif cur_count < buff_count then
		for i=1, buff_count - cur_count do ability:ApplyDataDrivenModifier(caster, caster, modifier, {} ) end
	end
end

function Check_overweight( event )

	local caster = event.caster
	local ability = caster:GetAbilityByIndex(class_ability_index)
	
	local modifier = event.modifier
	local modifier_visual = event.modifier_visual   
	local cur_carry = 0
	for i = 0, 5 do 
		local item = caster:GetItemInSlot(i)
		if item~=nil then 
			local weight = item:GetSpecialValueFor("weight")
			cur_carry = cur_carry + weight
		end
	end

	local overweight = cur_carry - caster.max_carry
	local delta = cur_carry - caster.cur_carry

 	if delta ~= 0 then

		for i = 0, caster:GetModifierCount() do 
			imodifier = caster:GetModifierNameByIndex(i)
			if imodifier == modifier then caster:RemoveModifierByName(modifier) end 
		end

		if overweight>0 then

			if not caster:HasModifier(modifier_visual) then ability:ApplyDataDrivenModifier(caster,caster, modifier_visual, {}) end
		 	caster:SetModifierStackCount(modifier_visual, caster, overweight)
			for i = 1, overweight do ability:ApplyDataDrivenModifier(caster, caster, modifier, {}) end
		else
			if caster:HasModifier(modifier_visual) then caster:RemoveModifierByName(modifier_visual) end
		end
	end

	caster.cur_carry = cur_carry
end
--[[ if overweight>0 then

		if not caster:HasModifier(modifier_visual) then ability:ApplyDataDrivenModifier(caster,caster, modifier_visual, {}) end
	
		if delta>0 then 

			for i = 1,  delta do ability:ApplyDataDrivenModifier(caster, caster, modifier, {} ) end
		
		elseif delta<0 then

			delta = -delta
			
			for i = 1, delta do caster:RemoveModifierByName(modifier) end
		
		end

	else

		overweight = -overweight 
		
		if caster:HasModifier(modifier_visual) then caster:RemoveModifierByName(modifier_visual) end
		
		if delta<0 then 
			delta = -delta 
			for i=1, delta do caster:RemoveModifierByName(modifier) end
		end
	end

--		for i = caster.cur_carry, cur_carry do ability:ApplyDataDrivenModifier(caster, caster, modifier, {}) end
--	elseif caster:HasModifier(modifier_visual) then caster:RemoveModifierByName(modifier_visual) end 

	caster.cur_carry = cur_carry
]]--

--	if cur_carry>caster.max_carry then ability:ApplyDataDrivenModifier(caster, caster, modifier_visual, {}) elseif cur_carry<=caster.max_carry and caster:HasModifier(modifier_visual) then caster:RemoveModifierByName(modifier_visual) end

