//================================================================================
// PrivateShopWnd.
//================================================================================

class PrivateShopWnd extends UICommonAPI;

enum PrivateShopType {
	PT_None,
	PT_Buy,
	PT_Sell,
	PT_BuyList,
	PT_SellList
};

var int m_merchantID;
var PrivateShopType m_type;
var int m_buyMaxCount;
var int m_sellMaxCount;
var bool m_bBulk;


const DIALOG_CONFIRM_PRICE_FINAL= 666;
const DIALOG_EDIT_SHOP_MESSAGE= 555;
const DIALOG_CONFIRM_PRICE= 444;
const DIALOG_ASK_PRICE= 333;
const DIALOG_BOTTOM_TO_TOP= 222;
const DIALOG_TOP_TO_BOTTOM= 111;

function OnLoad ()
{
	RegisterEvent(2120);
	RegisterEvent(2130);
	RegisterEvent(2070);
	RegisterEvent(1710);
	m_merchantID = 0;
	m_buyMaxCount = 0;
	m_sellMaxCount = 0;
}

function OnSendPacketWhenHiding ()
{
	RequestQuit();
}

function OnHide ()
{
	local DialogBox DialogBox;

	DialogBox = DialogBox(GetScript("DialogBox"));
	if ( Class'UIAPI_WINDOW'.IsShowWindow("DialogBox") )
	{
		DialogBox.HandleCancel();
	}
	Clear();
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2120:		
		L2jBRFunction6(L2jBRVar1);
		break;
		case 2130:
		HandleAddItem(L2jBRVar1);
		break;
		case 2070:
		HandleSetMaxCount(L2jBRVar1);
		break;
		case 1710:
		HandleDialogOK();
		break;
		default:
		break;
	}
}

function OnClickButton (string ControlName)
{
	local int Index;

	if ( UnknownFunction122(ControlName,"UpButton") )
	{
		Index = Class'UIAPI_ITEMWINDOW'.GetSelectedNum("PrivateShopWnd.BottomList");
		MoveItemBottomToTop(Index,False);
	} else {
		if ( UnknownFunction122(ControlName,"DownButton") )
		{
			Index = Class'UIAPI_ITEMWINDOW'.GetSelectedNum("PrivateShopWnd.TopList");
			MoveItemTopToBottom(Index,False);
		} else {
			if ( UnknownFunction122(ControlName,"OKButton") )
			{
				HandleOKButton(True);
			} else {
				if ( UnknownFunction122(ControlName,"StopButton") )
				{
					RequestQuit();
					HideWindow("PrivateShopWnd");
				} else {
					if ( UnknownFunction122(ControlName,"MessageButton") )
					{
						DialogSetEditBoxMaxLength(29);
						DialogSetID(555);
						if ( UnknownFunction154(m_type,4) )
						{
							DialogSetString(GetPrivateShopMessage("sell"));
						} else {
							if ( UnknownFunction154(m_type,3) )
							{
								DialogSetString(GetPrivateShopMessage("buy"));
							}
						}
						DialogSetDefaultOK();
						DialogShow(2,GetSystemMessage(334));
					}
				}
			}
		}
	}
}

function OnDBClickItem (string ControlName, int Index)
{
	if ( UnknownFunction122(ControlName,"TopList") )
	{
		MoveItemTopToBottom(Index,False);
	} else {
		if ( UnknownFunction122(ControlName,"BottomList") )
		{
			MoveItemBottomToTop(Index,False);
		}
	}
}

function OnClickItem (string ControlName, int Index)
{
	local WindowHandle m_dialogWnd;

	m_dialogWnd = GetHandle("DialogBox");
	if ( UnknownFunction122(ControlName,"TopList") )
	{
		if ( UnknownFunction130(DialogIsMine(),m_dialogWnd.IsShowWindow()) )
		{
			DialogHide();
			m_dialogWnd.HideWindow();
		}
	}
}


function OnDropItem (string strID, ItemInfo Info, int X, int Y)
{
	local int Index;

	Index = -1;
	if ( UnknownFunction130(UnknownFunction122(strID,"TopList"),UnknownFunction122(Info.DragSrcName,"BottomList")) )
	{
		if ( UnknownFunction132(UnknownFunction154(m_type,1),UnknownFunction154(m_type,4)) )
		{
			Index = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.BottomList",Info.ServerID);
		} else {
			if ( UnknownFunction132(UnknownFunction154(m_type,2),UnknownFunction154(m_type,3)) )
			{
				Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.BottomList",Info.ClassID);
			}
		}
		if ( UnknownFunction153(Index,0) )
		{
			MoveItemBottomToTop(Index,UnknownFunction151(Info.AllItemCount,0));
		}
	} else {
		if ( UnknownFunction130(UnknownFunction122(strID,"BottomList"),UnknownFunction122(Info.DragSrcName,"TopList")) )
		{
			if ( UnknownFunction132(UnknownFunction154(m_type,1),UnknownFunction154(m_type,4)) )
			{
				Index = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",Info.ServerID);
			} else {
				if ( UnknownFunction132(UnknownFunction154(m_type,2),UnknownFunction154(m_type,3)) )
				{
					Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.TopList",Info.ClassID);
				}
			}
			if ( UnknownFunction153(Index,0) )
			{
				MoveItemTopToBottom(Index,UnknownFunction151(Info.AllItemCount,0));
			}
		}
	}
}


