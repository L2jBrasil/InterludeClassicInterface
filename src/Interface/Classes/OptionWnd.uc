//================================================================================
// OptionWnd.
//================================================================================

class OptionWnd extends UIScript;

var int nPixelShaderVersion;
var int nVertexShaderVersion;
var float gSoundVolume;
var float gMusicVolume;
var float gWavVoiceVolume;
var float gOggVoiceVolume;
var array<ResolutionInfo> ResolutionList;
var array<int> RefreshRateList;
var bool bShow;
var int m_iPrevSoundTick;
var int m_iPrevMusicTick;
var int m_iPrevSystemTick;
var int m_iPrevTutorialTick;
var bool m_bPartyMatchRoomState;

function ResetRefreshRate (optional int a_nWidth, optional int a_nHeight)
{
	local int i;

	GetRefreshRateList(RefreshRateList,a_nWidth,a_nHeight);
	Class'UIAPI_COMBOBOX'.Clear("OptionWnd.RefreshRateBox");
	i = 0;
	if ( UnknownFunction150(i,RefreshRateList.Length) )
	{
		Debug(UnknownFunction112("RefreshRateList[ i ] ",string(RefreshRateList[i])));
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.RefreshRateBox",UnknownFunction112(string(RefreshRateList[i]),"Hz"));
		UnknownFunction163(i);
		goto JL0045;
	}
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.RefreshRateBox",UnknownFunction147(i,1));
}

function OnLoad ()
{
	local int i;
	local int nMultiSample;
	local bool bEnableEngSelection;
	local ELanguageType Language;
	local string strResolution;

	RegisterEvent(510);
	RegisterEvent(520);
	RegisterEvent(1550);
	RegisterEvent(1560);
	RegisterState("OptionWnd","GamingState");
	RegisterState("OptionWnd","LoginState");
	GetShaderVersion(nPixelShaderVersion,nVertexShaderVersion);
	GetResolutionList(ResolutionList);
	SetOptionBool("Game","HideDropItem",False);
	i = 0;
	if ( UnknownFunction150(i,ResolutionList.Length) )
	{
		strResolution = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",string(ResolutionList[i].nWidth)),"*"),string(ResolutionList[i].nHeight))," "),string(ResolutionList[i].nColorBit)),"bit");
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.ResBox",strResolution);
		UnknownFunction163(i);
		goto JL00A4;
	}
	ResetRefreshRate();
	nMultiSample = GetMultiSample();
	if ( UnknownFunction154(0,nMultiSample) )
	{
		Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.AABox",869);
		Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.AABox");
	} else {
		if ( UnknownFunction154(1,nMultiSample) )
		{
			Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.AABox",869);
			Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.AABox",870);
			Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.AABox");
		} else {
			if ( UnknownFunction154(2,nMultiSample) )
			{
				Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.AABox",869);
				Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.AABox",870);
				Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.AABox",871);
				Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.AABox");
			}
		}
	}
	bEnableEngSelection = IsEnableEngSelection();
	Language = GetLanguage();
	switch (Language)
	{
		case 0:
		break;
		case 1:
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","Korean");
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","English");
		if ( bEnableEngSelection )
		{
			Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.LanguageBox");
		} else {
			Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.LanguageBox");
		}
		break;
		case 2:
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","English");
		break;
		case 3:
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","Japanese");
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","English");
		if ( bEnableEngSelection )
		{
			Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.LanguageBox");
		} else {
			Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.LanguageBox");
		}
		break;
		case 4:
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","Chinese(Taiwan)");
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","English");
		if ( bEnableEngSelection )
		{
			Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.LanguageBox");
		} else {
			Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.LanguageBox");
		}
		break;
		case 5:
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","China");
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","English");
		if ( bEnableEngSelection )
		{
			Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.LanguageBox");
		} else {
			Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.LanguageBox");
		}
		break;
		case 6:
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","Thai");
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","English");
		if ( bEnableEngSelection )
		{
			Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.LanguageBox");
		} else {
			Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.LanguageBox");
		}
		break;
		case 7:
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.LanguageBox","English");
		break;
		default:
		break;
	}
	if ( CanUseHDR() )
	{
		Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.HDRBox",1230);
		Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.HDRBox",1231);
		Class'UIAPI_COMBOBOX'.SYS_AddString("OptionWnd.HDRBox",1232);
	}
	InitVideoOption();
	InitAudioOption();
	InitGameOption();
	bShow = False;
}

function RefreshLootingBox ()
{
	if ( UnknownFunction132(UnknownFunction151(GetPartyMemberCount(),0),m_bPartyMatchRoomState) )
	{
		Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.LootingBox");
	} else {
		Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.LootingBox");
	}
}

