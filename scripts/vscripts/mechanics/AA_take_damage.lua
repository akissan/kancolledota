
aa_take_damage = class({})


LinkLuaModifier("modifier_aa_take_damage","mechanics/modifier_aa_take_damage.lua", LUA_MODIFIER_MOTION_NONE)

function  aa_take_damage:GetIntrinsicModifierName() 
	return "modifier_aa_take_damage"
end

