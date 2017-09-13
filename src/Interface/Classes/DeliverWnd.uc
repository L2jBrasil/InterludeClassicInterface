//================================================================================
// DeliverWnd.
//================================================================================

class DeliverWnd extends UICommonAPI;

var int L2jBRVar90;
const DIALOG_BOTTOM_TO_TOP= 222;
const DIALOG_TOP_TO_BOTTOM= 111;

function OnLoad ()
{
	RegisterEvent(2160);
	RegisterEvent(2170);
	RegisterEvent(1710);
}

function Clear ()
{
	Class'UIAPI_ITEMWINDOW'.Clear("DeliverWnd.TopList");
	Class'UIAPI_ITEMWINDOW'.Clear("DeliverWnd.BottomList");
	Class'UIAPI_TEXTBOX'.SetText("DeliverWnd.PriceText","0");
	Class'UIAPI_TEXTBOX'.SetTooltipString("DeliverWnd.PriceText","");
	Class'UIAPI_TEXTBOX'.SetText("DeliverWnd.AdenaText","0");
	Class'UIAPI_TEXTBOX'.SetTooltipString("DeliverWnd.AdenaText","");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2160:
		
		L2jBRFunction6(L2jBRVar1);
		break;
		case 2170:
		HandleAddItem(L2jBRVar1);
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
		Index = Class'UIAPI_ITEMWINDOW'.GetSelectedNum("DeliverWnd.BottomList");
		MoveItemBottomToTop(Index,0);
	} else {
		if ( UnknownFunction122(ControlName,"DownButton") )
		{
			Index = Class'UIAPI_ITEMWINDOW'.GetSelectedNum("DeliverWnd.TopList");
			MoveItemTopToBottom(Index,0);
		} else {
			if ( UnknownFunction122(ControlName,"OKButton") )
			{
				HandleOKButton();
			} else {
				if ( UnknownFunction122(ControlName,"CancelButton") )
				{
					Clear();
					HideWindow("DeliverWnd");
				}
			}
		}
	}
}

function OnDBClickItem (string ControlName, int Index)
{
	if ( UnknownFunction122(ControlName,"TopList") )
	{
		MoveItemTopToBottom(Index,0);
	} else {
		if ( UnknownFunction122(ControlName,"BottomList") )
		{
			MoveItemBottomToTop(Index,0);
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

	if ( UnknownFunction130(UnknownFunction122(strID,"TopList"),UnknownFunction122(Info.DragSrcName,"BottomList")) )
	{
		Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("DeliverWnd.BottomList",Info.ClassID);
		if ( UnknownFunction153(Index,0) )
		{
			MoveItemBottomToTop(Index,Info.AllItemCount);
		}
	} else {
		if ( UnknownFunction130(UnknownFunction122(strID,"BottomList"),UnknownFunction122(Info.DragSrcName,"TopList")) )
		{
			Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("DeliverWnd.TopList",Info.ClassID);
			if ( UnknownFunction153(Index,0) )
			{
				MoveItemTopToBottom(Index,Info.AllItemCount);
			}
		}
	}
}

function MoveItemTopToBottom (int Index, int AllItemCount)
{
	local ItemInfo Info;

	if ( Class'UIAPI_ITEMWINDOW'.GetItem("DeliverWnd.TopList",Index,Info) )
	{
		if ( UnknownFunction130(IsStackableItem(Info.ConsumeType),UnknownFunction151(Info.ItemNum,1)) )
		{
			if ( UnknownFunction151(AllItemCount,0) )
			{
				ItemTopToBottom(Info.ClassID,AllItemCount);
			} else {
				DialogSetID(111);
				DialogSetReservedInt(Info.ClassID);
				DialogSetParamInt(Info.ItemNum);
				DialogSetDefaultOK();
				DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name,""));
			}
		} else {
			Info.ItemNum = 1;
			Info.bShowCount = False;
			Class'UIAPI_ITEMWINDOW'.AddItem("DeliverWnd.BottomList",Info);
			Class'UIAPI_ITEMWINDOW'.DeleteItem("DeliverWnd.TopList",Index);
			AdjustPrice();
		}
	}
}

function MoveItemBottomToTop (int Index, int AllItemCount)
{
	local ItemInfo Info;

	if ( Class'UIAPI_ITEMWINDOW'.GetItem("DeliverWnd.BottomList",Index,Info) )
	{
		if ( UnknownFunction130(IsStackableItem(Info.ConsumeType),UnknownFunction151(Info.ItemNum,1)) )
		{
			if ( UnknownFunction151(AllItemCount,0) )
			{
				ItemBottomToTop(Info.ClassID,AllItemCount);
			} else {
				DialogSetID(222);
				DialogSetReservedInt(Info.ClassID);
				DialogSetParamInt(Info.ItemNum);
				DialogSetDefaultOK();
				DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name,""));
			}
		} else {
			Class'UIAPI_ITEMWINDOW'.DeleteItem("DeliverWnd.BottomList",Index);
			Class'UIAPI_ITEMWINDOW'.AddItem("DeliverWnd.TopList",Info);
			AdjustPrice();
		}
	}
}

function HandleDialogOK ()
{
	local int Id;
	local int Num;
	local int ClassID;

	if ( DialogIsMine() )
	{
		Id = DialogGetID();
		Num = int(DialogGetString());
		ClassID = DialogGetReservedInt();
		if ( UnknownFunction130(UnknownFunction154(Id,111),UnknownFunction151(Num,0)) )
		{
			ItemTopToBottom(ClassID,Num);
		} else {
			if ( UnknownFunction130(UnknownFunction154(Id,222),UnknownFunction151(Num,0)) )
			{
				ItemBottomToTop(ClassID,Num);
			}
		}
		AdjustPrice();
	}
}

