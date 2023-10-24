-- v1.0.4

-- Mute default Reputation level up sound
-- This code block creates a frame that listens to the "ADDON_LOADED" event and mutes the default reputation level up sound when the event is triggered.
local frame_a = CreateFrame("Frame")
frame_a:RegisterEvent("ADDON_LOADED")
frame_a:SetScript("OnEvent", function(self, event, ...)
	MuteSoundFile(568016) -- Mute the default reputation level up sound
end)

-- REPUTATION RANK UP
-- This code block creates a frame that listens to the "PLAYER_LOGIN", "UPDATE_FACTION", and "QUEST_LOG_UPDATE" events. It then checks the player's reputation with each faction and plays a sound when the reputation level goes up.
-- Table to track the standing of factions
local trackedFactions = {}

-- Create a frame to handle events
local frame_b = CreateFrame("Frame")

-- Register events to listen for
frame_b:RegisterEvent("PLAYER_LOGIN") -- Player login
frame_b:RegisterEvent("UPDATE_FACTION") -- Kill rep
frame_b:RegisterEvent("QUEST_LOG_UPDATE") -- Quest rep

-- Set the script to run when an event is triggered
frame_b:SetScript("OnEvent", function()
	-- Loop through all factions
	for i = 1, GetNumFactions() do
		-- Get information about the faction
		local _, _, newStanding, _, _, _, _, _, isHeader, _, hasRep, _, _, faction = GetFactionInfo(i)
		if faction and (not isHeader or hasRep) and (newStanding or 0) > 0 then
			-- Make sure we have the info we need and standing isn't UNKNOWN (0)
			local oldStanding = trackedFactions[faction]
			if oldStanding and oldStanding < newStanding then
				-- Check if standing went up (allow same code to initialize tracking)
				PlaySoundFile("Interface\\Addons\\FFRU\\FFRU.ogg", "Master") -- Play Level up Sound
			end
			trackedFactions[faction] = newStanding -- Update standing
		end
	end
end)

-- Chat Message
-- This code block creates a frame that listens to the "ADDON_LOADED" event and prints a message to the chat when the event is triggered.
local frame_c = CreateFrame("Frame")
frame_c:RegisterEvent("PLAYER_LOGIN")
frame_c:SetScript("OnEvent", function(self, event, text, ...)
	if event == "PLAYER_LOGIN" then
		print("|cff3bbc00FFRU - Final Fantasy Rep Up!|r Will no longer be receiving updates. Functionality has been merged into |c2d4b92ffBLU - Better Level Up!|r. If you're a fan of my sound addons, |c2d4b92ffBLU - Better Level Up!|r is available from all addon provider websites. Thank you!")
	end
end)
