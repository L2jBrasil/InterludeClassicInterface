//================================================================================
// UIScript.
//================================================================================

class UIScript extends UIEventManager;

var WindowHandle m_hOwnerWnd;

native function RequestTest ();

native function bool IsPKMode ();

native function RequestExit ();

native function RequestAuthCardKeyLogin (int uid, string Value);

native function RequestSelfTarget ();

native function RequestTargetCancel ();

native function RequestSkillList ();

native function RequestRaidRecord ();

native function RequestTradeDone (bool bDone);

native function RequestStartTrade (int targetID);

native function RequestAddTradeItem (int ServerID, int Num);

native function AnswerTradeRequest (bool bOK);

native function RequestSellItem (string param);

native function RequestBuyItem (string param);

native function RequestBuySeed (string param);

native function RequestProcureCrop (string param);

native function RequestSetSeed (string param);

native function RequestSetCrop (string param);

native function RequestAttack (int ServerID, Vector loc);

native function RequestAction (int ServerID, Vector loc);

native function RequestAssist (int ServerID, Vector loc);

native function RequestTargetUser (int ServerID);

native function RequestWarehouseDeposit (string param);

native function RequestWarehouseWithdraw (string param);

native function RequestChangePetName (string Name);

native function RequestPackageSendableItemList (int targetID);

native function RequestPackageSend (string param);

native function RequestPreviewItem (string param);

native function RequestBBSBoard ();

native function RequestMultiSellChoose (string param);

native function RequestRestartPoint (ERestartPointType Type);

native function RequestUseItem (int ServerID);

native function RequestDestroyItem (int ServerID, int Num);

native function RequestDropItem (int ServerID, int Num, Vector Location);

native function RequestUnequipItem (int ServerID, int SlotBitType);

native function RequestCrystallizeItem (int ServerID, int Number);

native function RequestItemList ();

native function RequestDuelStart (string sTargetName, int duelType);

native function RequestDuelAnswerStart (int duelType, int Option, int answer);

native function RequestDuelSurrender ();

native function RequestQuitPrivateShop (string Type);

native function SendPrivateShopList (string Type, string param);

native function int GetPartyMemberCount ();

native function bool GetPartyMemberLocation (int a_PartyMemberIndex, out Vector a_Location);

native function RequestClanMemberInfo (int Type, string Name);

native function RequestClanGradeList ();

native function RequestClanChangeGrade (string sName, int grade);

native function RequestClanAssignPupil (string sMaster, string sPupil);

native function RequestClanDeletePupil (string sMaster, string sPupil);

native function RequestClanLeave (string ClanName, int clanType);

native function RequestClanExpelMember (int clanType, string sName);

native function RequestClanAskJoin (int Id, int clanType);

native function RequestClanDeclareWar ();

native function RequestClanDeclareWarWithUserID (int Id);

native function RequestClanDeclareWarWidhClanName (string sName);

native function RequestClanWithdrawWar ();

native function RequestClanWithdrawWarWithClanName (string sClanName);

native function RequestClanReorganizeMember (int Type, string memberName, int clanType, string targetMemberName);

native function RequestClanRegisterCrest ();

native function RequestClanUnregisterCrest ();

native function RequestClanRegisterEmblem ();

native function RequestClanUnregisterEmblem ();

native function RequestClanChangeNickName (string sName, string sNickName);

native function RequestClanWarList (int page, int State);

native function RequestClanAuth (int gradeID);

native function RequestEditClanAuth (int gradeID, array<int> powers);

native function RequestClanMemberAuth (int clanType, string sName);

native function RequestPCCafeCouponUse (string a_CouponKey);

native function string GetCastleName (int castleID);

native function bool HasClanCrest ();

native function bool HasClanEmblem ();

native function RequestInviteParty (string sName);

native final function string GetClassType (int ClassID);

native final function string GetClassStr (int ClassID);

native function string GetClassIconName (int ClassID);

native function bool GetPlayerInfo (out UserInfo a_UserInfo);

native function bool GetTargetInfo (out UserInfo a_UserInfo);

native function bool GetUserInfo (int UserID, out UserInfo a_UserInfo);

native function bool GetPetInfo (out PetInfo a_PetInfo);