function Clear ()
{
	m_type = 0;
	m_merchantID = -1;
	m_bBulk = False;
	Class'UIAPI_ITEMWINDOW'.Clear("PrivateShopWnd.TopList");
	Class'UIAPI_ITEMWINDOW'.Clear("PrivateShopWnd.BottomList");
	Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.PriceText","0");
	Class'UIAPI_TEXTBOX'.SetTooltipString("PrivateShopWnd.PriceText","");
	Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.AdenaText","0");
	Class'UIAPI_TEXTBOX'.SetTooltipString("PrivateShopWnd.AdenaText","");
}

function RequestQuit ()
{
	if ( UnknownFunction154(m_type,3) )
	{
		RequestQuitPrivateShop("buy");
	} else {
		if ( UnknownFunction154(m_type,4) )
		{
			RequestQuitPrivateShop("sell");
		}
	}
}

function MoveItemTopToBottom (int Index, bool bAllItem)
{
	local ItemInfo Info;
	local ItemInfo bottomInfo;
	local int Num;
	local int i;
	local int bottomIndex;

	if ( Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",Index,Info) )
	{
		if ( UnknownFunction154(m_type,4) )
		{
			DialogSetID(333);
			DialogSetReservedInt(Info.ServerID);
		}
	}
}

function MoveItemBottomToTop (int Index, bool bAllItem)
{
	local ItemInfo Info;
	local ItemInfo topInfo;
	local int stringIndex;
	local int Num;
	local int i;
	local int topIndex;

	if ( Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",Index,Info) )
	{
		if ( UnknownFunction130(UnknownFunction154(m_type,1),m_bBulk) )
		{
			Num = Class'UIAPI_ITEMWINDOW'.GetItemNum("PrivateShopWnd.BottomList");
			i = 0;
			if ( UnknownFunction150(i,Num) )
			{
				Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",i,Info);
				Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.TopList",Info);
				UnknownFunction163(i);
				goto JL0089;
			}
			Class'UIAPI_ITEMWINDOW'.Clear("PrivateShopWnd.BottomList");
			AdjustPrice();
			AdjustCount();
		} else {
			if ( UnknownFunction130(UnknownFunction130(UnknownFunction129(bAllItem),IsStackableItem(Info.ConsumeType)),UnknownFunction151(Info.ItemNum,1)) )
			{
				DialogSetID(222);
				if ( UnknownFunction132(UnknownFunction154(m_type,1),UnknownFunction154(m_type,4)) )
				{
					DialogSetReservedInt(Info.ServerID);
				} else {
					if ( UnknownFunction132(UnknownFunction154(m_type,2),UnknownFunction154(m_type,3)) )
					{
						DialogSetReservedInt(Info.ClassID);
					}
				}
				DialogSetParamInt(Info.ItemNum);
				switch (m_type)
				{
					case 4:
					stringIndex = 72;
					break;
					case 3:
					stringIndex = 571;
					break;
					case 2:
					stringIndex = 72;
					break;
					case 1:
					stringIndex = 72;
					break;
					default:
					break;
				}
				DialogSetDefaultOK();
				DialogShow(6,MakeFullSystemMsg(GetSystemMessage(stringIndex),Info.Name,""));
			} else {
				Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.BottomList",Index);
				if ( UnknownFunction155(m_type,3) )
				{
					if ( UnknownFunction132(UnknownFunction154(m_type,1),UnknownFunction154(m_type,4)) )
					{
						topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",Info.ServerID);
					} else {
						if ( UnknownFunction154(m_type,2) )
						{
							topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.TopList",Info.ClassID);
						}
					}
					if ( UnknownFunction130(UnknownFunction153(topIndex,0),IsStackableItem(Info.ConsumeType)) )
					{
						Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
						UnknownFunction161(topInfo.ItemNum,Info.ItemNum);
						Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.TopList",topIndex,topInfo);
					} else {
						Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.TopList",Info);
					}
				}
				AdjustPrice();
				AdjustCount();
			}
		}
		if ( UnknownFunction154(m_type,1) )
		{
			AdjustWeight();
		}
	}
}

function HandleDialogOK ()
{
	local int Id;
	local int inputNum;
	local int L2jBRVar39;
	local int bottomIndex;
	local int topIndex;
	local int i;
	local int allItem;
	local ItemInfo bottomInfo;
	local ItemInfo topInfo;

	if ( DialogIsMine() )
	{
		Id = DialogGetID();
		inputNum = int(DialogGetString());
		L2jBRVar39 = DialogGetReservedInt();
		if ( UnknownFunction154(m_type,4) )
		{
			if ( UnknownFunction130(UnknownFunction154(Id,111),UnknownFunction151(inputNum,0)) )
			{
				topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",L2jBRVar39);
				if ( UnknownFunction153(topIndex,0) )
				{
					Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
					bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.BottomList",L2jBRVar39);
					Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
					if ( UnknownFunction130(UnknownFunction153(bottomIndex,0),IsStackableItem(bottomInfo.ConsumeType)) )
					{
						bottomInfo.Price = DialogGetReservedInt2();
						UnknownFunction161(bottomInfo.ItemNum,UnknownFunction249(inputNum,topInfo.ItemNum));
						Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
					} else {
						bottomInfo = topInfo;
						bottomInfo.ItemNum = UnknownFunction249(inputNum,topInfo.ItemNum);
						bottomInfo.Price = DialogGetReservedInt2();
						Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.BottomList",bottomInfo);
					}
					UnknownFunction162(topInfo.ItemNum,inputNum);
					if ( UnknownFunction152(topInfo.ItemNum,0) )
					{
						Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.TopList",topIndex);
					} else {
						Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.TopList",topIndex,topInfo);
					}
				}
				AdjustPrice();
				AdjustCount();
			} else {
				if ( UnknownFunction130(UnknownFunction154(Id,222),UnknownFunction151(inputNum,0)) )
				{
					bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.BottomList",L2jBRVar39);
					if ( UnknownFunction153(bottomIndex,0) )
					{
						Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
						topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",L2jBRVar39);
						if ( UnknownFunction130(UnknownFunction153(topIndex,0),IsStackableItem(bottomInfo.ConsumeType)) )
						{
							Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
							UnknownFunction161(topInfo.ItemNum,UnknownFunction249(inputNum,bottomInfo.ItemNum));
							Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.TopList",topIndex,topInfo);
						} else {
							topInfo = bottomInfo;
							topInfo.ItemNum = UnknownFunction249(inputNum,bottomInfo.ItemNum);
							Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.TopList",topInfo);
						}
						UnknownFunction162(bottomInfo.ItemNum,inputNum);
						if ( UnknownFunction151(bottomInfo.ItemNum,0) )
						{
							Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
						} else {
							Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.BottomList",bottomIndex);
						}
					}
					AdjustPrice();
					AdjustCount();
				} else {
					if ( UnknownFunction154(Id,444) )
					{
						topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",L2jBRVar39);
						if ( UnknownFunction153(topIndex,0) )
						{
							allItem = DialogGetReservedInt3();
							Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
							if ( UnknownFunction130(UnknownFunction130(UnknownFunction154(allItem,0),IsStackableItem(topInfo.ConsumeType)),UnknownFunction155(topInfo.ItemNum,1)) )
							{
								DialogSetID(111);
								if ( UnknownFunction154(topInfo.ItemNum,0) )
								{
									topInfo.ItemNum = 1;
								}
								DialogSetParamInt(topInfo.ItemNum);
								DialogSetDefaultOK();
								DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),topInfo.Name,""));
							} else {
								if ( UnknownFunction154(allItem,0) )
								{
									topInfo.ItemNum = 1;
								}
								topInfo.Price = DialogGetReservedInt2();
								bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.BottomList",topInfo.ServerID);
								if ( UnknownFunction130(UnknownFunction153(bottomIndex,0),IsStackableItem(topInfo.ConsumeType)) )
								{
									Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
									UnknownFunction161(topInfo.ItemNum,bottomInfo.ItemNum);
									Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,topInfo);
								} else {
									Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.BottomList",topInfo);
								}
								Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.TopList",topIndex);
								AdjustPrice();
								AdjustCount();
							}
						}
					} else {
						if ( UnknownFunction130(UnknownFunction154(Id,333),UnknownFunction151(inputNum,0)) )
						{
							topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",L2jBRVar39);
							if ( UnknownFunction153(topIndex,0) )
							{
								Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
								if ( UnknownFunction153(inputNum,2000000000) )
								{
									DialogShow(5,GetSystemMessage(1369));
								} else {
									if ( UnknownFunction129(IsProperPrice(topInfo,inputNum)) )
									{
										DialogSetID(444);
										DialogSetReservedInt(topInfo.ServerID);
										DialogSetReservedInt2(inputNum);
										DialogSetDefaultOK();
										DialogShow(4,GetSystemMessage(569));
									} else {
										allItem = DialogGetReservedInt3();
										if ( UnknownFunction130(UnknownFunction154(allItem,0),IsStackableItem(topInfo.ConsumeType)) )
										{
											DialogSetID(111);
											DialogSetReservedInt(topInfo.ServerID);
											DialogSetReservedInt2(inputNum);
											DialogSetReservedInt3(allItem);
											DialogSetParamInt(topInfo.ItemNum);
											DialogSetDefaultOK();
											DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),topInfo.Name,""));
										} else {
											if ( UnknownFunction154(allItem,0) )
											{
												topInfo.ItemNum = 1;
											}
											topInfo.Price = inputNum;
											bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.BottomList",topInfo.ServerID);
											if ( UnknownFunction130(UnknownFunction153(bottomIndex,0),IsStackableItem(topInfo.ConsumeType)) )
											{
												Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
												UnknownFunction161(topInfo.ItemNum,bottomInfo.ItemNum);
												Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,topInfo);
											} else {
												Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.BottomList",topInfo);
											}
											Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.TopList",topIndex);
											AdjustPrice();
											AdjustCount();
										}
									}
								}
							}
						} else {
							if ( UnknownFunction154(Id,555) )
							{
								SetPrivateShopMessage("sell",DialogGetString());
							}
						}
					}
				}
			}
		} else {
			if ( UnknownFunction154(m_type,3) )
			{
				if ( UnknownFunction130(UnknownFunction154(Id,111),UnknownFunction151(inputNum,0)) )
				{
					topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.TopList",L2jBRVar39);
					if ( UnknownFunction153(topIndex,0) )
					{
						Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
						bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.BottomList",L2jBRVar39);
						Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
						if ( UnknownFunction130(UnknownFunction153(bottomIndex,0),IsStackableItem(bottomInfo.ConsumeType)) )
						{
							bottomInfo.Price = DialogGetReservedInt2();
							UnknownFunction161(bottomInfo.ItemNum,inputNum);
							Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
							return;
						}
						if ( UnknownFunction153(bottomIndex,0) )
						{
							i = Class'UIAPI_ITEMWINDOW'.GetItemNum("PrivateShopWnd.BottomList");
							if ( UnknownFunction153(i,0) )
							{
								Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",i,bottomInfo);
								if ( UnknownFunction154(bottomInfo.ClassID,L2jBRVar39) )
								{
									Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.BottomList",i);
								}
								UnknownFunction164(i);
								goto JL0C5A;
							}
						}
						if ( IsStackableItem(topInfo.ConsumeType) )
						{
							bottomInfo = topInfo;
							bottomInfo.ItemNum = inputNum;
							bottomInfo.Price = DialogGetReservedInt2();
							Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.BottomList",bottomInfo);
						} else {
							bottomInfo = topInfo;
							bottomInfo.ItemNum = 1;
							bottomInfo.Price = DialogGetReservedInt2();
							i = 0;
							if ( UnknownFunction150(i,inputNum) )
							{
								Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.BottomList",bottomInfo);
								UnknownFunction163(i);
								goto JL0D86;
							}
						}
					}
					AdjustPrice();
					AdjustCount();
				} else {
					if ( UnknownFunction130(UnknownFunction154(Id,222),UnknownFunction151(inputNum,0)) )
					{
						bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.BottomList",L2jBRVar39);
						if ( UnknownFunction153(bottomIndex,0) )
						{
							Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
							UnknownFunction162(bottomInfo.ItemNum,inputNum);
							if ( UnknownFunction151(bottomInfo.ItemNum,0) )
							{
								Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
							} else {
								Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.BottomList",bottomIndex);
							}
						}
					} else {
						if ( UnknownFunction154(Id,444) )
						{
							topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.TopList",L2jBRVar39);
							if ( UnknownFunction153(topIndex,0) )
							{
								Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
								DialogSetID(111);
								DialogSetReservedInt(topInfo.ClassID);
								DialogSetParamInt(topInfo.ItemNum);
								DialogSetDefaultOK();
								DialogShow(6,MakeFullSystemMsg(GetSystemMessage(570),topInfo.Name,""));
							}
							AdjustPrice();
							AdjustCount();
						} else {
							if ( UnknownFunction130(UnknownFunction154(Id,333),UnknownFunction151(inputNum,0)) )
							{
								topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.TopList",L2jBRVar39);
								if ( UnknownFunction153(topIndex,0) )
								{
									Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
									if ( UnknownFunction153(inputNum,2000000000) )
									{
										DialogShow(5,GetSystemMessage(1369));
									} else {
										if ( UnknownFunction129(IsProperPrice(topInfo,inputNum)) )
										{
											DialogSetID(444);
											DialogSetReservedInt(topInfo.ClassID);
											DialogSetReservedInt2(inputNum);
											DialogSetDefaultOK();
											DialogShow(4,GetSystemMessage(569));
										} else {
											DialogSetID(111);
											DialogSetReservedInt(topInfo.ClassID);
											DialogSetReservedInt2(inputNum);
											DialogSetParamInt(topInfo.ItemNum);
											DialogSetDefaultOK();
											DialogShow(6,MakeFullSystemMsg(GetSystemMessage(570),topInfo.Name,""));
										}
									}
								}
							} else {
								if ( UnknownFunction154(Id,555) )
								{
									SetPrivateShopMessage("buy",DialogGetString());
								}
							}
						}
					}
				}
			} else {
				if ( UnknownFunction132(UnknownFunction154(m_type,1),UnknownFunction154(m_type,2)) )
				{
					if ( UnknownFunction130(UnknownFunction154(Id,111),UnknownFunction151(inputNum,0)) )
					{
						topIndex = -1;
						if ( UnknownFunction154(m_type,1) )
						{
							topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",L2jBRVar39);
						} else {
							if ( UnknownFunction154(m_type,2) )
							{
								topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.TopList",L2jBRVar39);
							}
						}
						if ( UnknownFunction153(topIndex,0) )
						{
							Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
							if ( UnknownFunction130(UnknownFunction154(m_type,2),UnknownFunction150(topInfo.Reserved,inputNum)) )
							{
								DialogShow(5,GetSystemMessage(1036));
							} else {
								if ( UnknownFunction154(m_type,1) )
								{
									bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.BottomList",L2jBRVar39);
								} else {
									if ( UnknownFunction154(m_type,2) )
									{
										bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.BottomList",L2jBRVar39);
									}
								}
								Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
								if ( UnknownFunction153(bottomIndex,0) )
								{
									UnknownFunction161(bottomInfo.ItemNum,UnknownFunction249(inputNum,topInfo.ItemNum));
									Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
								} else {
									bottomInfo = topInfo;
									bottomInfo.ItemNum = UnknownFunction249(inputNum,topInfo.ItemNum);
									Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.BottomList",bottomInfo);
								}
								UnknownFunction162(topInfo.ItemNum,inputNum);
								if ( UnknownFunction152(topInfo.ItemNum,0) )
								{
									Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.TopList",topIndex);
								} else {
									Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.TopList",topIndex,topInfo);
								}
							}
						}
						AdjustPrice();
						AdjustCount();
					} else {
						if ( UnknownFunction130(UnknownFunction154(Id,222),UnknownFunction151(inputNum,0)) )
						{
							bottomIndex = -1;
							if ( UnknownFunction154(m_type,1) )
							{
								bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.BottomList",L2jBRVar39);
							} else {
								if ( UnknownFunction154(m_type,2) )
								{
									bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.BottomList",L2jBRVar39);
								}
							}
							if ( UnknownFunction153(bottomIndex,0) )
							{
								Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
								topIndex = -1;
								if ( UnknownFunction154(m_type,1) )
								{
									topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("PrivateShopWnd.TopList",L2jBRVar39);
								} else {
									if ( UnknownFunction154(m_type,2) )
									{
										topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PrivateShopWnd.TopList",L2jBRVar39);
									}
								}
								if ( UnknownFunction153(topIndex,0) )
								{
									Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.TopList",topIndex,topInfo);
									UnknownFunction161(topInfo.ItemNum,UnknownFunction249(inputNum,bottomInfo.ItemNum));
									Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.TopList",topIndex,topInfo);
								} else {
									topInfo = bottomInfo;
									topInfo.ItemNum = UnknownFunction249(inputNum,bottomInfo.ItemNum);
									Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.TopList",topInfo);
								}
								UnknownFunction162(bottomInfo.ItemNum,inputNum);
								if ( UnknownFunction151(bottomInfo.ItemNum,0) )
								{
									Class'UIAPI_ITEMWINDOW'.SetItem("PrivateShopWnd.BottomList",bottomIndex,bottomInfo);
								} else {
									Class'UIAPI_ITEMWINDOW'.DeleteItem("PrivateShopWnd.BottomList",bottomIndex);
								}
							}
							AdjustPrice();
							AdjustCount();
						} else {
							if ( UnknownFunction154(Id,666) )
							{
								HandleOKButton(False);
							}
						}
					}
					if ( UnknownFunction154(m_type,1) )
					{
						AdjustWeight();
					}
				}
			}
		}
	}
}


