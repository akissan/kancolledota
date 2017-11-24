class_ability_index = 3

function AA_initialize( event )
	local caster = event.caster
	local modifier = event.modifier
	local ability = event.ability
	local init_aa = event.init_aa
	ability:ApplyDataDrivenModifier(caster, caster, modifier, {}) 
	caster:SetModifierStackCount(modifier, caster, init_aa)
	caster.aa = init_aa
end

function AA_show( event )
	local caster = event.caster
	local ability = event.ability
	local modifier = event.modifier
	if caster.aa ~= nil then caster:SetModifierStackCount(modifier, caster, caster.aa ) end
end



function Plane_slots_create(event)

	local caster = event.caster
	local ability = caster:GetAbilityByIndex(class_ability_index)
	local modifier = event.modifier
	local plane_count = event.plane_count
	caster.max_plane_slots = plane_count 
	if plane_count>0 then 
		ability:ApplyDataDrivenModifier(caster, caster, modifier,{})
		caster:SetModifierStackCount(modifier, caster, plane_count)
	end
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

function Check_plane_slots( event )
	
	local caster = event.caster
	local ability = caster:GetAbilityByIndex(class_ability_index)
	
	local modifier = event.modifier
	local cur_plane_count = 0
	local modifier_visual = event.modifier_visual

	--caster:RemoveModifierByName("modifier")

	for i = 0, 5 do 
		local item = caster:GetItemInSlot(i)
		if item~=nil then 
			local plane_count = 0
			plane_count = item:GetSpecialValueFor("plane_count")
			if plane_count~=nil then cur_plane_count = cur_plane_count + plane_count end
		end
	end

	local overplane = cur_plane_count - caster.max_plane_slots 
	
	if caster.max_plane_slots>0 then
		caster:SetModifierStackCount(modifier_visual, caster, -overplane)
	end

	if overplane > 0 then  
		if not caster:HasModifier(modifier) then ability:ApplyDataDrivenModifier(caster, caster, modifier, {} ) end
	else
		if caster:HasModifier(modifier) then  caster:RemoveModifierByName(modifier) end
	end



end

function Check_overweight( event )

	local caster = event.caster
	local ability = caster:GetAbilityByIndex(class_ability_index)
	local modifier_stacks = event.modifier_stacks
	local modifier = event.modifier
	local modifier_visual = event.modifier_visual   
	local cur_carry = 0

	for i = 0, 5 do 
		local item = caster:GetItemInSlot(i)
		if item~=nil then 
			local weight = item:GetSpecialValueFor("weight")
			if weight~= nil then
				cur_carry = cur_carry + weight
			end 
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
	caster:SetModifierStackCount(modifier_stacks, caster, caster.max_carry - cur_carry)
end