local sversion = 1.0
local AutoUpdate = False
if myHero.charName ~= "Blitzcrank" then return end
require "SxOrbWalk"
require "VPrediction"
local Qrange, Qwidth 
local Qrange = 925
function OnLoad()
print("Welcome to Blitzcrank grabber 1!")
print("Script by Tom")
BlitzcrankMenu()
end
function BlitzcrankMenu( ... )
	-- body
Config = scriptConfig("Blitzcrank", "Blitzcrank")
Config:addSubMenu("Key Settings", "Keys")
Config.Keys:addParam("AutoGrab", "Auto Grab", SCRIPT_PARAM_ONKEYDOWN, false, 32)
Config:addSubMenu("Orbwalker", "Orbwalker")
Sx = SxOrbWalk()
Sx:LoadToMenu(Config.Orbwalker)
end
local VP = VPrediction()
local ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 900, DAMAGE_PHYSICAL)

function OnTick()
	ts:update()
	local target = ts.target
	if Config.Keys.AutoGrab then
		if myHero:CanUseSpell(_Q) == READY and ValidTarget(target, 925) then
			local CastPosition,  HitChance,  Position = VP:GetLineCastPosition(target, 0.25, 75, 925, 1800, myHero, true)
			if HitChance >= 2 then
				CastSpell(_Q, CastPosition.x, CastPosition.z)
				if myHero:CanUseSpell(_E) == READY and ValidTarget(target, 150) then CastSpell(_E) end
			end
		end
	end
end

  
