
class_ability_index = 1

function Plane_slots_create(event)
	GameRules:SetTimeOfDay(0)
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
	caster.cur_carry = carry

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
		print(caster:GetModifierNameByIndex(i))
	end

	if cur_count > buff_count then 
		for i=0, cur_count - buff_count do caster:RemoveModifierByName(modifier) end
	elseif cur_count < buff_count then
		for i=0, buff_count - cur_count do ability:ApplyDataDrivenModifier(caster, caster, modifier, {} ) end
	end




end