function InitVideoOption ()
{
	local int i;
	local int nResolutionIndex;
	local float fGamma;
	local bool bRenderDeco;
	local int nPostProcessType;
	local bool bShadow;
	local int nTextureDetail;
	local int nModelDetail;
	local int nSkipAnim;
	local bool bWaterEffect;
	local int nWaterEffectType;
	local int nRenderActorLimit;
	local int nMultiSample;
	local int nOption;
	local bool bOption;

	nResolutionIndex = GetResolutionIndex();
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ResBox",nResolutionIndex);
	GetRefreshRateList(RefreshRateList);
	Class'UIAPI_COMBOBOX'.Clear("OptionWnd.RefreshRateBox");
	i = 0;
	if ( UnknownFunction150(i,RefreshRateList.Length) )
	{
		Class'UIAPI_COMBOBOX'.AddString("OptionWnd.RefreshRateBox",UnknownFunction112(string(RefreshRateList[i]),"Hz"));
		UnknownFunction163(i);
		goto JL006D;
	}
	nOption = GetOptionInt("Video","RefreshRate");
	i = 0;
	if ( UnknownFunction150(i,RefreshRateList.Length) )
	{
		Debug(UnknownFunction112(UnknownFunction112(UnknownFunction112("RefreshRateList[ ",string(i))," ] = "),string(RefreshRateList[i])));
		if ( UnknownFunction154(RefreshRateList[i],nOption) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.RefreshRateBox",i);
		}
		UnknownFunction163(i);
		goto JL00EA;
	}
	fGamma = GetOptionFloat("Video","Gamma");
	if ( UnknownFunction178(1.25,fGamma) )
	{
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.GammaBox",0);
	} else {
		if ( UnknownFunction130(UnknownFunction178(1.0,fGamma),UnknownFunction176(fGamma,1.25)) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.GammaBox",1);
		} else {
			if ( UnknownFunction130(UnknownFunction178(0.81,fGamma),UnknownFunction176(fGamma,1.0)) )
			{
				Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.GammaBox",2);
			} else {
				if ( UnknownFunction130(UnknownFunction178(0.62,fGamma),UnknownFunction176(fGamma,0.81)) )
				{
					Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.GammaBox",3);
				} else {
					if ( UnknownFunction176(fGamma,0.62) )
					{
						Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.GammaBox",4);
					}
				}
			}
		}
	}
	nOption = GetOptionInt("Video","PawnClippingRange");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.CharBox",nOption);
	nOption = GetOptionInt("Video","TerrainClippingRange");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.TerrainBox",nOption);
	bRenderDeco = GetOptionBool("Video","RenderDeco");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.DecoBox",bRenderDeco);
	nPostProcessType = GetOptionInt("Video","PostProc");
	if ( UnknownFunction130(UnknownFunction152(0,nPostProcessType),UnknownFunction152(nPostProcessType,5)) )
	{
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.HDRBox",nPostProcessType);
	} else {
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.HDRBox",0);
	}
	bShadow = GetOptionBool("Video","PawnShadow");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.ShadowBox",bShadow);
	nTextureDetail = GetOptionInt("Video","TextureDetail");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.TextureBox",UnknownFunction250(0,UnknownFunction249(2,nTextureDetail)));
	nModelDetail = GetOptionInt("Video","ModelDetail");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ModelBox",nModelDetail);
	nSkipAnim = GetOptionInt("Video","SkipAnim");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.AnimBox",nSkipAnim);
	if ( UnknownFunction150(nPixelShaderVersion,12) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.ReflectBox");
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ReflectBox",0);
	} else {
		Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.ReflectBox");
		bWaterEffect = GetOptionBool("L2WaterEffect","IsUseEffect");
		nWaterEffectType = GetOptionInt("L2WaterEffect","EffectType");
		if ( UnknownFunction129(bWaterEffect) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ReflectBox",0);
		} else {
			if ( UnknownFunction154(nWaterEffectType,1) )
			{
				Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ReflectBox",1);
			} else {
				if ( UnknownFunction154(nWaterEffectType,2) )
				{
					Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ReflectBox",2);
				} else {
					Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ReflectBox",0);
				}
			}
		}
	}
	bOption = GetOptionBool("Video","UseTrilinear");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.TriBox",bOption);
	nRenderActorLimit = GetOptionInt("Video","RenderActorLimited");
	if ( UnknownFunction153(nRenderActorLimit,6) )
	{
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.PawnBox",0);
	} else {
		if ( UnknownFunction154(nRenderActorLimit,5) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.PawnBox",1);
		} else {
			if ( UnknownFunction154(nRenderActorLimit,4) )
			{
				Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.PawnBox",2);
			} else {
				if ( UnknownFunction154(nRenderActorLimit,3) )
				{
					Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.PawnBox",3);
				} else {
					if ( UnknownFunction154(nRenderActorLimit,2) )
					{
						Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.PawnBox",4);
					} else {
						if ( UnknownFunction152(nRenderActorLimit,1) )
						{
							Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.PawnBox",5);
						}
					}
				}
			}
		}
	}
	nMultiSample = GetMultiSample();
	if ( UnknownFunction130(UnknownFunction151(nMultiSample,0),UnknownFunction129(UnknownFunction130(UnknownFunction152(3,nPostProcessType),UnknownFunction152(nPostProcessType,5)))) )
	{
		nOption = GetOptionInt("Video","AntiAliasing");
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.AABox",nOption);
		Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.AABox");
	} else {
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.AABox",0);
		Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.AABox");
	}
	bOption = GetOptionBool("Video","IsKeepMinFrameRate");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.FrameBox",bOption);
	if ( bOption )
	{
		MinFrameRateOn();
	} else {
		MinFrameRateOff();
	}
	nOption = GetOptionInt("Game","ScreenShotQuality");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.CaptureBox",nOption);
	nOption = GetOptionInt("Video","WeatherEffect");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.WeatherEffectComboBox",nOption);
	bOption = GetOptionBool("Video","GPUAnimation");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.GPUAnimationCheckBox",bOption);
	if ( UnknownFunction150(nVertexShaderVersion,20) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.GPUAnimationCheckBox");
		Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.GPUAnimationCheckBox",False);
	}
}