native function bool GetSkillInfo (int a_SkillID, int a_SkillLevel, out SkillInfo a_SkillInfo);

native function INT64 GetExpByPlayerLevel (int iLevel);

native function bool GetAccessoryServerID (out int a_LEar, out int a_REar, out int a_LFinger, out int a_RFinger);

native function int GetClassStep (int a_ClassID);

native function string GetClanName (int clanID);

native final function int GetClanNameValue (int iClanID);

native final function int GetAdena ();

native final function string MakeBuffTimeStr (int Time);

native final function string GetTimeString ();

native final function string ConvertTimetoStr (int Time);

native final function Debug (string strMsg);

native final function bool IsKeyDown (EInputKey Key);

native final function string GetSystemString (int Id);

native final function string GetSystemMessage (int Id);

native final function GetSystemMsgInfo (int Id, out SystemMsgData SysMsgData);

native final function UIScript GetScript (string window);

native final function string MakeFullSystemMsg (string sMsg, string sArg1, optional string sArg2);

native final function GetTextSize (string strInput, out int nWidth, out int nHeight);

native final function GetZoneNameTextSize (string strInput, out int nWidth, out int nHeight);

native final function string MakeFullItemName (int Id);

native final function string GetItemGradeString (int nCrystalType);

native final function string MakeCostStringInt64 (INT64 a_Input);

native final function string MakeCostString (string strInput);

native final function string ConvertNumToText (string strInput);

native final function string ConvertNumToTextNoAdena (string strInput);

native final function Color GetNumericColor (string strCommaAdena);

native final function int GetInventoryItemCount (int nID);

native final function PlayConsoleSound (EInterfaceSoundType eType);

native final function EIMEType GetCurrentIMELang ();

native final function Texture GetPledgeCrestTexFromPledgeCrestID (int PledgeCrestID);

native final function Texture GetAllianceCrestTexFromAllianceCrestID (int AllianceCrestID);

native final function RequestBypassToServer (string strPass);

native final function string GetUserRankString (int Rank);

native final function string GetRoutingString (int RoutingType);

native final function bool IsDebuff (int SkillID, int SkillLevel);

native final function bool CheckItemLimit (int ClassID, int Count);

native final function string Int64ToString (INT64 i64);

native final function INT64 Int64SubtractBfromA (INT64 A, INT64 B);

native final function INT64 Int64Add (INT64 A, INT64 B);

native final function INT64 Int64Mul (int A, int B);

native final function INT64 Int2Int64 (int Value);

native final function float GetExpRate (INT64 a_Exp, optional int a_Level);

native function Vector GetClickLocation ();

native final function GetCurrentResolution (out int ScreenWidth, out int ScreenHeight);

native function string GetChatPrefix (EChatType Type);

native function bool IsSameChatPrefix (EChatType Type, string InputPrefix);

native function SetPrivateShopMessage (string Type, string Message);

native function string GetPrivateShopMessage (string Type);

native final function AddSystemMessage (string a_Message, Color a_Color);

native final function AddSystemMessageParam (string strParam);

native final function string EndSystemMessageParam (int MsgNum, bool bGetMsg);

native final function ExecRestart ();

native final function ExecQuit ();

native final function EServerAgeLimit GetServerAgeLimit ();

native final function bool CanUseAudio ();

native final function bool CanUseJoystick ();

native final function bool CanUseHDR ();

native final function bool IsEnableEngSelection ();

native final function bool IsUseKeyCrypt ();

native final function bool IsCheckKeyCrypt ();

native final function bool IsEnableKeyCrypt ();

native final function ELanguageType GetLanguage ();

native final function GetResolutionList (out array<ResolutionInfo> a_ResolutionList);

native final function GetRefreshRateList (out array<int> a_RefreshRateList, optional int a_nWidth, optional int a_nHeight);

native final function SetResolution (int a_nResolutionIndex, int a_nRefreshRateIndex);

native final function int GetMultiSample ();

native final function int GetResolutionIndex ();

native final function GetShaderVersion (out int a_nPixelShaderVersion, out int a_nVertexShaderVersion);

native final function SetDefaultPosition ();

native final function SetKeyCrypt (bool a_bOnOff);

