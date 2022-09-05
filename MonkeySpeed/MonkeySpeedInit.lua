-- define the dialog box for reseting config
StaticPopupDialogs["MONKEYSPEED_RESET"] = {
	text = TEXT(MONKEYSPEED_CONFIRM_RESET),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		MonkeySpeed_ResetConfig();
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(MONKEYSPEED_RESET_MSG);
		end
	end,
	timeout = 0,
	exclusive = 1
};


-- Script array, not saved
MonkeySpeed = {};
MonkeySpeed.m_iDeltaTime = 0;

MonkeySpeed.m_fSpeed = 0.0;
MonkeySpeed.m_fSpeedDist = 0.0;
MonkeySpeed.m_bLoaded = false;
MonkeySpeed.m_bVariablesLoaded = false;
MonkeySpeed.m_strPlayer = "";
MonkeySpeed.m_vCurrPos = {};
MonkeySpeed.m_bCalibrate = false;


function MonkeySpeed_Init()
		
	-- double check that we didn't already load
	if ((MonkeySpeed.m_bLoaded == false) and (MonkeySpeed.m_bVariablesLoaded == true)) then
		
		-- add the realm to the "player's name" for the config settings
		MonkeySpeed.m_strPlayer = GetCVar("realmName").."|"..MonkeySpeed.m_strPlayer;
		
		if (not MonkeySpeedConfig) then
			MonkeySpeedConfig = { };
		end
		
		-- now we're ready to calculate speed
		MonkeySpeed.m_vLastPos = {};
		MonkeySpeed.m_vLastPos.x, MonkeySpeed.m_vLastPos.y = GetPlayerMapPosition("player");

		-- if there's not an entry for this
		if (not MonkeySpeedConfig[MonkeySpeed.m_strPlayer]) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer] = {};
		end
		
		-- set the defaults if the values weren't loaded by the SavedVariables.lua
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = true;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = true;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = true;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_fUpdateRate == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_fUpdateRate = 0.5;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode = false;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked = false;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth = 46;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bAllowRightClick == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bAllowRightClick = true;
		end

		-- quel fix to make the contnum an index into the ZoneBaseline table
		if (MonkeySpeedConfig.m_ZoneBaseline == nil) then
			MonkeySpeedConfig.m_ZoneBaseline = {
				{
					{zid=1, rate=0.001820806197639339}, 
					{zid=2, rate=0.002070324492350493}, 
					{zid=3, rate=0.00257938203064122}, 
					{zid=4, rate=0.003218462697409648}, 
					{zid=5, rate=0.001602772251815587}, 
					{zid=6, rate=0.009919632925743617}, 
					{zid=7, rate=0.00233507039989314}, 
					{zid=8, rate=0.001985697927468335}, 
					{zid=9, rate=0.001999796525950309}, 
					{zid=10, rate=0.001825523256178235}, 
					{zid=11, rate=0.00151013203661447}, 
					{zid=12, rate=0.004544952454872465}, 
					{zid=13, rate=0.002043558777672257}, 
					{zid=14, rate=0.007482227560327402}, 
					{zid=15, rate=0.003013038216415093}, 
					{zid=16, rate=0.002150478811359044}, 
					{zid=17, rate=0.001521947904195967}, 
					{zid=18, rate=0.00206195789926347}, 
					{zid=19, rate=0.001035929721086861}, 
					{zid=20, rate=0.009938937314186113}, 
					{zid=21, rate=0.002386269972812934}, 
					{zid=22, rate=0.01005761601713153},
					{zid=23, rate=0.002838146668839583},
					{zid=24, rate=0.001478499888969668},
					{zid=25, rate=0.0001}
				},
				{
					{zid=1, rate=0.003750287711962299}, 
					{zid=2, rate=0.002916654945165441}, 
					{zid=3, rate=0.004221287078060015}, 
					{zid=4, rate=0.00313459219957742}, 
					{zid=5, rate=0.003586150398380203}, 
					{zid=6, rate=0.004200751773520065}, 
					{zid=7, rate=0.002133008700431164}, 
					{zid=8, rate=0.003885132686676924}, 
					{zid=9, rate=0.00271264820476215}, 
					{zid=10, rate=0.003024722496557702}, 
					{zid=11, rate=0.002131914883329001}, 
					{zid=12, rate=0.003181724673004079}, 
					{zid=13, rate=0.00328166290809318},
					{zid=14, rate=0.01327348777806501}, 
					{zid=15, rate=0.003156057393687188},
					{zid=16, rate=0.003805413709648072},
					{zid=17, rate=0.004836815394038805},
					{zid=18, rate=0.004703745601507035}, 
					{zid=19, rate=0.008677712100068411}, 
					{zid=20, rate=0.002500077023455918}, 
					{zid=21, rate=0.007814862958740681}, 
					{zid=22, rate=0.00164592404573333}, 
					{zid=23, rate=0.004577432693871465}, 
					{zid=24, rate=0.002727237845309258}, 
					{zid=25, rate=0.002324102645181357}, 
					{zid=26, rate=0.01093611527111662},
					{zid=27, rate=0.002441762127737395},
					{zid=28, rate=0.003002128405179666},
					{zid=29, rate=0.002539378551295865},
					{zid=30, rate=0.0001}
				},
				{
					{zid=1, rate=0.001935700289836371}, 
					{zid=2, rate=0.00203318351992493}, 
					{zid=3, rate=0.001900039363242876}, 
					{zid=4, rate=0.001883515186843005}, 
					{zid=5, rate=0.001909060476440717}, 
					{zid=6, rate=0.008039272332136098}, 
					{zid=7, rate=0.001944384338958065}, 
					{zid=8, rate=0.002088313733170485}, 
					{zid=9, rate=0.0001}, 
					{zid=10, rate=0.0001} 
				}
			};
		end
		
		if (MonkeySpeedConfig.m_SpecialZoneBaseline == nil) then
			MonkeySpeedConfig.m_SpecialZoneBaseline = {
					[MONKEYSPEED_BLACKROCK] = 0.0002983199214410154,
					[MONKEYSPEED_WARSONG] = 0.009159138767039199,
					[MONKEYSPEED_ALTERAC] = 0.002477872662261515,
					[MONKEYSPEED_ARATHI] = 0.005978692329518227
			};
		end
		
		-- show or hide the right options
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay) then
			MonkeySpeedFrame:Show();
		else
			MonkeySpeedFrame:Hide();
		end
		
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent) then
			MonkeySpeedText:Show();
		else
			MonkeySpeedText:Hide();
		end
		
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar) then
			MonkeySpeedBar:Show();
		else
			MonkeySpeedBar:Hide();
		end

		MonkeySpeedSlash_CmdSetWidth(MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth);
		
		-- All variables are loaded now
		MonkeySpeed.m_bLoaded = true;
		
		-- print out a nice message letting the user know the addon loaded
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(MONKEYSPEED_LOADED);
		end
	end
end

function MonkeySpeed_ResetConfig()
	-- set the defaults if the values weren't loaded by the SavedVariables.lua
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = true;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = true;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = true;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_fUpdateRate = 0.5;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode = false;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked = false;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth = 46;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bAllowRightClick = true;
	
	-- show or hide the right options
	-- update the frame
	MonkeySpeedFrame:ClearAllPoints();
	--MonkeySpeedFrame:SetPoint("TOP", "UIParent", "BOTTOMLEFT", 400, 384);
	MonkeySpeedFrame:SetPoint("TOP", "UIParent", "TOP", 150, 0);
	MonkeySpeedFrame:Show();
	
	MonkeySpeedText:Show();
	MonkeySpeedBar:Show();

	MonkeySpeedSlash_CmdSetWidth(MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth);
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end
