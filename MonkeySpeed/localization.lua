--[[
	MonkeySpeed:
	A speedometer.

	Website:	http://toctastic.net/
	Author:		Trentin (trentin@toctastic.net)

	German Translation:	JimBim
--]]

-- English
MONKEYSPEED_TITLE			= "MonkeySpeed";
MONKEYSPEED_VERSION		= "2.8";
MONKEYSPEED_TITLE_VERSION	= MONKEYSPEED_TITLE .. " v" .. MONKEYSPEED_VERSION;
MONKEYSPEED_DESCRIPTION		= "Displays your speed as a \npercentage of run speed.";
MONKEYSPEED_LOADED			= "|cffffff00" .. MONKEYSPEED_TITLE .. " v" .. MONKEYSPEED_VERSION .. " loaded";
MONKEYSPEED_OPTIONS1		= "Please install MonkeyBuddy to configure your MonkeySpeed easily.";
MONKEYSPEED_OPTIONS2		= "\124TInterface\\Icons\\Trade_Engineering:0\124t MonkeyBuddy is currently not installed.";

MONKEYSPEED_CONFIRM_RESET	= "Okay to reset " .. MONKEYSPEED_TITLE .. " settings to default values?";

MONKEYSPEED_CHAT_COLOUR	= "|cff00ff00";
MONKEYSPEED_RESET_MSG		= MONKEYSPEED_CHAT_COLOUR .. MONKEYSPEED_TITLE .. ": Settings reset.";


-- Special zone names
MONKEYSPEED_BLACKROCK		= "Blackrock Mountain";
MONKEYSPEED_WARSONG		= "Warsong Gulch";
MONKEYSPEED_ALTERAC		= "Alterac Valley";
MONKEYSPEED_ARATHI			= "Arathi Basin";


if (GetLocale() == "deDE") then

	MONKEYSPEED_DESCRIPTION		= "Zeigt Eure Geschwindigkeit als \neinen Prozentsatz der grade \ngef\195\188hrten Geschwindigkeit.";
	MONKEYSPEED_LOADED			= "|cffffff00" .. MONKEYSPEED_TITLE .. " v" .. MONKEYSPEED_VERSION .. " geladen";
	MONKEYSPEED_OPTIONS1		= "Bitte installiere MonkeyBuddy um dein MonkeySpeed einzustellen.";
	MONKEYSPEED_OPTIONS2		= "\124TInterface\\Icons\\Trade_Engineering:0\124t MonkeyBuddy ist derzeit nicht installiert.";

	MONKEYSPEED_CONFIRM_RESET	= "Die Einstellungen von " .. MONKEYSPEED_TITLE .. " wirklich zur\195\188cksetzen?";
	
	MONKEYSPEED_RESET_MSG		= MONKEYSPEED_CHAT_COLOUR .. MONKEYSPEED_TITLE .. ": Einstellungen zur\195\188ckgesetzt.";

	
	-- Special zone names
	MONKEYSPEED_BLACKROCK		= "Der Blackrock";
	MONKEYSPEED_WARSONG		= "Warsongschlucht";
	MONKEYSPEED_ALTERAC		= "Alteractal";
	MONKEYSPEED_ARATHI			= "Arathibecken";

end