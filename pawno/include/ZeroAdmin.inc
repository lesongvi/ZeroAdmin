/*------------------------------------------------------------------------------
                              Zero Admin Inc v3.5
--------------------------------------------------------------------------------*/


#if defined _ZeroAdmin_included
  #endinput
#endif

#define _ZeroAdmin_included
#pragma library ZeroAdmin
#define Red 		      0xFF0000AA
#pragma tabsize 0
new Text:KillingSpreeText1;
new Text:KillingSpreeText2;
new PlayerKillingSpree[MAX_PLAYERS];

#define TOTAL_SKIN_ITEMS         300
#define SELECTION_SKIN_ITEMS 	21
#define ITEMS_PER_SKIN_LINE  	7

#define HEADER_SKIN_TEXT "Skins"
#define NEXT_SKIN_TEXT   "Next"
#define PREV_SKIN_TEXT   "Prev"

#define DIALOG_SKIN_BASE_X   	75.0
#define DIALOG_SKIN_BASE_Y   	130.0
#define DIALOG_SKIN_WIDTH    	550.0
#define DIALOG_SKIN_HEIGHT   	180.0
#define SPRITE_SKIN_DIM_X    	60.0
#define SPRITE_SKIN_DIM_Y    	70.0

new gTotalSkinItems = TOTAL_SKIN_ITEMS;
new PlayerText:gCurrentSkinPageTextDrawId[MAX_PLAYERS];
new PlayerText:gHeaderSkinTextDrawId[MAX_PLAYERS];
new PlayerText:gBackgroundSkinTextDrawId[MAX_PLAYERS];
new PlayerText:gNextSkinButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gPrevSkinButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gSelectionSkinItems[MAX_PLAYERS][SELECTION_SKIN_ITEMS];
new gSelectionSkinItemsTag[MAX_PLAYERS][SELECTION_SKIN_ITEMS];
new gSkinItemAt[MAX_PLAYERS];

new gItemSkinList[TOTAL_SKIN_ITEMS] = {
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,
50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,
97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,
132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,
167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,
202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,
237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,
272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299
};
stock KillingSpree(playerid)
{
	new KillSpreeName[256],str1[256],str2[256];
	GetPlayerName(playerid, KillSpreeName, 256);
	if(PlayerKillingSpree[playerid] >= 5 && PlayerKillingSpree[playerid] < 10)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~5 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText1);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if (PlayerKillingSpree[playerid] >= 10 && PlayerKillingSpree[playerid] < 15)
	{
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~10 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	}
	else if(PlayerKillingSpree[playerid] >= 15 && PlayerKillingSpree[playerid] < 20)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~15 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 20 && PlayerKillingSpree[playerid] < 25)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~20 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 25 && PlayerKillingSpree[playerid] < 30)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~25 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 30 && PlayerKillingSpree[playerid] < 35)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~30 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 35 && PlayerKillingSpree[playerid] < 40)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~35 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 40 && PlayerKillingSpree[playerid] < 45)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~40 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 45 && PlayerKillingSpree[playerid] < 50)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~45 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 50 && PlayerKillingSpree[playerid] < 55)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~50 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 55 && PlayerKillingSpree[playerid] < 60)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~55 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 60 && PlayerKillingSpree[playerid] < 65)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~60 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 65 && PlayerKillingSpree[playerid] < 70)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~65 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 70 && PlayerKillingSpree[playerid] < 75)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~70 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 75 && PlayerKillingSpree[playerid] < 80)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~75 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 80 && PlayerKillingSpree[playerid] < 85)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~80 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 85 && PlayerKillingSpree[playerid] < 90)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~85 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 90 && PlayerKillingSpree[playerid] < 95)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~90 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 95 && PlayerKillingSpree[playerid] < 100)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~95 kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
	else if(PlayerKillingSpree[playerid] >= 100)
	{
	format(str1, 256, "~y~%s ~w~is on a killing spree", KillSpreeName);
	format(str2, 256, "~y~100+ kills~w~ in a row");
	TextDrawSetString(KillingSpreeText1, str1);
    	TextDrawShowForAll(KillingSpreeText1);
	TextDrawSetString(KillingSpreeText2, str2);
	TextDrawShowForAll(KillingSpreeText2);
	}
}
stock TempBanCheck(playerid)
{
	new ip[15];
	new str[128];
	new load[4][32];
	new ban_day, ban_month, ban_year, ban_ip[15];
	GetPlayerIp(playerid, ip, sizeof ip);
	new year, month, day;
	getdate(year, month, day);
	new File:file = fopen("ZeroAdmin/Logs/TempBans.ban",io_read);
	if (file)
	{
	    while (fread(file, str, sizeof str))
	    {
	        split(str, load, '|');

	        ban_day = strval(load[0]);
	        ban_month = strval(load[1]);
	        ban_year = strval(load[2]);
	        strmid(ban_ip, load[3], 0, strlen(load[3])-1, 15);
	    	if (!(year >= ban_year && month >= ban_month && day >= ban_day) && !strcmp(ban_ip, ip, true))
	    	{
	    	    format(str, sizeof str, "|- You are temporarily banned from this server until: %d/%d/%d -|", ban_day, ban_month, ban_year);
	    	    SendClientMessage(playerid, Red, str);
	    	    return Kick(playerid);
	    	}
		}
	}
	return true;
}
split(const strsrc[], strdest[][], delimiter)
{
	new i, li,aNum,len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return aNum;
}
stock IsMonth31(month)
{
 	switch (month)
	{
	    case 1: return 1;
	    case 3: return 1;
	    case 5: return 1;
	    case 7: return 1;
	    case 8: return 1;
	    case 10: return 1;
	    case 12: return 1;
	    default: return 0;
	}
	return 0;
}