function ItemTopToBottom (int ClassID, int Num)
{
	local int Index;
	local int topIndex;
	local ItemInfo Info;
	local ItemInfo topInfo;

	topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("DeliverWnd.TopList",ClassID);
	if ( UnknownFunction153(topIndex,0) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("DeliverWnd.TopList",topIndex,topInfo);
		Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("DeliverWnd.BottomList",ClassID);
		if ( UnknownFunction153(Index,0) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem("DeliverWnd.BottomList",Index,Info);
			UnknownFunction161(Info.ItemNum,Num);
			Class'UIAPI_ITEMWINDOW'.SetItem("DeliverWnd.BottomList",Index,Info);
		} else {
			Info = topInfo;
			Info.ItemNum = Num;
			Info.bShowCount = False;
			Class'UIAPI_ITEMWINDOW'.AddItem("DeliverWnd.BottomList",Info);
		}
		UnknownFunction162(topInfo.ItemNum,Num);
		if ( UnknownFunction152(topInfo.ItemNum,0) )
		{
			Class'UIAPI_ITEMWINDOW'.DeleteItem("DeliverWnd.TopList",topIndex);
		} else {
			Class'UIAPI_ITEMWINDOW'.SetItem("DeliverWnd.TopList",topIndex,topInfo);
		}
	}
}

function ItemBottomToTop (int ClassID, int Num)
{
	local int Index;
	local int topIndex;
	local ItemInfo Info;
	local ItemInfo topInfo;

	Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("DeliverWnd.BottomList",ClassID);
	if ( UnknownFunction153(Index,0) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("DeliverWnd.BottomList",Index,Info);
		UnknownFunction162(Info.ItemNum,Num);
		if ( UnknownFunction151(Info.ItemNum,0) )
		{
			Class'UIAPI_ITEMWINDOW'.SetItem("DeliverWnd.BottomList",Index,Info);
		} else {
			Class'UIAPI_ITEMWINDOW'.DeleteItem("DeliverWnd.BottomList",Index);
		}
		topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("DeliverWnd.TopList",ClassID);
		if ( UnknownFunction130(UnknownFunction153(topIndex,0),IsStackableItem(Info.ConsumeType)) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem("DeliverWnd.TopList",topIndex,topInfo);
			UnknownFunction161(topInfo.ItemNum,Num);
			Class'UIAPI_ITEMWINDOW'.SetItem("DeliverWnd.TopList",topIndex,topInfo);
		} else {
			Info.ItemNum = Num;
			Class'UIAPI_ITEMWINDOW'.AddItem("DeliverWnd.TopList",Info);
		}
	}
}

function L2jBRFunction6 (string L2jBRVar1)
{
	local int Adena;
	local string L2jBRVar14;
	local WindowHandle m_inventoryWnd;

	m_inventoryWnd = GetHandle("InventoryWnd");
	Clear();
	ParseInt(L2jBRVar1,"adena",Adena);
	ParseInt(L2jBRVar1,"destinationID",L2jBRVar90);
	L2jBRVar14 = MakeCostString(string(Adena));
	Class'UIAPI_TEXTBOX'.SetText("DeliverWnd.AdenaText",L2jBRVar14);
	Class'UIAPI_TEXTBOX'.SetTooltipString("DeliverWnd.AdenaText",ConvertNumToText(string(Adena)));
	if ( m_inventoryWnd.IsShowWindow() )
	{
		m_inventoryWnd.HideWindow();
	}
	ShowWindow("DeliverWnd");
	Class'UIAPI_WINDOW'.SetFocus("DeliverWnd");
}

function HandleAddItem (string L2jBRVar1)
{
	local ItemInfo Info;

	ParamToItemInfo(L2jBRVar1,Info);
	Class'UIAPI_ITEMWINDOW'.AddItem("DeliverWnd.TopList",Info);
}

function AdjustPrice ()
{
	local string Adena;
	local int L2jBRVar15_;

	L2jBRVar15_ = Class'UIAPI_ITEMWINDOW'.GetItemNum("DeliverWnd.BottomList");
	Adena = MakeCostString(string(UnknownFunction144(L2jBRVar15_,1000)));
	Class'UIAPI_TEXTBOX'.SetText("DeliverWnd.PriceText",Adena);
	Class'UIAPI_TEXTBOX'.SetTooltipString("DeliverWnd.PriceText",ConvertNumToText(string(UnknownFunction144(L2jBRVar15_,1000))));
}

function HandleOKButton ()
{
	local string L2jBRVar1;
	local int L2jBRVar15_;
	local int Index;
	local ItemInfo ItemInfo;

	L2jBRVar15_ = Class'UIAPI_ITEMWINDOW'.GetItemNum("DeliverWnd.BottomList");
	ParamAdd(L2jBRVar1,"targetID",string(L2jBRVar90));
	ParamAdd(L2jBRVar1,"num",string(L2jBRVar15_));
	Index = 0;
	if ( UnknownFunction150(Index,L2jBRVar15_) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("DeliverWnd.BottomList",Index,ItemInfo);
		ParamAdd(L2jBRVar1,UnknownFunction112("dbID",string(Index)),string(ItemInfo.Reserved));
		ParamAdd(L2jBRVar1,UnknownFunction112("count",string(Index)),string(ItemInfo.ItemNum));
		UnknownFunction163(Index);
		goto JL0066;
	}
	RequestPackageSend(L2jBRVar1);
	HideWindow("DeliverWnd");
}

