--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("RhahkZor", 36)
if not mod then return end
mod:RegisterEnableMob(644)
mod:SetAllowWin(true)
mod.dungeonId = 644

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "Rhahk'Zor"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{6304, "TANK"}, -- Slam
	}
end

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Log("SPELL_CAST_SUCCESS", "Slam", 6304)
	self:Log("SPELL_AURA_APPLIED", "SlamDebuff", 6304)

	self:Death("Win", 644)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	-- FIXME: need a proper timer on this
	-- self:CDBar(6304, 15)
	if self.AIBar then
		self:AIBar(6304, 1)
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Slam()
	-- FIXME: need a proper timer on this
	-- self:CDBar(6304, 15)
	if self.AIBar then
		self:AIBar(6304)
	end
end

function mod:SlamDebuff(args)
	self:TargetMessage2(6304, "purple", args.destName)
end