function L2jBRFunction6 (string L2jBRVar1)
{
	local string L2jBRVar5;
	local int Adena;
	local int bulk;
	local string L2jBRVar14;
	local UserInfo User;
	local WindowHandle m_inventoryWnd;

	m_inventoryWnd = GetHandle("InventoryWnd");
	Clear();
	ParseString(L2jBRVar1,"type",L2jBRVar5);
	ParseInt(L2jBRVar1,"adena",Adena);
	ParseInt(L2jBRVar1,"userID",m_merchantID);
	ParseInt(L2jBRVar1,"bulk",bulk);
	if ( UnknownFunction151(bulk,0) )
	{
		m_bBulk = True;
	} else {
		m_bBulk = False;
	}
	switch (L2jBRVar5)
	{
		case "buy":
		m_type = 1;
		break;
		case "sell":
		m_type = 2;
		break;
		case "buyList":
		m_type = 3;
		break;
		case "sellList":
		m_type = 4;
		break;
		default:
		break;
	}
	L2jBRVar14 = MakeCostString(string(Adena));
	Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.AdenaText",L2jBRVar14);
	Class'UIAPI_TEXTBOX'.SetTooltipString("PrivateShopWnd.AdenaText",ConvertNumToText(string(Adena)));
	if ( m_inventoryWnd.IsShowWindow() )
	{
		m_inventoryWnd.HideWindow();
	}
	ShowWindow("PrivateShopWnd");
	Class'UIAPI_WINDOW'.SetFocus("PrivateShopWnd");
	if ( UnknownFunction154(m_type,3) )
	{
		Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.TopList","Inventory");
		Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.BottomList","InventoryPrice1");
		Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.TopText",GetSystemString(1));
		Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.BottomText",GetSystemString(502));
		Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.PriceConstText",GetSystemString(142));
		Class'UIAPI_BUTTON'.SetButtonName("PrivateShopWnd.OKButton",428);
		ShowWindow("PrivateShopWnd.BottomCountText");
		ShowWindow("PrivateShopWnd.StopButton");
		ShowWindow("PrivateShopWnd.MessageButton");
		ShowWindow("PrivateShopWnd.OKButton");
		HideWindow("PrivateShopWnd.CheckBulk");
		Class'UIAPI_WINDOW'.SetWindowTitleByText("PrivateShopWnd",UnknownFunction112(UnknownFunction112(UnknownFunction112(GetSystemString(498),"("),GetSystemString(1434)),")"));
	} else {
		if ( UnknownFunction154(m_type,4) )
		{
			Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.TopList","Inventory");
			Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.BottomList","InventoryPrice1");
			if ( UnknownFunction151(bulk,0) )
			{
				Class'UIAPI_CHECKBOX'.SetCheck("PrivateShopWnd.CheckBulk",True);
			} else {
				Class'UIAPI_CHECKBOX'.SetCheck("PrivateShopWnd.CheckBulk",False);
			}
			Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.TopText",GetSystemString(1));
			Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.BottomText",GetSystemString(137));
			Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.PriceConstText",GetSystemString(143));
			Class'UIAPI_BUTTON'.SetButtonName("PrivateShopWnd.OKButton",428);
			ShowWindow("PrivateShopWnd.BottomCountText");
			ShowWindow("PrivateShopWnd.StopButton");
			ShowWindow("PrivateShopWnd.MessageButton");
			ShowWindow("PrivateShopWnd.OKButton");
			ShowWindow("PrivateShopWnd.CheckBulk");
			Class'UIAPI_WINDOW'.SetWindowTitleByText("PrivateShopWnd",UnknownFunction112(UnknownFunction112(UnknownFunction112(GetSystemString(498),"("),GetSystemString(1157)),")"));
		} else {
			if ( UnknownFunction154(m_type,1) )
			{
				Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.TopList","InventoryPrice1");
				Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.BottomList","Inventory");
				Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.TopText",GetSystemString(137));
				Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.BottomText",GetSystemString(139));
				Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.PriceConstText",GetSystemString(142));
				Class'UIAPI_BUTTON'.SetButtonName("PrivateShopWnd.OKButton",140);
				HideWindow("PrivateShopWnd.BottomCountText");
				HideWindow("PrivateShopWnd.StopButton");
				HideWindow("PrivateShopWnd.MessageButton");
				ShowWindow("PrivateShopWnd.OKButton");
				HideWindow("PrivateShopWnd.CheckBulk");
				GetUserInfo(m_merchantID,User);
				if ( UnknownFunction151(bulk,0) )
				{
					Class'UIAPI_WINDOW'.SetWindowTitleByText("PrivateShopWnd",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(GetSystemString(498),"("),GetSystemString(1198)),") - "),User.Name));
				} else {
					Class'UIAPI_WINDOW'.SetWindowTitleByText("PrivateShopWnd",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(GetSystemString(498),"("),GetSystemString(1157)),") - "),User.Name));
				}
			} else {
				if ( UnknownFunction154(m_type,2) )
				{
					Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.TopList","InventoryPrice2PrivateShop");
					Class'UIAPI_WINDOW'.SetTooltipType("PrivateShopWnd.BottomList","Inventory");
					Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.TopText",GetSystemString(503));
					Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.BottomText",GetSystemString(137));
					Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.PriceConstText",GetSystemString(143));
					Class'UIAPI_BUTTON'.SetButtonName("PrivateShopWnd.OKButton",140);
					HideWindow("PrivateShopWnd.BottomCountText");
					HideWindow("PrivateShopWnd.StopButton");
					HideWindow("PrivateShopWnd.MessageButton");
					ShowWindow("PrivateShopWnd.OKButton");
					HideWindow("PrivateShopWnd.CheckBulk");
					GetUserInfo(m_merchantID,User);
					Class'UIAPI_WINDOW'.SetWindowTitleByText("PrivateShopWnd",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(GetSystemString(498),"("),GetSystemString(1434)),") - "),User.Name));
				}
			}
		}
	}
}