stock IsMonth29(year)
{
 	new y = 2000;
 	for(new i = 4; i < 3000; i += 4) if ((y+i) == year) return 1;
 	return 0;
}

stock strtok2(const string[], &idx)
{
    new length = strlen(string);
	while ((idx < length) && (string[idx] <= ' '))
	{
		idx++;
	}
	new offset = idx;
	new result[128];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
	{
		result[idx - offset] = string[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	return result;
}
stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string);
	i < j; i++)
	{
	if (string[i] > '9' || string[i] < '0')
	return 0;
	}
	return 1;
}
//==============================================================================
// ReturnUser (By Y_Less)
//==============================================================================
ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21)
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID;
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos]))
	{
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS)
		{
			if(!IsPlayerConnected(userid))
				userid = INVALID_PLAYER_ID;
			else return userid;
		}
	}
	new len = strlen(text[pos]);
	new count = 0;
	new pname[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, pname, sizeof (pname));
			if (strcmp(pname, text[pos], true, len) == 0)
			{
				if (len == strlen(pname)) return i;
				else
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count) SendClientMessage(playerid, Red, "ERROR: There are multiple users, enter full playername.");
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid;
}
//------------------------------------------------
GetNumberOfSkinPages()
{
	if((gTotalSkinItems >= SELECTION_SKIN_ITEMS) && (gTotalSkinItems % SELECTION_SKIN_ITEMS) == 0)
	{
		return (gTotalSkinItems / SELECTION_SKIN_ITEMS);
	}
	else return (gTotalSkinItems / SELECTION_SKIN_ITEMS) + 1;
}

//------------------------------------------------

PlayerText:CreateCurrentSkinPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtSkinInit;
   	txtSkinInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtSkinInit, 0);
	PlayerTextDrawLetterSize(playerid, txtSkinInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtSkinInit, 1);
	PlayerTextDrawSetShadow(playerid, txtSkinInit, 0);
    PlayerTextDrawSetOutline(playerid, txtSkinInit, 1);
    PlayerTextDrawColor(playerid, txtSkinInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtSkinInit);
    return txtSkinInit;
}

//------------------------------------------------
// Creates a button textdraw and returns the textdraw ID.

PlayerText:CreatePlayerSkinDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtSkinInit2;
   	txtSkinInit2 = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtSkinInit2, 1);
   	PlayerTextDrawBoxColor(playerid, txtSkinInit2, 0x000000FF);
   	PlayerTextDrawBackgroundColor(playerid, txtSkinInit2, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtSkinInit2, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtSkinInit2, 1);
	PlayerTextDrawSetShadow(playerid, txtSkinInit2, 0); // no shadow
    PlayerTextDrawSetOutline(playerid, txtSkinInit2, 0);
    PlayerTextDrawColor(playerid, txtSkinInit2, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtSkinInit2, 1);
    PlayerTextDrawAlignment(playerid, txtSkinInit2, 2);
    PlayerTextDrawTextSize(playerid, txtSkinInit2, Height, Width); // The width and height are reversed for centering.. something the game does <g>
    PlayerTextDrawShow(playerid, txtSkinInit2);
    return txtSkinInit2;
}

//------------------------------------------------