function InitAudioOption ()
{
	local float fSoundVolume;
	local float fMusicVolume;
	local float fWavVoiceVolume;
	local float fOggVoiceVolume;
	local int iSoundVolume;
	local int iMusicVolume;
	local int iSystemVolume;
	local int iTutorialVolume;

	if ( UnknownFunction242(GetOptionBool("Audio","AudioMuteOn"),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.mutecheckbox",True);
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.mutecheckbox",False);
	}
	if ( CanUseAudio() )
	{
		fSoundVolume = GetOptionFloat("Audio","SoundVolume");
		gSoundVolume = fSoundVolume;
		if ( UnknownFunction130(UnknownFunction178(0.0,fSoundVolume),UnknownFunction176(fSoundVolume,0.2)) )
		{
			iSoundVolume = 0;
		} else {
			if ( UnknownFunction130(UnknownFunction178(0.2,fSoundVolume),UnknownFunction176(fSoundVolume,0.41)) )
			{
				iSoundVolume = 1;
			} else {
				if ( UnknownFunction130(UnknownFunction178(0.41,fSoundVolume),UnknownFunction176(fSoundVolume,0.62)) )
				{
					iSoundVolume = 2;
				} else {
					if ( UnknownFunction130(UnknownFunction178(0.62,fSoundVolume),UnknownFunction176(fSoundVolume,0.81)) )
					{
						iSoundVolume = 3;
					} else {
						if ( UnknownFunction130(UnknownFunction178(0.81,fSoundVolume),UnknownFunction176(fSoundVolume,1.0)) )
						{
							iSoundVolume = 4;
						} else {
							if ( UnknownFunction178(1.0,fSoundVolume) )
							{
								iSoundVolume = 5;
							}
						}
					}
				}
			}
		}
		Class'UIAPI_SLIDERCTRL'.SetCurrentTick("OptionWnd.EffectVolumeSliderCtrl",iSoundVolume);
		fMusicVolume = GetOptionFloat("Audio","MusicVolume");
		gMusicVolume = fMusicVolume;
		if ( UnknownFunction130(UnknownFunction178(0.0,fMusicVolume),UnknownFunction176(fMusicVolume,0.2)) )
		{
			iMusicVolume = 0;
		} else {
			if ( UnknownFunction130(UnknownFunction178(0.2,fMusicVolume),UnknownFunction176(fMusicVolume,0.41)) )
			{
				iMusicVolume = 1;
			} else {
				if ( UnknownFunction130(UnknownFunction178(0.41,fMusicVolume),UnknownFunction176(fMusicVolume,0.62)) )
				{
					iMusicVolume = 2;
				} else {
					if ( UnknownFunction130(UnknownFunction178(0.62,fMusicVolume),UnknownFunction176(fMusicVolume,0.81)) )
					{
						iMusicVolume = 3;
					} else {
						if ( UnknownFunction130(UnknownFunction178(0.81,fMusicVolume),UnknownFunction176(fMusicVolume,1.0)) )
						{
							iMusicVolume = 4;
						} else {
							if ( UnknownFunction178(1.0,fMusicVolume) )
							{
								iMusicVolume = 5;
							}
						}
					}
				}
			}
		}
		Class'UIAPI_SLIDERCTRL'.SetCurrentTick("OptionWnd.MusicVolumeSliderCtrl",iMusicVolume);
		fWavVoiceVolume = GetOptionFloat("Audio","WavVoiceVolume");
		gWavVoiceVolume = fWavVoiceVolume;
		if ( UnknownFunction130(UnknownFunction178(0.0,fWavVoiceVolume),UnknownFunction176(fWavVoiceVolume,0.2)) )
		{
			iSystemVolume = 0;
		} else {
			if ( UnknownFunction130(UnknownFunction178(0.2,fWavVoiceVolume),UnknownFunction176(fWavVoiceVolume,0.41)) )
			{
				iSystemVolume = 1;
			} else {
				if ( UnknownFunction130(UnknownFunction178(0.41,fWavVoiceVolume),UnknownFunction176(fWavVoiceVolume,0.62)) )
				{
					iSystemVolume = 2;
				} else {
					if ( UnknownFunction130(UnknownFunction178(0.62,fWavVoiceVolume),UnknownFunction176(fWavVoiceVolume,0.81)) )
					{
						iSystemVolume = 3;
					} else {
						if ( UnknownFunction130(UnknownFunction178(0.81,fWavVoiceVolume),UnknownFunction176(fWavVoiceVolume,1.0)) )
						{
							iSystemVolume = 4;
						} else {
							if ( UnknownFunction178(1.0,fWavVoiceVolume) )
							{
								iSystemVolume = 5;
							}
						}
					}
				}
			}
		}
		Class'UIAPI_SLIDERCTRL'.SetCurrentTick("OptionWnd.SystemVolumeSliderCtrl",iSystemVolume);
		fOggVoiceVolume = GetOptionFloat("Audio","OggVoiceVolume");
		gOggVoiceVolume = fOggVoiceVolume;
		if ( UnknownFunction130(UnknownFunction178(0.0,fOggVoiceVolume),UnknownFunction176(fOggVoiceVolume,0.2)) )
		{
			iTutorialVolume = 0;
		} else {
			if ( UnknownFunction130(UnknownFunction178(0.2,fOggVoiceVolume),UnknownFunction176(fOggVoiceVolume,0.41)) )
			{
				iTutorialVolume = 1;
			} else {
				if ( UnknownFunction130(UnknownFunction178(0.41,fOggVoiceVolume),UnknownFunction176(fOggVoiceVolume,0.62)) )
				{
					iTutorialVolume = 2;
				} else {
					if ( UnknownFunction130(UnknownFunction178(0.62,fOggVoiceVolume),UnknownFunction176(fOggVoiceVolume,0.81)) )
					{
						iTutorialVolume = 3;
					} else {
						if ( UnknownFunction130(UnknownFunction178(0.81,fOggVoiceVolume),UnknownFunction176(fOggVoiceVolume,1.0)) )
						{
							iTutorialVolume = 4;
						} else {
							if ( UnknownFunction178(1.0,fOggVoiceVolume) )
							{
								iTutorialVolume = 5;
							}
						}
					}
				}
			}
		}
		Class'UIAPI_SLIDERCTRL'.SetCurrentTick("OptionWnd.TutorialVolumeSliderCtrl",iTutorialVolume);
		m_iPrevSoundTick = iSoundVolume;
		m_iPrevMusicTick = iMusicVolume;
		m_iPrevSystemTick = iSystemVolume;
		m_iPrevTutorialTick = iTutorialVolume;
	} else {
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.EffectVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.MusicVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.SystemVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.TutorialVolumeSliderCtrl");
	}
	if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.mutecheckbox") )
	{
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.EffectVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.MusicVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.SystemVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.TutorialVolumeSliderCtrl");
		SetSoundVolume(0.0);
		SetMusicVolume(0.0);
		SetWavVoiceVolume(0.0);
		SetOggVoiceVolume(0.0);
		SetOptionBool("Audio","AudioMuteOn",True);
	} else {
		Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.EffectVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.MusicVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.SystemVolumeSliderCtrl");
		Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.TutorialVolumeSliderCtrl");
	}
}

function InitGameOption ()
{
	local bool bShowOtherPCName;
	local int nOption;
	local bool bOption;

	bOption = GetOptionBool("Neophron","ShowClassLabels");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_ShowClassLabels",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_ShowClassLabels"," Alternative Party Icons");
	bOption = GetOptionBool("Neophron","ShowNoble");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_ShowNoble",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_ShowNoble"," Noblesse In Debuff Row");
	bOption = GetOptionBool("Neophron","SkillCastingBox");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.CB_SkillCastingBox",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.CB_SkillCastingBox"," Display Skill Casting Box");
	bOption = GetOptionBool("Neophron","ShowEvent");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.CB_ShowEvent",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_ShowEvent"," Display OnScreen Event");
	bOption = GetOptionBool("Neophron","ShowDamage");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.CB_ShowDamage",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.CB_ShowDamage"," Display OnScreen Damage");
	bOption = GetOptionBool("Neophron","UseDoping");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_UseDoping",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_UseDoping"," Use Potions Automatically");
	nOption = GetOptionInt("Neophron","AbnormalSize");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.AbnormalSizeBox",nOption);
	nOption = GetOptionInt("Neophron","ShowCount");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.DisplayCountBox",nOption);
	bOption = GetOptionBool("Neophron","ModernParty");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_ModernParty",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_ModernParty"," Clip Style Party Window");
	bOption = GetOptionBool("Neophron","HoldTarget");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_HoldTarget",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_HoldTarget"," Hold Target");
	bOption = GetOptionBool("Neophron","IgnoreAggr");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_IgnoreAggr",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_IgnoreAggr"," Ignore Aggression");
	bOption = GetOptionBool("Neophron","ShortcutTransparency");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_ShotcutTransparency",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_ShotcutTransparency"," Shortcut Transparency");
	SetShortcutTransparency();
	bOption = GetOptionBool("Neophron","ChatTransparency");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.Cb_ChatTransparency",bOption);
	Class'UIAPI_CHECKBOX'.SetTitle("OptionWnd.Cb_ChatTransparency"," Chat Transparency");
	bOption = GetOptionBool("Game","TransparencyMode");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.OpacityBox",bOption);
	bOption = GetOptionBool("Game","IsNative");
	if ( bOption )
	{
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.LanguageBox",0);
	} else {
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.LanguageBox",1);
	}
	bOption = GetOptionBool("Game","MyName");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.NameBox0",bOption);
	bOption = GetOptionBool("Game","NPCName");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.NameBox1",bOption);
	bShowOtherPCName = GetOptionBool("Game","GroupName");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.NameBox2",bShowOtherPCName);
	bOption = GetOptionBool("Game","PledgeMemberName");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.NameBox3",bOption);
	bOption = GetOptionBool("Game","PartyMemberName");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.NameBox4",bOption);
	bOption = GetOptionBool("Game","OtherPCName");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.NameBox5",bOption);
	if ( bShowOtherPCName )
	{
		Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.NameBox3");
		Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.NameBox4");
		Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.NameBox5");
	} else {
		Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.NameBox3");
		Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.NameBox4");
		Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.NameBox5");
	}
	bOption = GetOptionBool("Game","EnterChatting");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.EnterChatBox",bOption);
	bOption = GetOptionBool("Game","OldChatting");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.OldChatBox",bOption);
	if ( IsUseKeyCrypt() )
	{
		if ( IsCheckKeyCrypt() )
		{
			Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.KeyboardBox",True);
		} else {
			Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.KeyboardBox",False);
		}
		if ( IsEnableKeyCrypt() )
		{
			Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.KeyboardBox");
		} else {
			Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.KeyboardBox");
		}
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.KeyboardBox",False);
		Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.KeyboardBox");
	}
	bOption = GetOptionBool("Game","UseJoystick");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.JoypadBox",bOption);
	if ( CanUseJoystick() )
	{
		Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.JoypadBox");
	} else {
		Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.JoypadBox");
	}
	bOption = GetOptionBool("Game","AutoTrackingPawn");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.CameraBox",bOption);
	bOption = GetOptionBool("Video","UseColorCursor");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.CursorBox",bOption);
	bOption = GetOptionBool("Game","ArrowMode");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.ArrowBox",bOption);
	bOption = GetOptionBool("Game","ShowZoneTitle");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.ZoneNameBox",bOption);
	bOption = GetOptionBool("Game","ShowGameTipMsg");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.GametipBox",bOption);
	bOption = GetOptionBool("Game","IsRejectingDuel");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.DuelBox",bOption);
	bOption = GetOptionBool("Game","HideDropItem");
	Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.DropItemBox",bOption);
	nOption = GetOptionInt("Game","PartyLooting");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.LootingBox",nOption);
	RefreshLootingBox();
}