native final function SetTextureDetail (int a_nTextureDetail);

native final function SetModelingDetail (int a_nModelingDetail);

native final function SetMotionDetail (int a_nMotionDetail);

native final function SetShadow (bool a_bShadow);

native final function SetBackgroundEffect (bool a_bBackgroundEffect);

native final function SetTerrainClippingRange (int a_nTerrainClippingRange);

native final function SetPawnClippingRange (int a_nPawnClippingRange);

native final function SetReflectionEffect (int a_nReflectionEffect);

native final function SetHDR (int a_nHDR);

native final function SetWeatherEffect (int a_nWeatherEffect);

native final function ExecuteCommand (string a_strCmd);

native final function ExecuteCommandFromAction (string strCmd);

native final function DoAction (int ActionID);

native final function UseSkill (int SkillID);

native final function bool IsStackableItem (int ConsumeType);

native final function SetOptionBool (string a_strSection, string a_strName, bool a_bValue);

native final function SetOptionInt (string a_strSection, string a_strName, int a_nValue);

native final function SetOptionFloat (string a_strSection, string a_strName, float a_fValue);

native final function SetOptionString (string a_strSection, string a_strName, string a_strValue);

native final function bool GetOptionBool (string a_strSection, string a_strName);

native final function int GetOptionInt (string a_strSection, string a_strName);

native final function float GetOptionFloat (string a_strSection, string a_strName);

native final function string GetOptionString (string a_strSection, string a_strName);

native final function string GetSlotTypeString (int ItemType, int SlotBitType, int ArmorType);

native final function string GetWeaponTypeString (int WeaponType);

native final function int GetPhysicalDamage (int WeaponType, int SlotBitType, int CrystalType, int Enchanted, int PhysicalDamage);

native final function int GetMagicalDamage (int WeaponType, int SlotBitType, int CrystalType, int Enchanted, int MagicalDamage);

native final function string GetAttackSpeedString (int AttackSpeed);

native final function int GetShieldDefense (int CrystalType, int Enchanted, int ShieldDefense);

native final function int GetPhysicalDefense (int CrystalType, int Enchanted, int PhysicalDefense);

native final function int GetMagicalDefense (int CrystalType, int Enchanted, int MagicalDefense);

native final function bool IsMagicalArmor (int ClassID);

native final function string GetLottoString (int Enchanted, int Damaged);

native final function string GetRaceTicketString (int Blessed);

native final function RefreshINI (string a_INIFileName);

native final function bool GetINIBool (string section, string Key, out int Value, string file);

native final function bool GetINIInt (string section, string Key, out int Value, string file);

native final function bool GetINIFloat (string section, string Key, out float Value, string file);

native final function bool GetINIString (string section, string Key, out string Value, string file);

native final function SetINIBool (string section, string Key, bool Value, string file);

native final function SetINIInt (string section, string Key, int Value, string file);

native final function SetINIFloat (string section, string Key, float Value, string file);

native final function SetINIString (string section, string Key, string Value, string file);

native final function bool GetConstantInt (int a_nID, out int a_nValue);

native final function bool GetConstantString (int a_nID, out string a_strValue);

native final function bool GetConstantBool (int a_nID, out int a_bValue);

native final function bool GetConstantFloat (int a_nID, out float a_fValue);

native final function SetSoundVolume (float a_fVolume);

native final function SetMusicVolume (float a_fVolume);

native final function SetWavVoiceVolume (float a_fVolume);

native final function SetOggVoiceVolume (float a_fVolume);

native final function ReturnTooltipInfo (CustomTooltip Info);

event OnLoad ();

event OnTick ();

event OnShow ();

event OnHide ();

event OnEvent (int a_EventID, string a_Param);

event OnTimer (int TimerID);

event OnMinimize ();

event OnEnterState (name a_PreStateName);

event OnExitState (name a_NextStateName);

event OnSendPacketWhenHiding ();

event OnFrameExpandClick (bool bIsExpand);

event OnDefaultPosition ();

event OnKeyDown (EInputKey Key);

event OnKeyUp (EInputKey Key);

event OnLButtonDown (WindowHandle a_WindowHandle, int X, int Y);