PlayerText:CreatePlayerSkinHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtSkinInit3;
   	txtSkinInit3 = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtSkinInit3, 0);
	PlayerTextDrawLetterSize(playerid, txtSkinInit3, 1.25, 3.0);
	PlayerTextDrawFont(playerid, txtSkinInit3, 0);
	PlayerTextDrawSetShadow(playerid, txtSkinInit3, 0);
    PlayerTextDrawSetOutline(playerid, txtSkinInit3, 1);
    PlayerTextDrawColor(playerid, txtSkinInit3, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtSkinInit3);
    return txtSkinInit3;
}

//------------------------------------------------

PlayerText:CreatePlayerSkinBackgrTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtSkinBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,
	"                                            ~n~"); // enough space for everyone
    PlayerTextDrawUseBox(playerid, txtSkinBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtSkinBackground, 0x4A5A6BBB);
	PlayerTextDrawLetterSize(playerid, txtSkinBackground, 5.0, 5.0);
	PlayerTextDrawFont(playerid, txtSkinBackground, 0);
	PlayerTextDrawSetShadow(playerid, txtSkinBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtSkinBackground, 0);
    PlayerTextDrawColor(playerid, txtSkinBackground,0x000000FF);
    PlayerTextDrawTextSize(playerid, txtSkinBackground, Width, Height);
   	PlayerTextDrawBackgroundColor(playerid, txtSkinBackground, 0x4A5A6BBB);
    PlayerTextDrawShow(playerid, txtSkinBackground);
    return txtSkinBackground;
}

//------------------------------------------------
// Creates a model preview sprite

PlayerText:CreateSkinModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSkinSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSkinSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSkinSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSkinSprite, 0x88888899);
    PlayerTextDrawTextSize(playerid, txtPlayerSkinSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSkinSprite, modelindex);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSkinSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSkinSprite);
    return txtPlayerSkinSprite;
}

//------------------------------------------------

