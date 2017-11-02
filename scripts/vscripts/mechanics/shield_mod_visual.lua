shield_mod_visual = class({})

function shield_mod_visual:GetEffectName()
	return "particles/units/abilities/shield.vpcf"
end 

function shield_mod_visual:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function shield_mod_visual:OnDestroy()
 	ParticleManager:CreateParticle("particles/units/abilities/shield_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function shield_mod_visual:OnCreated()
	ParticleManager:CreateParticle("particles/units/abilities/shield_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent()) --[[Returns:int
	Creates a new particle effect
	]]
end