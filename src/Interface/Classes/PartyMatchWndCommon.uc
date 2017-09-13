//================================================================================
// PartyMatchWndCommon.
//================================================================================

class PartyMatchWndCommon extends UIScript;

function string GetAmbiguousLevelString (int a_Level, bool a_HasSpace)
{
	local string AmbiguousLevelString;

	if ( UnknownFunction151(10,a_Level) )
	{
		if ( a_HasSpace )
		{
			AmbiguousLevelString = "1 ~ 9";
		} else {
			AmbiguousLevelString = "1~9";
		}
	} else {
		if ( UnknownFunction151(70,a_Level) )
		{
			if ( a_HasSpace )
			{
				AmbiguousLevelString = UnknownFunction112(UnknownFunction112(string(UnknownFunction144(UnknownFunction145(a_Level,10),10))," ~ "),string(UnknownFunction146(UnknownFunction144(UnknownFunction145(a_Level,10),10),9)));
			} else {
				AmbiguousLevelString = UnknownFunction112(UnknownFunction112(string(UnknownFunction144(UnknownFunction145(a_Level,10),10)),"~"),string(UnknownFunction146(UnknownFunction144(UnknownFunction145(a_Level,10),10),9)));
			}
		} else {
			if ( a_HasSpace )
			{
				AmbiguousLevelString = UnknownFunction112("70 ~ ",string(80));
			} else {
				AmbiguousLevelString = UnknownFunction112("70~",string(80));
			}
		}
	}
	return AmbiguousLevelString;
}