DestroyPlayerSkinModelPreviews(playerid)
{
	new x=0;
	while(x != SELECTION_SKIN_ITEMS) {
	    if(gSelectionSkinItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gSelectionSkinItems[playerid][x]);
			gSelectionSkinItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
}

//------------------------------------------------

ShowPlayerSkinModelPreviews(playerid)
{
    new x=0;
	new Float:BaseX = DIALOG_SKIN_BASE_X;
	new Float:BaseY = DIALOG_SKIN_BASE_Y - (SPRITE_SKIN_DIM_Y * 0.33); // down a bit
	new linetracker = 0;

	new itemat = GetPVarInt(playerid, "skinc_page") * SELECTION_SKIN_ITEMS;

	// Destroy any previous ones created
	DestroyPlayerSkinModelPreviews(playerid);

	while(x != SELECTION_SKIN_ITEMS && itemat < gTotalSkinItems) {
	    if(linetracker == 0) {
	        BaseX = DIALOG_SKIN_BASE_X + 25.0; // in a bit from the box
	        BaseY += SPRITE_SKIN_DIM_Y + 1.0; // move on the Y for the next line
		}
  		gSelectionSkinItems[playerid][x] = CreateSkinModelPreviewTextDraw(playerid, gItemSkinList[itemat], BaseX, BaseY, SPRITE_SKIN_DIM_X, SPRITE_SKIN_DIM_Y);
  		gSelectionSkinItemsTag[playerid][x] = gItemSkinList[itemat];
		BaseX += SPRITE_SKIN_DIM_X + 1.0; // move on the X for the next sprite
		linetracker++;
		if(linetracker == ITEMS_PER_SKIN_LINE) linetracker = 0;
		itemat++;
		x++;
	}
}

//------------------------------------------------

UpdateSkinPageTextDraw(playerid)
{
	new PageText[64+1];
	format(PageText, 64, "%d/%d", GetPVarInt(playerid,"skinc_page") + 1, GetNumberOfSkinPages());
	PlayerTextDrawSetString(playerid, gCurrentSkinPageTextDrawId[playerid], PageText);
}

//------------------------------------------------

CreateSkinSelectionMenu(playerid)
{
    gBackgroundSkinTextDrawId[playerid] = CreatePlayerSkinBackgrTextDraw(playerid, DIALOG_SKIN_BASE_X, DIALOG_SKIN_BASE_Y + 20.0, DIALOG_SKIN_WIDTH, DIALOG_SKIN_HEIGHT);
    gHeaderSkinTextDrawId[playerid] = CreatePlayerSkinHeaderTextDraw(playerid, DIALOG_SKIN_BASE_X, DIALOG_SKIN_BASE_Y, HEADER_SKIN_TEXT);
    gCurrentSkinPageTextDrawId[playerid] = CreateCurrentSkinPageTextDraw(playerid, DIALOG_SKIN_WIDTH - 30.0, DIALOG_SKIN_BASE_Y + 15.0);
    gNextSkinButtonTextDrawId[playerid] = CreatePlayerSkinDialogButton(playerid, DIALOG_SKIN_WIDTH - 30.0, DIALOG_SKIN_BASE_Y+DIALOG_SKIN_HEIGHT+100.0, 50.0, 16.0, NEXT_SKIN_TEXT);
    gPrevSkinButtonTextDrawId[playerid] = CreatePlayerSkinDialogButton(playerid, DIALOG_SKIN_WIDTH - 90.0, DIALOG_SKIN_BASE_Y+DIALOG_SKIN_HEIGHT+100.0, 50.0, 16.0, PREV_SKIN_TEXT);

    ShowPlayerSkinModelPreviews(playerid);
    UpdateSkinPageTextDraw(playerid);
}

//------------------------------------------------

DestroySkinSelectionMenu(playerid)
{
	DestroyPlayerSkinModelPreviews(playerid);

	PlayerTextDrawDestroy(playerid, gHeaderSkinTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundSkinTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gCurrentSkinPageTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gNextSkinButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevSkinButtonTextDrawId[playerid]);

	gHeaderSkinTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundSkinTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentSkinPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextSkinButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevSkinButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

//------------------------------------------------

HandlePlayerSkinItemSelection(playerid, selecteditem)
{
	// In this case we change the player's skin
  	if(gSelectionSkinItemsTag[playerid][selecteditem] >= 0 && gSelectionSkinItemsTag[playerid][selecteditem] < 300) {
        SetPlayerSkin(playerid, gSelectionSkinItemsTag[playerid][selecteditem]);
		return;
	}
}

//------------------------------------------------
// Players Move Speed
#define MOVE_SPEED              100.0
#define ACCEL_RATE              0.03

// Players Mode
#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

// Key state definitions
#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8

// Enumeration for storing data about the player
enum noclipenum
{
	cameramode,
	flyobject,
	mode,
	lrold,
	udold,
	lastmove,
	Float:accelmul
}
new noclipdata[MAX_PLAYERS][noclipenum];

stock GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;
	
    if(lr < 0)
	{
		if(ud < 0) 		direction = MOVE_FORWARD_LEFT; 	// Up & Left key pressed
		else if(ud > 0) direction = MOVE_BACK_LEFT; 	// Back & Left key pressed
		else            direction = MOVE_LEFT;          // Left key pressed
	}
	else if(lr > 0) 	// Right pressed
	{
		if(ud < 0)      direction = MOVE_FORWARD_RIGHT;  // Up & Right key pressed
		else if(ud > 0) direction = MOVE_BACK_RIGHT;     // Back & Right key pressed
		else			direction = MOVE_RIGHT;          // Right key pressed
	}
	else if(ud < 0) 	direction = MOVE_FORWARD; 	// Up key pressed
	else if(ud > 0) 	direction = MOVE_BACK;		// Down key pressed
	
	return direction;
}

//--------------------------------------------------

stock MoveCamera(playerid)
{
	new Float:FV[3], Float:CP[3];
	GetPlayerCameraPos(playerid, CP[0], CP[1], CP[2]);          // 	Cameras position in space
    GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);  //  Where the camera is looking at

	// Increases the acceleration multiplier the longer the key is held
	if(noclipdata[playerid][accelmul] <= 1) noclipdata[playerid][accelmul] += ACCEL_RATE;

	// Determine the speed to move the camera based on the acceleration multiplier
	new Float:speed = MOVE_SPEED * noclipdata[playerid][accelmul];

	// Calculate the cameras next position based on their current position and the direction their camera is facing
	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(noclipdata[playerid][mode], CP, FV, X, Y, Z);
	MovePlayerObject(playerid, noclipdata[playerid][flyobject], X, Y, Z, speed);

	// Store the last time the camera was moved as now
	noclipdata[playerid][lastmove] = GetTickCount();
	return 1;
}

//--------------------------------------------------