function HandleAddItem (string L2jBRVar1)
{
	local ItemInfo Info;
	local string Target;

	ParseString(L2jBRVar1,"target",Target);
	ParamToItemInfo(L2jBRVar1,Info);
	if ( UnknownFunction122(Target,"topList") )
	{
		if ( UnknownFunction130(UnknownFunction154(m_type,2),UnknownFunction154(Info.ItemNum,0)) )
		{
			Info.bDisabled = True;
		}
		Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.TopList",Info);
	} else {
		if ( UnknownFunction122(Target,"bottomList") )
		{
			Class'UIAPI_ITEMWINDOW'.AddItem("PrivateShopWnd.BottomList",Info);
		}
	}
	AdjustPrice();
	AdjustCount();
}

function AdjustPrice ()
{
	local string Adena;
	local int L2jBRVar15_;
	local INT64 Price;
	local INT64 addPrice64;
	local ItemInfo Info;

	L2jBRVar15_ = Class'UIAPI_ITEMWINDOW'.GetItemNum("PrivateShopWnd.BottomList");
	Price = Int2Int64(0);
	addPrice64 = Int2Int64(0);
	if ( UnknownFunction151(L2jBRVar15_,0) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",UnknownFunction147(L2jBRVar15_,1),Info);
		addPrice64 = Int64Mul(Info.Price,Info.ItemNum);
		Price = Int64Add(Price,addPrice64);
		UnknownFunction164(L2jBRVar15_);
		goto JL004A;
	}
	if ( UnknownFunction132(UnknownFunction150(Price.nLeft,0),UnknownFunction150(Price.nRight,0)) )
	{
		Price = Int2Int64(0);
	}
	Adena = MakeCostStringInt64(Price);
	Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.PriceText",Adena);
	Class'UIAPI_TEXTBOX'.SetTooltipString("PrivateShopWnd.PriceText",ConvertNumToText(MakeCostStringInt64(Price)));
}

