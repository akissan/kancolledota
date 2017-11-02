
Shield = class({})


LinkLuaModifier("shield_mod","mechanics/shield_mod.lua", LUA_MODIFIER_MOTION_NONE)

function Shield:GetIntrinsicModifierName() 
	return "shield_mod"
end
