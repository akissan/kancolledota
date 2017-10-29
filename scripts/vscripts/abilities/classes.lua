function Plane_slots_create(event)
	local caster = event.caster
	local ability = event.ability
	local plane_count = event.plane_count
	local modifier_main 	= 	"modifier_plane_slots_free"
	local modifier_visual 	=	"modifier_plane_slots_visual"

	ability:ApplyDataDrivenModifier(caster, caster, modifier_visual, {} )
	caster:SetModifierStackCount(modifier_visual, caster, plane_count)
	
	local caster = event.caster
	local ability = caster:GetAbilityByIndex(1)
	local modifier = event.modifier
	local plane_count = event.plane_count
	caster.max_plane_slots = plane_count 
	caster.cur_plane_slots = plane_count

	ability:ApplyDataDrivenModifier(caster, caster, modifier,{})
	caster:SetModifierStackCount(modifier, caster, plane_count)
end