function AdjustCount ()
{
	local int Num;
	local int maxNum;

	if ( UnknownFunction154(m_type,4) )
	{
		maxNum = m_sellMaxCount;
		Num = Class'UIAPI_ITEMWINDOW'.GetItemNum("PrivateShopWnd.BottomList");
		Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.BottomCountText",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(Num)),"/"),string(maxNum)),")"));
	} else {
		if ( UnknownFunction154(m_type,3) )
		{
			maxNum = m_buyMaxCount;
			Num = Class'UIAPI_ITEMWINDOW'.GetItemNum("PrivateShopWnd.BottomList");
			Class'UIAPI_TEXTBOX'.SetText("PrivateShopWnd.BottomCountText",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(Num)),"/"),string(maxNum)),")"));
		}
	}
}

function AdjustWeight ()
{
	local int L2jBRVar15_;
	local int Weight;
	local ItemInfo Info;

	Class'UIAPI_INVENWEIGHT'.ZeroWeight("PrivateShopWnd.InvenWeight");
	L2jBRVar15_ = Class'UIAPI_ITEMWINDOW'.GetItemNum("PrivateShopWnd.BottomList");
	Weight = 0;
	if ( UnknownFunction151(L2jBRVar15_,0) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",UnknownFunction147(L2jBRVar15_,1),Info);
		UnknownFunction161(Weight,UnknownFunction144(Info.Weight,Info.ItemNum));
		UnknownFunction164(L2jBRVar15_);
		goto JL0062;
	}
	Class'UIAPI_INVENWEIGHT'.AddWeight("PrivateShopWnd.InvenWeight",Weight);
}

