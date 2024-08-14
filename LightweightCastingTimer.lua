-- Author: Omx-Area52
-- Version: 2.2

local CastingTimerFormat = "(%0.2f/%0.2fs)";
local castingTimerFrame = CreateFrame("Frame", "castingTimerFrame", PlayerCastingBarFrame)
castingTimerFrame.Text = castingTimerFrame:CreateFontString()
castingTimerFrame.Text:SetFontObject(SystemFont_Shadow_Small)
castingTimerFrame.Text:SetPoint("RIGHT", PlayerCastingBarFrame, "RIGHT", 0, 0)
castingTimerFrame:Show()

local function PlayerCastingBarFrame_OnUpdate(self, elapsed)
	-- Exit if there is no timer.
	if self.value == null then
		return
	end	
	
	-- If the spell is casting or reverse channeling, add the current timer and the elapsed microseconds.
	if (self.casting or self.reverseChanneling) then
		local total = self.value + elapsed
		-- For debuggijng purpose
		-- print(self.value, total, self.maxValue, elapsed)
		
		-- Display the time left and the max casting time.
		castingTimerFrame.Text:SetText(format(CastingTimerFormat, total, self.maxValue))

	-- If the spell is channeling, subtract the elapsed microseconds from the current timer.
	elseif (self.channeling) then
		local total = self.value - elapsed;
		if ( self.value <= 0 ) then
			return
		end
		-- For debuggijng purpose
		-- print(self.value, total, self.maxValue, elapsed)
		
		-- Display the time left and the max casting time.
		castingTimerFrame.Text:SetText(format(CastingTimerFormat, total, self.maxValue))
	end
	
end

PlayerCastingBarFrame:HookScript("OnUpdate", PlayerCastingBarFrame_OnUpdate)
