--v1.0.0

  -- Mute default Reputation level up sound
local Event_Frame_A = CreateFrame("Frame")
Event_Frame_A:RegisterEvent("ADDON_LOADED")
Event_Frame_A:SetScript("OnEvent",
  function(self, event, ...)
  	MuteSoundFile(568016)
  end)

 -- REPUTATION RANK UP
local TrackedFactions={};
local Event_Frame_B=CreateFrame("Frame");
Event_Frame_B:RegisterEvent("PLAYER_LOGIN");			-- Player login
Event_Frame_B:RegisterEvent("UPDATE_FACTION");		-- Kill rep
Event_Frame_B:RegisterEvent("QUEST_LOG_UPDATE");	-- Quest rep

Event_Frame_B:SetScript("OnEvent",function()
	   for i=1,GetNumFactions() do
	       local _,_,newstanding,_,_,_,_,_,isheader,_,hasrep,_,_,faction=GetFactionInfo(i);
	       if faction and (not isheader or hasrep) and (newstanding or 0)>0 then-- Make sure we have the info we need and standing isn't UNKNOWN (0)
	           local oldstanding=TrackedFactions[faction];
	           if oldstanding and oldstanding<newstanding then-- Check if standing went up (allow same code to initialize tracking)
	                PlaySoundFile("Interface\\Addons\\FFRU\\FFRU.ogg", "Master");-- Play Level up Sound
	           end

	           TrackedFactions[faction]=newstanding;-- Update standing
	       end
	   end
end);