function HandleOKButton (bool bPriceCheck)
{
	local string L2jBRVar1;
	local int ItemCount;
	local int itemIndex;
	local ItemInfo ItemInfo;

	ItemCount = Class'UIAPI_ITEMWINDOW'.GetItemNum("PrivateShopWnd.BottomList");
	if ( UnknownFunction154(m_type,4) )
	{
		if ( Class'UIAPI_CHECKBOX'.IsChecked("PrivateShopWnd.CheckBulk") )
		{
			ParamAdd(L2jBRVar1,"bulk","1");
		} else {
			ParamAdd(L2jBRVar1,"bulk","0");
		}
		ParamAdd(L2jBRVar1,"num",string(ItemCount));
		itemIndex = 0;
		if ( UnknownFunction150(itemIndex,ItemCount) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",itemIndex,ItemInfo);
			ParamAdd(L2jBRVar1,UnknownFunction112("serverID",string(itemIndex)),string(ItemInfo.ServerID));
			ParamAdd(L2jBRVar1,UnknownFunction112("count",string(itemIndex)),string(ItemInfo.ItemNum));
			ParamAdd(L2jBRVar1,UnknownFunction112("price",string(itemIndex)),string(ItemInfo.Price));
			UnknownFunction163(itemIndex);
			goto JL00B5;
		}
		SendPrivateShopList("sellList",L2jBRVar1);
	} else {
		if ( UnknownFunction154(m_type,1) )
		{
			ParamAdd(L2jBRVar1,"merchantID",string(m_merchantID));
			ParamAdd(L2jBRVar1,"num",string(ItemCount));
			itemIndex = 0;
			if ( UnknownFunction150(itemIndex,ItemCount) )
			{
				Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",itemIndex,ItemInfo);
				if ( UnknownFunction130(bPriceCheck,UnknownFunction129(IsProperPrice(ItemInfo,ItemInfo.Price))) )
				{
					goto JL02CB;
				}
				ParamAdd(L2jBRVar1,UnknownFunction112("serverID",string(itemIndex)),string(ItemInfo.ServerID));
				ParamAdd(L2jBRVar1,UnknownFunction112("count",string(itemIndex)),string(ItemInfo.ItemNum));
				ParamAdd(L2jBRVar1,UnknownFunction112("price",string(itemIndex)),string(ItemInfo.Price));
				UnknownFunction163(itemIndex);
				goto JL01DE;
			}
			if ( UnknownFunction130(bPriceCheck,UnknownFunction150(itemIndex,ItemCount)) )
			{
				DialogSetID(666);
				DialogShow(4,GetSystemMessage(569));
				return;
			} else {
				SendPrivateShopList("buy",L2jBRVar1);
			}
		} else {
			if ( UnknownFunction154(m_type,3) )
			{
				ParamAdd(L2jBRVar1,"num",string(ItemCount));
				itemIndex = 0;
				if ( UnknownFunction150(itemIndex,ItemCount) )
				{
					Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",itemIndex,ItemInfo);
					ParamAdd(L2jBRVar1,UnknownFunction112("classID",string(itemIndex)),string(ItemInfo.ClassID));
					ParamAdd(L2jBRVar1,UnknownFunction112("enchanted",string(itemIndex)),string(ItemInfo.Enchanted));
					ParamAdd(L2jBRVar1,UnknownFunction112("damaged",string(itemIndex)),string(ItemInfo.Damaged));
					ParamAdd(L2jBRVar1,UnknownFunction112("count",string(itemIndex)),string(ItemInfo.ItemNum));
					ParamAdd(L2jBRVar1,UnknownFunction112("price",string(itemIndex)),string(ItemInfo.Price));
					UnknownFunction163(itemIndex);
					goto JL0349;
				}
				SendPrivateShopList("buyList",L2jBRVar1);
			} else {
				if ( UnknownFunction154(m_type,2) )
				{
					ParamAdd(L2jBRVar1,"merchantID",string(m_merchantID));
					ParamAdd(L2jBRVar1,"num",string(ItemCount));
					itemIndex = 0;
					if ( UnknownFunction150(itemIndex,ItemCount) )
					{
						Class'UIAPI_ITEMWINDOW'.GetItem("PrivateShopWnd.BottomList",itemIndex,ItemInfo);
						if ( UnknownFunction130(bPriceCheck,UnknownFunction129(IsProperPrice(ItemInfo,ItemInfo.Price))) )
						{
							goto JL062E;
						}
						ParamAdd(L2jBRVar1,UnknownFunction112("serverID",string(itemIndex)),string(ItemInfo.ServerID));
						ParamAdd(L2jBRVar1,UnknownFunction112("classID",string(itemIndex)),string(ItemInfo.ClassID));
						ParamAdd(L2jBRVar1,UnknownFunction112("enchanted",string(itemIndex)),string(ItemInfo.Enchanted));
						ParamAdd(L2jBRVar1,UnknownFunction112("damaged",string(itemIndex)),string(ItemInfo.Damaged));
						ParamAdd(L2jBRVar1,UnknownFunction112("count",string(itemIndex)),string(ItemInfo.ItemNum));
						ParamAdd(L2jBRVar1,UnknownFunction112("price",string(itemIndex)),string(ItemInfo.Price));
						UnknownFunction163(itemIndex);
						goto JL04C4;
					}
					if ( UnknownFunction130(bPriceCheck,UnknownFunction150(itemIndex,ItemCount)) )
					{
						DialogSetID(666);
						DialogShow(4,GetSystemMessage(569));
JL04C4:
						return;
					} else {
						SendPrivateShopList("sell",L2jBRVar1);
					}
				}
			}
		}
	}
	HideWindow("PrivateShopWnd");
	Clear();
}

function HandleSetMaxCount (string L2jBRVar1)
{
	ParseInt(L2jBRVar1,"privateShopSell",m_sellMaxCount);
	ParseInt(L2jBRVar1,"privateShopBuy",m_buyMaxCount);
}

function bool IsProperPrice (out ItemInfo Info, int Price)
{
	if ( UnknownFunction130(UnknownFunction151(Info.DefaultPrice,0),UnknownFunction132(UnknownFunction152(Price,UnknownFunction145(Info.DefaultPrice,5)),UnknownFunction153(Price,UnknownFunction144(Info.DefaultPrice,5)))) )
	{
		return False;
	}
	return True;
}