function OnClickCheckBox (string strID)
{
	local AbnormalStatusWnd L2jBRVar21;
	local NPHRN_MagicSkillWnd Script2;
	local PartyWnd Script3;
	local NPHRN_PartyWnd Script4;
	local ChatFilterWnd Script5;

	L2jBRVar21 = AbnormalStatusWnd(GetScript("AbnormalStatusWnd"));
	Script2 = NPHRN_MagicSkillWnd(GetScript("NPHRN_MagicSkillWnd"));
	Script3 = PartyWnd(GetScript("PartyWnd"));
	Script4 = NPHRN_PartyWnd(GetScript("NPHRN_PartyWnd"));
	Script5 = ChatFilterWnd(GetScript("ChatFilterWnd"));
	switch (strID)
	{
		case "Cb_ShowClassLabels":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_ShowClassLabels") )
		{
			SetOptionBool("Neophron","ShowClassLabels",True);
		} else {
			SetOptionBool("Neophron","ShowClassLabels",False);
		}
		ExecuteEvent(1150);
		break;
		case "Cb_ShowNoble":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_ShowNoble") )
		{
			SetOptionBool("Neophron","ShowNoble",True);
		} else {
			SetOptionBool("Neophron","ShowNoble",False);
		}
		L2jBRVar21.L2jBRFunction31();
		break;
		case "CB_SkillCastingBox":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_SkillCastingBox") )
		{
			SetOptionBool("Neophron","SkillCastingBox",True);
		} else {
			SetOptionBool("Neophron","SkillCastingBox",False);
		}
		break;
		case "Cb_ShowEvent":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_ShowEvent") )
		{
			SetOptionBool("Neophron","ShowEvent",True);
		} else {
			SetOptionBool("Neophron","ShowEvent",False);
		}
		break;
		case "Cb_ShowDamage":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_ShowDamage") )
		{
			SetOptionBool("Neophron","ShowDamage",True);
		} else {
			SetOptionBool("Neophron","ShowDamage",False);
		}
		break;
		case "Cb_UseDoping":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_UseDoping") )
		{
			SetOptionBool("Neophron","UseDoping",True);
		} else {
			SetOptionBool("Neophron","UseDoping",False);
		}
		ExecuteEvent(950,Script2.
		L2jBRVar81);
		break;
		case "Cb_ModernParty":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_ModernParty") )
		{
			SetOptionBool("Neophron","ModernParty",True);
		} else {
			SetOptionBool("Neophron","ModernParty",False);
		}
		Script3.ResizeWnd();
		Script4.ResizeWnd();
		break;
		case "Cb_HoldTarget":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_HoldTarget") )
		{
			SetOptionBool("Neophron","HoldTarget",True);
		} else {
			SetOptionBool("Neophron","HoldTarget",False);
		}
		break;
		case "Cb_IgnoreAggr":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_IgnoreAggr") )
		{
			SetOptionBool("Neophron","IgnoreAggr",True);
		} else {
			SetOptionBool("Neophron","IgnoreAggr",False);
		}
		break;
		case "Cb_ShotcutTransparency":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_ShotcutTransparency") )
		{
			SetOptionBool("Neophron","ShortcutTransparency",True);
		} else {
			SetOptionBool("Neophron","ShortcutTransparency",False);
		}
		SetShortcutTransparency();
		break;
		case "Cb_ChatTransparency":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.Cb_ChatTransparency") )
		{
			SetOptionBool("Neophron","ChatTransparency",True);
		} else {
			SetOptionBool("Neophron","ChatTransparency",False);
		}
		Script5.L2jBRFunction67();
		break;
		case "NameBox2":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.NameBox2") )
		{
			Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.NameBox3");
			Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.NameBox4");
			Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.NameBox5");
		} else {
			Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.NameBox3");
			Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.NameBox4");
			Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.NameBox5");
		}
		break;
		case "SystemMsgBox":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.SystemMsgBox") )
		{
			Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.DamageBox");
			Class'UIAPI_CHECKBOX'.EnableWindow("OptionWnd.ItemBox");
		} else {
			Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.DamageBox");
			Class'UIAPI_CHECKBOX'.DisableWindow("OptionWnd.ItemBox");
		}
		break;
		case "FrameBox":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.FrameBox") )
		{
			MinFrameRateOn();
		} else {
			MinFrameRateOff();
		}
		break;
		case "mutecheckbox":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.mutecheckbox") )
		{
			Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.EffectVolumeSliderCtrl");
			Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.MusicVolumeSliderCtrl");
			Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.SystemVolumeSliderCtrl");
			Class'UIAPI_SLIDERCTRL'.DisableWindow("OptionWnd.TutorialVolumeSliderCtrl");
		} else {
			Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.EffectVolumeSliderCtrl");
			Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.MusicVolumeSliderCtrl");
			Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.SystemVolumeSliderCtrl");
			Class'UIAPI_SLIDERCTRL'.EnableWindow("OptionWnd.TutorialVolumeSliderCtrl");
		}
		break;
		default:
	}
}

