//================================================================================
// LoadingWnd.
//================================================================================

class LoadingWnd extends UIScript;

var string LoadingTexture15;
var string LoadingTexture18;
var string LoadingTextureFree;

function OnLoad ()
{
	RegisterEvent(170);
	Class'UIAPI_TEXTURECTRL'.SetTexture("LoadingWnd.BackTex",LoadingTextureFree);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	local int ServerAgeLimitInt;
	local EServerAgeLimit ServerAgeLimit;

	if ( UnknownFunction154(L2jBRVar16,170) )
	{
		if ( ParseInt(_L2jBRVar17_,"ServerAgeLimit",ServerAgeLimitInt) )
		{
			ServerAgeLimit = ServerAgeLimitInt;
			switch (ServerAgeLimit)
			{
				case 0:
				Debug(UnknownFunction112("LoadingTexture15=",LoadingTexture15));
				Class'UIAPI_TEXTURECTRL'.SetTexture("LoadingWnd.BackTex",LoadingTexture15);
				break;
				case 1:
				Debug(UnknownFunction112("LoadingTexture18=",LoadingTexture18));
				Class'UIAPI_TEXTURECTRL'.SetTexture("LoadingWnd.BackTex",LoadingTexture18);
				break;
				case 2:
				Debug(UnknownFunction112("LoadingTextureFree=",LoadingTextureFree));
				default:
			}
			Class'UIAPI_TEXTURECTRL'.SetTexture("LoadingWnd.BackTex",LoadingTextureFree);
		} else {
		}
	}
}

defaultproperties
{
    LoadingTexture15="L2Font.loading03-k"

    LoadingTexture18="L2Font.loading04-k"

    LoadingTextureFree="L2Font.loading02-k"

}
