
AA_take_damage = class({})


LinkLuaModifier("AA_take_damage_mod","mechanics/AA_take_damage_mod.lua", LUA_MODIFIER_MOTION_NONE)

function  AA_take_damage:GetIntrinsicModifierName() 
	return "AA_take_damage_mod"
end