function OnShow ()
{
	bShow = True;
	InitVideoOption();
	InitAudioOption();
	InitGameOption();
}

function OnHide ()
{
	bShow = False;
}

function ApplyVideoOption ()
{
	local bool bKeepMinFrameRate;
	local bool bTrilinear;
	local int nTextureDetail;
	local int nModelDetail;
	local int nMotionDetail;
	local int nTerrainClippingRange;
	local int nPawnClippingRange;
	local int nReflectionEffect;
	local int nHDR;
	local int nWeatherEffect;
	local int nSelectedNum;
	local float fGamma;
	local bool bRenderDeco;
	local bool bShadow;
	local int nRenderActorLimit;
	local int nResolutionIndex;
	local int nRefreshRateIndex;
	local bool bIsChecked;

	bTrilinear = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.TriBox");
	SetOptionBool("Video","UseTrilinear",bTrilinear);
	nTextureDetail = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.TextureBox");
	SetOptionInt("Video","TextureDetail",nTextureDetail);
	nModelDetail = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.ModelBox");
	SetOptionInt("Video","ModelDetail",nModelDetail);
	nMotionDetail = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.AnimBox");
	SetOptionInt("Video","SkipAnim",nMotionDetail);
	nPawnClippingRange = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.CharBox");
	SetOptionInt("Video","PawnClippingRange",nPawnClippingRange);
	nTerrainClippingRange = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.TerrainBox");
	SetOptionInt("Video","TerrainClippingRange",nTerrainClippingRange);
	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.GammaBox");
	switch (nSelectedNum)
	{
		case 0:
		fGamma = 1.25;
		break;
		case 1:
		fGamma = 1.0;
		break;
		case 2:
		fGamma = 0.81;
		break;
		case 3:
		fGamma = 0.62;
		break;
		case 4:
		fGamma = 0.41;
		break;
		default:
	}
	SetOptionFloat("Video","Gamma",fGamma);
	nHDR = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.HDRBox");
	SetOptionInt("Video","PostProc",nHDR);
	bRenderDeco = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.DecoBox");
	SetOptionBool("Video","RenderDeco",bRenderDeco);
	bShadow = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.ShadowBox");
	SetOptionBool("Video","PawnShadow",bShadow);
	nReflectionEffect = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.ReflectBox");
	SetOptionInt("L2WaterEffect","EffectType",nReflectionEffect);
	if ( UnknownFunction154(0,nReflectionEffect) )
	{
		SetOptionBool("L2WaterEffect","IsUseEffect",False);
	} else {
		SetOptionBool("L2WaterEffect","IsUseEffect",True);
	}
	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.PawnBox");
	switch (nSelectedNum)
	{
		case 5:
		nRenderActorLimit = 1;
		break;
		case 4:
		nRenderActorLimit = 2;
		break;
		case 3:
		nRenderActorLimit = 3;
		break;
		case 2:
		nRenderActorLimit = 4;
		break;
		case 1:
		nRenderActorLimit = 5;
		break;
		case 0:
		nRenderActorLimit = 6;
		break;
		default:
	}
	SetOptionInt("Video","RenderActorLimited",nRenderActorLimit);
	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.AABox");
	SetOptionInt("Video","AntiAliasing",nSelectedNum);
	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.CaptureBox");
	SetOptionInt("Game","ScreenShotQuality",nSelectedNum);
	nResolutionIndex = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.ResBox");
	nRefreshRateIndex = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.RefreshRateBox");
	SetResolution(nResolutionIndex,nRefreshRateIndex);
	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.WeatherEffectComboBox");
	switch (nSelectedNum)
	{
		case 0:
		nWeatherEffect = 0;
		break;
		case 1:
		nWeatherEffect = 1;
		break;
		case 2:
		nWeatherEffect = 2;
		break;
		case 3:
		nWeatherEffect = 3;
		break;
		default:
	}
	SetOptionInt("Video","WeatherEffect",nWeatherEffect);
	bIsChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.GPUAnimationCheckBox");
	SetOptionBool("Video","GPUAnimation",bIsChecked);
	bKeepMinFrameRate = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.FrameBox");
	SetOptionBool("Video","IsKeepMinFrameRate",bKeepMinFrameRate);
	if ( bKeepMinFrameRate )
	{
		Debug("KeepMinFrameRate");
		SetTextureDetail(2);
		SetModelingDetail(1);
		SetMotionDetail(1);
		SetShadow(False);
		SetBackgroundEffect(False);
		SetTerrainClippingRange(4);
		SetPawnClippingRange(4);
		SetReflectionEffect(0);
		SetHDR(0);
		SetWeatherEffect(0);
	} else {
		Debug(UnknownFunction112("Not KeepMinFrameRate nTextureDetail=",string(nTextureDetail)));
		SetTextureDetail(nTextureDetail);
		SetModelingDetail(nModelDetail);
		SetMotionDetail(nMotionDetail);
		SetShadow(bShadow);
		SetBackgroundEffect(bRenderDeco);
		SetTerrainClippingRange(nTerrainClippingRange);
		SetPawnClippingRange(nPawnClippingRange);
		SetReflectionEffect(nReflectionEffect);
		SetHDR(nHDR);
		SetWeatherEffect(nWeatherEffect);
	}
	InitVideoOption();
}