stock GetNextCameraPosition(move_mode, Float:CP[3], Float:FV[3], &Float:X, &Float:Y, &Float:Z)
{
    // Calculate the cameras next position based on their current position and the direction their camera is facing
    #define OFFSET_X (FV[0]*6000.0)
	#define OFFSET_Y (FV[1]*6000.0)
	#define OFFSET_Z (FV[2]*6000.0)
	switch(move_mode)
	{
		case MOVE_FORWARD:
		{
			X = CP[0]+OFFSET_X;
			Y = CP[1]+OFFSET_Y;
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_BACK:
		{
			X = CP[0]-OFFSET_X;
			Y = CP[1]-OFFSET_Y;
			Z = CP[2]-OFFSET_Z;
		}
		case MOVE_LEFT:
		{
			X = CP[0]-OFFSET_Y;
			Y = CP[1]+OFFSET_X;
			Z = CP[2];
		}
		case MOVE_RIGHT:
		{
			X = CP[0]+OFFSET_Y;
			Y = CP[1]-OFFSET_X;
			Z = CP[2];
		}
		case MOVE_BACK_LEFT:
		{
			X = CP[0]+(-OFFSET_X - OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y + OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_BACK_RIGHT:
		{
			X = CP[0]+(-OFFSET_X + OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y - OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_FORWARD_LEFT:
		{
			X = CP[0]+(OFFSET_X  - OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  + OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_FORWARD_RIGHT:
		{
			X = CP[0]+(OFFSET_X  + OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  - OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
	}
}
//--------------------------------------------------

stock CancelFlyMode(playerid)
{
	DeletePVar(playerid, "FlyMode");
	CancelEdit(playerid);
	TogglePlayerSpectating(playerid, false);
	DestroyPlayerObject(playerid, noclipdata[playerid][flyobject]);
	noclipdata[playerid][cameramode] = CAMERA_MODE_NONE;
	return 1;
}

//--------------------------------------------------

stock FlyMode(playerid)
{
	// Create an invisible object for the players camera to be attached to
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	noclipdata[playerid][flyobject] = CreatePlayerObject(playerid, 19300, X, Y, Z, 0.0, 0.0, 0.0);

	// Place the player in spectating mode so objects will be streamed based on camera location
	TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachCameraToPlayerObject(playerid, noclipdata[playerid][flyobject]);

	SetPVarInt(playerid, "FlyMode", 1);
	noclipdata[playerid][cameramode] = CAMERA_MODE_FLY;
	return 1;
}

//--------------------------------------------------

stock Warning()
{
if(!fexist("ZeroAdmin/"))
{
print("\n\n WARNING: Folder ZeroAdmin Missing From Scriptfiles\n");
SendRconCommand("unloadfs ZeroAdmin");
return 1;
}
if(!fexist("ZeroAdmin/Logs/"))
{
printf("\n\n WARNING: Folder Logs Missing From Scriptfiles\n");
SendRconCommand("unloadfs ZeroAdmin");
return 1;
}
if(!fexist("ZeroAdmin/Accounts/"))
{
printf("\n\n WARNING: Folder Accounts Missing From Scriptfiles\n");
SendRconCommand("unloadfs ZeroAdmin");
return 1;
}
if(!fexist("ZeroAdmin/Zero_Info.ini"))
{
printf("\n\n WARNING: File Zero_Info Missing From Scriptfiles\n");
SendRconCommand("unloadfs ZeroAdmin");
return 1;
}
return 0;
}

//--------------------------------------------------

stock VC(playerid,model)
{
new Float:x, Float:y, Float:z, Float:angle;
GetPlayerPos(playerid, x, y, z);
GetPlayerFacingAngle(playerid, angle);	
new vehicleid=CreateVehicle(model, x, y, z, angle, -1, -1, -1);
PutPlayerInVehicle(playerid, vehicleid, 0);
SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
ChangeVehicleColor(vehicleid,0,0);
return 1;
}

stock IsValidSkin(SkinID)
{
	if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) return true;
	else return false;
}

new VehicleNames[212][] = {
{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
{"Utility Trailer"}
};
stock TimeStamp()
{
	new time = GetTickCount() / 1000;
	return time;
}
stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
	if ( strfind(VehicleNames[i], vname, true) != -1 )
	return i + 400;
	}
	return -1;
}
stock GetPlayerID(const Name[])
{
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new plName[MAX_PLAYER_NAME];
	        GetPlayerName(i, plName, sizeof(plName));
	        if(strcmp(Name, plName, true)==0)
	        {
	            return i;
	        }
	    }
	}
	return -1;
}
stock encodepass(buf[]) {
	new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}
stock strrest(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
stock IsValidWeap(weapid)
{
    if (weapid > 0 && weapid < 19 || weapid > 21 && weapid < 47) return 1;
    return 0;
}
//--------------------------------------------------