event OnLButtonUp (WindowHandle a_WindowHandle, int X, int Y);

event OnLButtonDblClick (int X, int Y);

event OnRButtonDown (int X, int Y);

event OnRButtonUp (int X, int Y);

event OnRButtonDblClick (int X, int Y);

event OnDropItem (string strID, ItemInfo infItem, int X, int Y);

event OnDragItemStart (string strID, ItemInfo infItem);

event OnDragItemEnd (string strID);

event OnDropItemSource (string strTarget, ItemInfo infItem);

event OnClickButton (string strID);

event OnClickButtonWithHandle (ButtonHandle a_ButtonHandle);

event OnButtonTimer (bool bExpired);

event OnTabSplit (string sName);

event OnTabMerge (string sName);

event OnCompleteEditBox (string strID);

event OnChangeEditBox (string strID);

event OnChatMarkedEditBox (string strID);

event OnClickListCtrlRecord (string strID);

event OnDBClickListCtrlRecord (string strID);

event OnClickCheckBox (string strID);

event OnClickItem (string strID, int Index);

event OnDBClickItem (string strID, int Index);

event OnRClickItem (string strID, int Index);

event OnRDBClickItem (string strID, int Index);

event OnRClickItemWithHandle (ItemWindowHandle a_hItemWindow, int a_Index);

event OnDBClickItemWithHandle (ItemWindowHandle a_hItemWindow, int a_Index);

event OnSelectItemWithHandle (ItemWindowHandle a_hItemWindow, int a_Index);

event OnProgressTimeUp (string strID);

event OnComboBoxItemSelected (string strID, int Index);

event OnTextureAnimEnd (AnimTextureHandle a_AnimTextureHandle);

native final function ProcessChatMessage (string chatMessage, int Type);

native final function ProcessPetitionChatMessage (string a_strChatMsg);

native final function ProcessPartyMatchChatMessage (string a_strChatMsg);

native final function ProcessCommandChatMessage (string a_strChatMsg);

native final function ProcessCommandInterPartyChatMessage (string a_strChatMsg);

native final function PlaySound (string strSoundName);

native final function StopSound (string a_SoundName);

native final function RequestOpenMinimap ();

event OnModifyCurrentTickSliderCtrl (string strID, int iCurrentTick);

native final function string GetZoneNameWithZoneID (int a_ZoneID);

native final function string GetCurrentZoneName ();

native final function string GetLootingMethodName (int a_LootingMethodID);

native final function RequestHennaItemInfo (int iHennaID);

native final function RequestHennaItemList ();

native final function RequestHennaEquip (int iHennaID);

native final function RequestHennaUnEquipInfo (int iHennaID);

native final function RequestHennaUnEquipList ();

native final function RequestHennaUnEquip (int iHennaID);

native final function SetChatMessage (string a_Message);

native function Vector GetPlayerPosition ();

native final function GetFileList (out array<string> FileList, string strDir, string strExtention);

native final function BeginReplay (string strFileName, bool bLoadCameraInst, bool bLoadChatData);

native final function EraseReplayFile (string strFileName);

native final function BeginPlay ();

native final function BeginBenchMark ();

native final function RequestAcquireSkillInfo (int iID, int iLevel, int iType);

native final function RequestExEnchantSkillInfo (int iID, int iLevel);

native final function RequestAcquireSkill (int iID, int iLevel, int iType);

native final function RequestExEnchantSkill (int iID, int iLevel);

native final function RequestObserverModeEnd ();

native final function WindowHandle GetHandle (string a_ControlID);

native final function RequestFishRanking ();

native final function InitFishViewportWnd (bool Event);

native final function FishFinalAction ();

native final function SaveInventoryOrder (array<int> ORDER);

native final function bool LoadInventoryOrder (out array<int> ORDER);

native final function RequestProcureCropList (string param);

native final function int GetManorCount ();

native final function int GetManorIDInManorList (int Index);

native final function string GetManorNameInManorList (int Index);

native final function ToggleMsnWindow ();

native final function bool GetQuestLocation (Vector Location);

native final function RequestLoadAllItem ();

native final function float GetPawnFrameCount ();

native final function float GetPawnCurrentFrame ();