function ApplyAudioOption ()
{
	local float fSoundVolume;
	local float fMusicVolume;
	local float fWavVoiceVolume;
	local float fOggVoiceVolume;
	local int iSoundTick;
	local int iMusicTick;
	local int iSystemTick;
	local int iTutorialTick;

	if ( UnknownFunction129(CanUseAudio()) )
	{
		return;
	}
	iSoundTick = Class'UIAPI_SLIDERCTRL'.GetCurrentTick("OptionWnd.EffectVolumeSliderCtrl");
	fSoundVolume = GetVolumeFromSliderTick(iSoundTick);
	SetOptionFloat("Audio","SoundVolume",fSoundVolume);
	gSoundVolume = fSoundVolume;
	iMusicTick = Class'UIAPI_SLIDERCTRL'.GetCurrentTick("OptionWnd.MusicVolumeSliderCtrl");
	fMusicVolume = GetVolumeFromSliderTick(iMusicTick);
	SetOptionFloat("Audio","MusicVolume",fMusicVolume);
	gMusicVolume = fMusicVolume;
	iSystemTick = Class'UIAPI_SLIDERCTRL'.GetCurrentTick("OptionWnd.SystemVolumeSliderCtrl");
	fWavVoiceVolume = GetVolumeFromSliderTick(iSystemTick);
	SetOptionFloat("Audio","WavVoiceVolume",fWavVoiceVolume);
	gWavVoiceVolume = fWavVoiceVolume;
	iTutorialTick = Class'UIAPI_SLIDERCTRL'.GetCurrentTick("OptionWnd.TutorialVolumeSliderCtrl");
	fOggVoiceVolume = GetVolumeFromSliderTick(iTutorialTick);
	SetOptionFloat("Audio","OggVoiceVolume",fOggVoiceVolume);
	gOggVoiceVolume = fOggVoiceVolume;
	m_iPrevSoundTick = iSoundTick;
	m_iPrevMusicTick = iMusicTick;
	m_iPrevSystemTick = iSystemTick;
	m_iPrevTutorialTick = iTutorialTick;
	if ( Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.mutecheckbox") )
	{
		SetSoundVolume(0.0);
		SetMusicVolume(0.0);
		SetWavVoiceVolume(0.0);
		SetOggVoiceVolume(0.0);
		SetOptionBool("Audio","AudioMuteOn",True);
	} else {
		SetOptionBool("Audio","AudioMuteOn",False);
	}
}

function ApplyGameOption ()
{
	local int nSelectedNum;
	local bool bChecked;

	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.AbnormalSizeBox");
	SetOptionInt("Neophron","AbnormalSize",nSelectedNum);
	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.DisplayCountBox");
	SetOptionInt("Neophron","ShowCount",nSelectedNum);
	nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.LanguageBox");
	if ( UnknownFunction154(0,nSelectedNum) )
	{
		SetOptionBool("Game","IsNative",True);
	} else {
		if ( UnknownFunction154(1,nSelectedNum) )
		{
			SetOptionBool("Game","IsNative",False);
		}
	}
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.NameBox0");
	SetOptionBool("Game","MyName",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.NameBox1");
	SetOptionBool("Game","NPCName",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.NameBox3");
	SetOptionBool("Game","PledgeMemberName",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.NameBox4");
	SetOptionBool("Game","PartyMemberName",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.NameBox5");
	SetOptionBool("Game","OtherPCName",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.NameBox2");
	SetOptionBool("Game","GroupName",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.OpacityBox");
	SetOptionBool("Game","TransparencyMode",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.ArrowBox");
	SetOptionBool("Game","ArrowMode",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.CameraBox");
	SetOptionBool("Game","AutoTrackingPawn",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.EnterChatBox");
	SetOptionBool("Game","EnterChatting",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.OldChatBox");
	SetOptionBool("Game","OldChatting",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.ZoneNameBox");
	SetOptionBool("Game","ShowZoneTitle",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.GametipBox");
	SetOptionBool("Game","ShowGameTipMsg",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.DuelBox");
	SetOptionBool("Game","IsRejectingDuel",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.DropItemBox");
	SetOptionBool("Game","HideDropItem",bChecked);
	if ( Class'UIAPI_WINDOW'.IsEnableWindow("OptionWnd.LootingBox") )
	{
		nSelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("OptionWnd.LootingBox");
		SetOptionInt("Game","PartyLooting",nSelectedNum);
	}
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.CursorBox");
	SetOptionBool("Video","UseColorCursor",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.SystemMsgBox");
	SetOptionBool("Game","SystemMsgWnd",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.DamageBox");
	SetOptionBool("Game","SystemMsgWndDamage",bChecked);
	bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.ItemBox");
	SetOptionBool("Game","SystemMsgWndExpendableItem",bChecked);
	if ( CanUseJoystick() )
	{
		bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.JoypadBox");
		SetOptionBool("Game","UseJoystick",bChecked);
	}
	if ( IsUseKeyCrypt() )
	{
		bChecked = Class'UIAPI_CHECKBOX'.IsChecked("OptionWnd.KeyboardBox");
		SetKeyCrypt(bChecked);
	}
}

function OnClickButton (string strID)
{
	Debug(strID);
	switch (strID)
	{
		case "VideoCancelBtn":
		case "AudioCancelBtn":
		case "GameCancelBtn":
		case "NPHRNCancelBtn":
		SetOptionInt("FirstRun","FirstRun",2);
		OnModifyCurrentTickSliderCtrl("EffectVolumeSliderCtrl",m_iPrevSoundTick);
		OnModifyCurrentTickSliderCtrl("MusicVolumeSliderCtrl",m_iPrevMusicTick);
		OnModifyCurrentTickSliderCtrl("SystemVolumeSliderCtrl",m_iPrevSystemTick);
		OnModifyCurrentTickSliderCtrl("TutorialVolumeSliderCtrl",m_iPrevTutorialTick);
		Class'UIAPI_WINDOW'.HideWindow("OptionWnd");
		break;
		case "VideoOKBtn":
		case "AudioOKBtn":
		case "GameOKBtn":
		case "NPHRNOKBtn":
		ApplyVideoOption();
		ApplyAudioOption();
		ApplyGameOption();
		SetOptionInt("FirstRun","FirstRun",2);
		Class'UIAPI_WINDOW'.HideWindow("OptionWnd");
		break;
		case "VideoApplyBtn":
		case "AudioApplyBtn":
		case "GameApplyBtn":
		case "NPHRNApplyBtn":
		ApplyVideoOption();
		ApplyAudioOption();
		ApplyGameOption();
		break;
		case "WindowInitBtn":
		SetDefaultPosition();
		break;
		default:
	}
}

function float GetVolumeFromSliderTick (int iTick)
{
	local float fReturnVolume;

	switch (iTick)
	{
		case 0:
		fReturnVolume = 0.0;
		break;
		case 1:
		fReturnVolume = 0.2;
		break;
		case 2:
		fReturnVolume = 0.41;
		break;
		case 3:
		fReturnVolume = 0.62;
		break;
		case 4:
		fReturnVolume = 0.81;
		break;
		case 5:
		fReturnVolume = 1.0;
		break;
		default:
	}
	return fReturnVolume;
}

function MinFrameRateOn ()
{
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.TextureBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.ModelBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.AnimBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.ShadowBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.DecoBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.TerrainBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.CharBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.ReflectBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.HDRBox");
	Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.WeatherEffectComboBox");
}

function MinFrameRateOff ()
{
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.TextureBox");
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.ModelBox");
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.AnimBox");
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.ShadowBox");
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.DecoBox");
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.TerrainBox");
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.CharBox");
	Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.WeatherEffectComboBox");
	if ( UnknownFunction150(nPixelShaderVersion,12) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.ReflectBox");
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.ReflectBox",0);
	} else {
		Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.ReflectBox");
	}
	if ( UnknownFunction130(UnknownFunction153(nPixelShaderVersion,20),UnknownFunction153(nVertexShaderVersion,20)) )
	{
		Class'UIAPI_WINDOW'.EnableWindow("OptionWnd.HDRBox");
	} else {
		Class'UIAPI_WINDOW'.DisableWindow("OptionWnd.HDRBox");
		Class'UIAPI_COMBOBOX'.SetSelectedNum("OptionWnd.HDRBox",0);
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	local bool bMinFrameRate;

	switch (L2jBRVar16)
	{
		case 510:
		bMinFrameRate = GetOptionBool("Video","IsKeepMinFrameRate");
		Class'UIAPI_CHECKBOX'.SetCheck("OptionWnd.FrameBox",bMinFrameRate);
		if ( bMinFrameRate )
		{
			MinFrameRateOn();
		} else {
			MinFrameRateOff();
		}
		ApplyVideoOption();
		break;
		case 520:
		RefreshLootingBox();
		break;
		case 1550:
		m_bPartyMatchRoomState = True;
		RefreshLootingBox();
		break;
		case 1560:
		m_bPartyMatchRoomState = False;
		RefreshLootingBox();
		break;
		default:
	}
}

function OnComboBoxItemSelected (string sName, int Index)
{
	local NPHRN_BeltWnd L2jBRVar21;

	L2jBRVar21 = NPHRN_BeltWnd(GetScript("NPHRN_BeltWnd"));
	switch (sName)
	{
		case "ResBox":
		ResetRefreshRate(ResolutionList[Index].nWidth,ResolutionList[Index].nHeight);
		break;
		case "AbnormalSizeBox":
		Class'UIAPI_COMBOBOX'.GetReserved("OptionWnd.AbnormalSizeBox",Index);
		SetOptionInt("Neophron","AbnormalSize",Index);
		break;
		case "DisplayCountBox":
		Class'UIAPI_COMBOBOX'.GetReserved("OptionWnd.DisplayCountBox",Index);
		SetOptionInt("Neophron","ShowCount",Index);
		L2jBRVar21.L2jBRFunction86();
		break;
		default:
	}
}

function OnModifyCurrentTickSliderCtrl (string strID, int iCurrentTick)
{
	local float fVolume;

	fVolume = GetVolumeFromSliderTick(iCurrentTick);
	switch (strID)
	{
		case "EffectVolumeSliderCtrl":
		SetOptionFloat("Audio","SoundVolume",fVolume);
		break;
		case "MusicVolumeSliderCtrl":
		if ( UnknownFunction180(fVolume,0.0) )
		{
			fVolume = 0.05;
		}
		SetOptionFloat("Audio","MusicVolume",fVolume);
		break;
		case "SystemVolumeSliderCtrl":
		SetOptionFloat("Audio","WavVoiceVolume",fVolume);
		break;
		case "TutorialVolumeSliderCtrl":
		SetOptionFloat("Audio","OggVoiceVolume",fVolume);
		break;
		default:
	}
}

function SetShortcutTransparency ()
{
	if ( UnknownFunction242(GetOptionBool("Neophron","ShortcutTransparency"),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_ShotcutTransparency",True);
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_1","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_2","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_3","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_4","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_5","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_6","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_7","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_8","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_9","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_10","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_11","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_12","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F1Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F2Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F3Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F4Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F5Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F6Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F7Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F8Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F9Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F10Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F11Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F12Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_1","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_2","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_3","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_4","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_5","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_6","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_7","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_8","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_9","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_10","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_11","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_12","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F1Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F2Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F3Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F4Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F5Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F6Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F7Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F8Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F9Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F10Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F11Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F12Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_1","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_2","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_3","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_4","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_5","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_6","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_7","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_8","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_9","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_10","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_11","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_12","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F1Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F2Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F3Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F4Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F5Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F6Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F7Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F8Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F9Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F10Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F11Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F12Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_1","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_2","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_3","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_4","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_5","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_6","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_7","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_8","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_9","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_10","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_11","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_12","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F1Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F2Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F3Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F4Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F5Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F6Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F7Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F8Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F9Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F10Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F11Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F12Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_1","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_2","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_3","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_4","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_5","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_6","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_7","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_8","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_9","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_10","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_11","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_12","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F1Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F2Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F3Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F4Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F5Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F6Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F7Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F8Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F9Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F10Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F11Tex","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F12Tex","Interface.Null");
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_ShotcutTransparency",False);
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.Tex","Interface.Wnd_Shortcut_h");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.Tex","Interface.Wnd_Shortcut_h");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.Tex","Interface.Wnd_Shortcut_h");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.Tex","Interface.Wnd_Shortcut_h");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.Tex","Interface.Wnd_Shortcut_h");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_1","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_2","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_3","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_4","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_5","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_6","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_7","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_8","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_9","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_10","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_11","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.BackDropH1_12","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F1Tex","Interface.Interface.NPHRN_Signa_Key_1");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F2Tex","Interface.Interface.NPHRN_Signa_Key_2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F3Tex","Interface.Interface.NPHRN_Signa_Key_3");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F4Tex","Interface.Interface.NPHRN_Signa_Key_4");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F5Tex","Interface.Interface.NPHRN_Signa_Key_5");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F6Tex","Interface.Interface.NPHRN_Signa_Key_6");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F7Tex","Interface.Interface.NPHRN_Signa_Key_7");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F8Tex","Interface.Interface.NPHRN_Signa_Key_8");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F9Tex","Interface.Interface.NPHRN_Signa_Key_9");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F10Tex","Interface.Interface.NPHRN_Signa_Key_10");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F11Tex","Interface.Interface.NPHRN_Signa_Key_11");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal.F12Tex","Interface.Interface.NPHRN_Signa_Key_12");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_1","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_2","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_3","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_4","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_5","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_6","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_7","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_8","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_9","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_10","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_11","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.BackDropH2_12","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F1Tex","Interface.NPHRN_Signa_Key_1");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F2Tex","Interface.NPHRN_Signa_Key_2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F3Tex","Interface.NPHRN_Signa_Key_3");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F4Tex","Interface.NPHRN_Signa_Key_4");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F5Tex","Interface.NPHRN_Signa_Key_5");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F6Tex","Interface.NPHRN_Signa_Key_6");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F7Tex","Interface.NPHRN_Signa_Key_7");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F8Tex","Interface.NPHRN_Signa_Key_8");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F9Tex","Interface.NPHRN_Signa_Key_9");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F10Tex","Interface.NPHRN_Signa_Key_10");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F11Tex","Interface.NPHRN_Signa_Key_11");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_1.F12Tex","Interface.NPHRN_Signa_Key_12");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_1","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_2","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_3","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_4","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_5","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_6","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_7","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_8","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_9","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_10","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_11","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.BackDropH3_12","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F1Tex","Interface.NPHRN_Signa_Key_1");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F2Tex","Interface.NPHRN_Signa_Key_2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F3Tex","Interface.NPHRN_Signa_Key_3");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F4Tex","Interface.NPHRN_Signa_Key_4");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F5Tex","Interface.NPHRN_Signa_Key_5");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F6Tex","Interface.NPHRN_Signa_Key_6");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F7Tex","Interface.NPHRN_Signa_Key_7");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F8Tex","Interface.NPHRN_Signa_Key_8");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F9Tex","Interface.NPHRN_Signa_Key_9");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F10Tex","Interface.NPHRN_Signa_Key_10");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F11Tex","Interface.NPHRN_Signa_Key_11");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_2.F12Tex","Interface.NPHRN_Signa_Key_12");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_1","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_2","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_3","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_4","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_5","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_6","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_7","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_8","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_9","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_10","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_11","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.BackDropH4_12","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F1Tex","Interface.NPHRN_Signa_Key_1");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F2Tex","Interface.NPHRN_Signa_Key_2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F3Tex","Interface.NPHRN_Signa_Key_3");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F4Tex","Interface.NPHRN_Signa_Key_4");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F5Tex","Interface.NPHRN_Signa_Key_5");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F6Tex","Interface.NPHRN_Signa_Key_6");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F7Tex","Interface.NPHRN_Signa_Key_7");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F8Tex","Interface.NPHRN_Signa_Key_8");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F9Tex","Interface.NPHRN_Signa_Key_9");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F10Tex","Interface.NPHRN_Signa_Key_10");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F11Tex","Interface.NPHRN_Signa_Key_11");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_3.F12Tex","Interface.NPHRN_Signa_Key_12");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_1","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_2","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_3","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_4","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_5","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_6","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_7","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_8","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_9","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_10","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_11","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.BackDropH5_12","Interface.ItemWindow_DF_SlotBox_2x2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F1Tex","Interface.NPHRN_Signa_Key_1");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F2Tex","Interface.NPHRN_Signa_Key_2");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F3Tex","Interface.NPHRN_Signa_Key_3");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F4Tex","Interface.NPHRN_Signa_Key_4");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F5Tex","Interface.NPHRN_Signa_Key_5");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F6Tex","Interface.NPHRN_Signa_Key_6");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F7Tex","Interface.NPHRN_Signa_Key_7");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F8Tex","Interface.NPHRN_Signa_Key_8");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F9Tex","Interface.NPHRN_Signa_Key_9");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F10Tex","Interface.NPHRN_Signa_Key_10");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F11Tex","Interface.NPHRN_Signa_Key_11");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndHorizontal_4.F12Tex","Interface.NPHRN_Signa_Key_12");
	}
}

