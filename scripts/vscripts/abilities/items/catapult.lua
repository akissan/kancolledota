function catapult_add( event )
	local caster = event.caster
	local additional_slots = event.additional_slots
	if caster.max_plane_slots ~= 0 then 
		print(additional_slots)
		caster.max_plane_slots = caster.max_plane_slots + additional_slots end

end

function catapult_destroy( event )
	local caster = event.caster
	local additional_slots = event.additional_slots
	if caster.max_plane_slots ~= 0 then 
		print(additional_slots)
		caster.max_plane_slots = caster.max_plane_slots - additional_slots end

end