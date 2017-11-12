modifier_cast_range_radar = class({})

function modifier_cast_range_radar:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
	}
	return funcs
end



function modifier_cast_range_radar:GetModifierCastRangeBonus( params )
	if self:GetAbility() ~= nil and self:GetAbility():GetSpecialValueFor("bonus_cast_range") ~= nil then
		return self:GetAbility():GetSpecialValueFor("bonus_cast_range") 
	else
		return 0
	end
end

function modifier_cast_range_radar:IsHidden() 
	return true
end