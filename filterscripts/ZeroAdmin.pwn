/*------------------------------------------------------------------------------
                           Zero Admin System v3.5
              This system is created by (Emrah Malkic) Zero_Cool.
--------------------------------------------------------------------------------
================================================================================
=||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||=
=|||                |||||||||            ||||||         ||||||           ||||||=
=||||||||||||||||  ||||||||||  ||||||||||||||||  |||||  ||||||  |||||||  ||||||=
=|||||||||||||||  |||||||||||  ||||||||||||||||  |||||  ||||||  |||||||  ||||||=
=||||||||||||||  ||||||||||||  ||||||||||||||||  |||||  ||||||  |||||||  ||||||=
=|||||||||||||  |||||||||||||  ||||||||||||||||         ||||||  |||||||  ||||||=
=||||||||||||  ||||||||||||||            ||||||    |||||||||||  |||||||  ||||||=
=|||||||||||  |||||||||||||||  ||||||||||||||||  |  ||||||||||  |||||||  ||||||=
=||||||||||  ||||||||||||||||  ||||||||||||||||  ||   ||||||||  |||||||  ||||||=
=|||||||||  |||||||||||||||||  ||||||||||||||||  |||   |||||||  |||||||  ||||||=
=|||||||||                 ||            ||||||  ||||   ||||||           ||||||=
=||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||=
                        Zero Admin Script System v3.5
================================================================================
------------------------------------------------------------------------------*/
//----------------------------------------------------------------------------//
//                             INCLUDES                                       //
//----------------------------------------------------------------------------//

 #include <a_samp>
 #include <dini>
 #include <ZeroAdmin>
 //---------------------------------------------------------------------------//
 // DCMD
 //---------------------------------------------------------------------------//
 #define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 //                                 COLORS
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 #define COLOR_YELLOW 	  0xFFFF00AA
 #define COLOR_BLUE       0x375FFFFF
 #define COLOR_RED 		  0xFF0000AA
 #define COLOR_LBLUE      0x33CCFFAA
 #define COLOR_ERROR      0x33AA33AA
 #define COLOR_WHITE      0xFFFFFFAA
 #define COLOR_GREEN      0x33AA33AA
 #define COL_RED          "{F81414}"
 #define COL_LBLUE        "{00C0FF}"
 #define COL_LRED         "{FFA1A1}"
 #define COL_GREEN        "{6EF83C}"
 #define COL_GREY         "{C3C3C3}"
 #define COL_WHITE        "{FFFFFF}"
 #define COL_BLUE         "{0000FF}"
 #define COL_YELLOW       "{FFEE00}"
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 //                                  DIALOGS
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 #define DIALOGID_ZMENU       	 9000
 #define DIALOGID_REGISTER    	 6694
 #define DIALOGID_LOGIN       	 6695
 #define DIALOGID_ADMIN       	 7520
 #define DIALOGID_ZCONSOLE    	 1306
 #define DIALOG_TYPE_SERV_PASS 	 1997
 #define DIALOG_TYPE_SERV_UNLOCK 1998
 #define DIALOG_TYPE_RCON2       2000
 #define DIALOG_Enable/Disable   2003
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 //                            CONFIGURATION
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 #define MAX_SPAM_MSGS 			 5  				// Max Spam Messages
 #define SPAM_TIMELIMIT			 8  				// In seconds
 #define MAX_WARNINGS 		     3					// Max Warnings
 #define MAX_REPORTS             10					// Number Max of Reports per Player
 #define MAX_PING                800				// Max Player Ping
 #define MAX_FAIL_LOGINS         3                  // Max Login Attempts
 #define MAX_DESKTOP_TIME 		 60 				//In Seconds
 #define EnableMiniGun           false              // Set "true" All Players Can Use MiniGun,"false" Only Admin Can Use MiniGun
 #define EnableHeatSeeker        false              // Set "true" All Players Can Use HeatSeeker,"false" Only Admin Can Use HeatSeeker
 #define EnableRocketLauncher    false              // Set "true" All Players Can Use RocketLauncher,"false" Only Admin Can Use RocketLauncher
 #define EnableRifle             false              // Set "true" All Players Can Use Rifle,"false" Only Admin Can Use Rifle
 #define EnableFlameThrower      false              // Set "true" All Players Can Use FlameThrower,"false" Only Admin Can Use FlameThrower
 #define TwoRconPass 			 "changeme" 		//Define the Second Rcon Password
 #define AntiPause             	 true
 #define ADMIN_SPEC_TYPE_NONE    0
 #define ADMIN_SPEC_TYPE_PLAYER  1
 #define ADMIN_SPEC_TYPE_VEHICLE 2
 //----------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 //                                 PREAGMAS
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 #pragma tabsize 0
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 //                                 NEWS
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 enum AccountInfo
 {
	bool:Logged,
	Registered,
  	Kills,
	Deaths,
	hours,
	mins,
	secs,
	Level,
	Score,
	Cash,
	Muted,
	Jailed,
	Frozen,
	Banned,
	Warnings,
	FailLogin,
	TotalTime,
	ConnectTime,
	SpamCount,
	SpamTime,
	highlight,
	pColour,
	RconAtt,
	Hide,
 };
 enum ServerData
 {
 	Locked,
	Password[256],
	AntiSpam,
	AutoLogin,
	MaxPing,
	Killing_Spree,
	AdminTeleport,
 };
 
 new Version[] = "v3.5";
 
 new PasswordAtt[MAX_PLAYERS];
 new InDuel[MAX_PLAYERS];
 new counttime[MAX_PLAYERS] = -1;
 new pHighLight[MAX_PLAYERS] = 0;
 new ObjModel[MAX_PLAYERS] = -1;
 new EnabDisab[MAX_PLAYERS][ServerData];
 new timer;
 new TDraws;
 new Filles;
 new Text:ZSpecTd[5];
 new Timer[MAX_PLAYERS];
 new CCPlayer[MAX_PLAYERS];
 new AutoGm[MAX_PLAYERS];
 new TimeGm[MAX_PLAYERS];
 new Caroff[MAX_PLAYERS];
 new MegaJump[MAX_PLAYERS];
 new CmdPlayer[MAX_PLAYERS];
 new ServerInfo[ServerData];
 new gSpectateID[MAX_PLAYERS];
 new Reports[MAX_REPORTS][128];
 new PlayerUseSpec[MAX_PLAYERS];
 new PlayerUseZcam[MAX_PLAYERS];
 new gSpectateType[MAX_PLAYERS];
 new HighlightTimer[MAX_PLAYERS];
 new Account[MAX_PLAYERS][AccountInfo];
 #if AntiPause == true
 new Desktop_Check[MAX_PLAYERS];
 new Desktop_Status[MAX_PLAYERS];
 new Desktop_Timer[MAX_PLAYERS];
 new Desktop_Timer_Started[MAX_PLAYERS];
 #endif
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 //                                 FORWARDS
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 forward AntiCheat();
 forward GmTime(playerid);
 forward Unjail(playerid);
 forward CheckPing(playerid);
 forward SaveLogs(filename[],text[]);
 forward BanPlayer(playerid,const reason[]);
 forward KickPlayer(playerid,const reason[]);
 forward MessageToAdmins(color,const string[]);
 forward Duel(player1, player2);
 forward C_C_Player();
 forward Desktop_Function(playerid);
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
 //---------------------------------------------------------------------------//
public OnFilterScriptInit()
{
	print ("\n--------------------------------------\n");
	printf("       	       Z.A.S %s      			",Version);
	print ("      	    Zero Admin System       	");
	print ("\n--------------------------------------");
	print (">>>Loading...\n\n");
	Warning();
	UpdateConfig();
	print (">>>Z.A.S Loaded Configurations:\n\n");
	
	new Year,Month,Day;	getdate(Year, Month, Day);
	new Hour,Min,Sec; gettime(Hour,Min,Sec);
	for(new i = 1; i < MAX_REPORTS; i++) Reports[i] = "<none>";
	SetTimer("AntiCheat",1000,1);
	SetTimer("C_C_Player",1000,1);
	
	KillingSpreeText1 = TextDrawCreate(634.000000, 362.000000, "~y~Zero_Cool ~w~is on a killing spree");TDraws++;
	TextDrawAlignment(KillingSpreeText1, 3);
	TextDrawBackgroundColor(KillingSpreeText1, 255);
	TextDrawFont(KillingSpreeText1, 1);
	TextDrawLetterSize(KillingSpreeText1, 0.259999, 1.500000);
	TextDrawColor(KillingSpreeText1, -1);
	TextDrawSetOutline(KillingSpreeText1, 1);
	TextDrawSetProportional(KillingSpreeText1, 1);

	KillingSpreeText2 = TextDrawCreate(633.000000, 377.000000, "~y~10 kills~w~ in a row");TDraws++;
	TextDrawAlignment(KillingSpreeText2, 3);
	TextDrawBackgroundColor(KillingSpreeText2, 255);
	TextDrawFont(KillingSpreeText2, 1);
	TextDrawLetterSize(KillingSpreeText2, 0.259999, 1.500000);
	TextDrawColor(KillingSpreeText2, -1);
	TextDrawSetOutline(KillingSpreeText2, 1);
	TextDrawSetProportional(KillingSpreeText2, 1);
	
	ZSpecTd[0] = TextDrawCreate(81.000000, 264.000000, "~n~");
	TextDrawAlignment(ZSpecTd[0], 2);
	TextDrawBackgroundColor(ZSpecTd[0], 255);
	TextDrawFont(ZSpecTd[0], 1);
	TextDrawLetterSize(ZSpecTd[0], 0.500000, 7.099999);
	TextDrawColor(ZSpecTd[0], -1);
	TextDrawSetOutline(ZSpecTd[0], 0);
	TextDrawSetProportional(ZSpecTd[0], 1);
	TextDrawSetShadow(ZSpecTd[0], 1);
	TextDrawUseBox(ZSpecTd[0], 1);
	TextDrawBoxColor(ZSpecTd[0], 255);
	TextDrawTextSize(ZSpecTd[0], 0.000000, 71.000000);
	TextDrawSetSelectable(ZSpecTd[0], 0);

	ZSpecTd[1] = TextDrawCreate(81.000000, 261.000000, "~n~");
	TextDrawAlignment(ZSpecTd[1], 2);
	TextDrawBackgroundColor(ZSpecTd[1], 255);
	TextDrawFont(ZSpecTd[1], 1);
	TextDrawLetterSize(ZSpecTd[1], 0.500000, 7.799999);
	TextDrawColor(ZSpecTd[1], -1);
	TextDrawSetOutline(ZSpecTd[1], 0);
	TextDrawSetProportional(ZSpecTd[1], 1);
	TextDrawSetShadow(ZSpecTd[1], 1);
	TextDrawUseBox(ZSpecTd[1], 1);
	TextDrawBoxColor(ZSpecTd[1], 118);
	TextDrawTextSize(ZSpecTd[1], 0.000000, 77.000000);
	TextDrawSetSelectable(ZSpecTd[1], 0);

	ZSpecTd[2] = TextDrawCreate(79.000000, 265.000000, "~g~Zero_Cool");
	TextDrawAlignment(ZSpecTd[2], 2);
	TextDrawBackgroundColor(ZSpecTd[2], 255);
	TextDrawFont(ZSpecTd[2], 1);
	TextDrawLetterSize(ZSpecTd[2], 0.210000, 0.699999);
	TextDrawColor(ZSpecTd[2], -1);
	TextDrawSetOutline(ZSpecTd[2], 0);
	TextDrawSetProportional(ZSpecTd[2], 1);
	TextDrawSetShadow(ZSpecTd[2], 1);
	TextDrawSetSelectable(ZSpecTd[2], 0);

	ZSpecTd[3] = TextDrawCreate(46.000000, 278.000000, "~b~Health:~w~100.0~n~~n~~b~Armour:~w~100.0~n~~n~~b~Money:~w~1000000~n~~n~~b~Ip:~w~108.0.1.10");
	TextDrawBackgroundColor(ZSpecTd[3], 255);
	TextDrawFont(ZSpecTd[3], 1);
	TextDrawLetterSize(ZSpecTd[3], 0.210000, 0.699999);
	TextDrawColor(ZSpecTd[3], -1);
	TextDrawSetOutline(ZSpecTd[3], 0);
	TextDrawSetProportional(ZSpecTd[3], 1);
	TextDrawSetShadow(ZSpecTd[3], 1);
	TextDrawSetSelectable(ZSpecTd[3], 0);
	TDraws += 4;
	
	for(new x; x<MAX_PLAYERS; x++)
	{
	if(noclipdata[x][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(x);
	}
	
	printf("TextDraw Loaded 		[%d]",TDraws);
	CheckFolders();
	ServerInformtion();
	print("AntiCheat Loaded.");
	print("\n>>>Loaded Successfully.");
	print ("\n--------------------------------------");
	printf("    Loaded Zero Admin System %s	        ",Version);
	print (" 									    ");
	printf("    Date: %d.%d.%d.  Time: %d:%d:%d     ",Day,Month,Year, Hour, Min, Sec);
	print ("--------------------------------------\n");

	return 1;
}
//----------------------------------------------------------------------------//
public OnFilterScriptExit()
{
	TextDrawDestroy(KillingSpreeText1);
	TextDrawDestroy(KillingSpreeText2);
	TextDrawDestroy(ZSpecTd[0]);
	TextDrawDestroy(ZSpecTd[1]);
	TextDrawDestroy(ZSpecTd[2]);
	TextDrawDestroy(ZSpecTd[3]);
	
	new Year,Month,Day;	getdate(Year, Month, Day);
	new Hour,Min,Sec; gettime(Hour,Min,Sec);
	print("\n--------------------------------------");
	printf(" Unloaded Zero Admin System %s         ",Version);
	print(" 								       ");
	printf(" Date: %d.%d.%d.  Time: %d:%d:%d   \n",Day,Month,Year, Hour, Min, Sec);
	print("--------------------------------------\n");
	return 1;
}

//----------------------------------------------------------------------------//
public OnPlayerConnect(playerid)
{
	Account[playerid][Logged]     = false;
	Account[playerid][Registered] = 0;
	Account[playerid][Kills]      = 0;
	Account[playerid][Deaths]     = 0;
	Account[playerid][Level]      = 0;
	Account[playerid][Score]      = 0;
	Account[playerid][Cash]       = 0;
	Account[playerid][Warnings]   = 0;
	Account[playerid][pColour]   = 0;
	AutoGm[playerid] = 0;
	MegaJump[playerid] = 0;
	Account[playerid][ConnectTime] = gettime();
	TempBanCheck(playerid);
	#if AntiPause == true
	Desktop_Check[playerid] = 0;
	Desktop_Timer_Started[playerid] = 0;
    Desktop_Status[playerid] = 0;
    #endif
	noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][mode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;
    gHeaderSkinTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundSkinTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentSkinPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextSkinButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevSkinButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    for(new x=0; x < SELECTION_SKIN_ITEMS; x++) {
        gSelectionSkinItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	gSkinItemAt[playerid] = 0;
	new PlayerName[MAX_PLAYER_NAME], file[256];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",PlayerName);
 	if(dini_Int(file,"Banned") == 1)
    {
    	new string[256];
        SendClientMessage(playerid, Red, "ATTENTION: This name is banned from this server!");
		format(string,sizeof(string),"Player %s (Id:%d) has been Automatically  Kicked. Reason: Name Banned!",PlayerName,playerid);
		SendClientMessageToAll(Red, string);  print(string);
		SaveLogs("KickLog",string);  Kick(playerid);
    }
   	if (ServerInfo[Locked] == 1)
    {
        ShowPlayerDialog(playerid, DIALOG_TYPE_SERV_PASS, DIALOG_STYLE_INPUT,
		"Server Locked!.", "Enter the password to Access it:", "Access", "Exit");
	}
    new pIP[50]; GetPlayerIp(playerid,pIP,50);
    new string2[256];
   	if(strlen(dini_Get("ZeroAdmin/aka.txt", pIP)) == 0)
	dini_Set("ZeroAdmin/aka.txt", pIP, PlayerName);
 	else
	{
	    if( strfind( dini_Get("ZeroAdmin/aka.txt", pIP), PlayerName, true) == -1 )
		{
  		format(string2,sizeof(string2),"%s,%s", dini_Get("ZeroAdmin/aka.txt",pIP), PlayerName);
	   	dini_Set("ZeroAdmin/aka.txt", pIP, string2);
		}
 	}
	if(dini_Exists(file))
	{
        if(ServerInfo[AutoLogin] == 1)
        {
        LoginPlayer(playerid);
		Account[playerid][Registered] = 1;
		Account[playerid][Logged] = true;
		Account[playerid][Muted] = 0;
		}
		else
		{
		new string[256];
    	format(string, sizeof(string), "{0049FF}'%s'\n\n{FFFFFF}Welcome back {0049FF}%s\n\n{FFFFFF}Before playing you must login\n\nEnter your {F3FF02}password {FFFFFF}below and click login",GetServerHostName(),pName(playerid));
    	ShowPlayerDialog(playerid,DIALOGID_LOGIN,DIALOG_STYLE_INPUT,"Login",string,"Login","Cancel");
    	}
		new ip[128];
		GetPlayerIp(playerid,ip,sizeof(ip));
    	dini_Set("ZeroAdmin/Zero_Info.ini",pName(playerid),ip);
		return 1;
	}
	if(!dini_Exists(file))
	{
		SendClientMessage(playerid,COLOR_ERROR,"* This account is not registered. To save stats you need register!");
    	new string[256];
    	format(string,256,"{FFFFFF}Welcome to the {0049FF}'%s'\n\n{FFFFFF}Account {0049FF}'%s' {FFFFFF}is not registred!\n\n{FFFFFF}Enter the {F3FF02}password {FFFFFF}to Register your Account:",GetServerHostName(),pName(playerid));
		ShowPlayerDialog(playerid,DIALOGID_REGISTER,DIALOG_STYLE_INPUT,"Register",string,"Register","Quit");
		Account[playerid][Registered] = 0;
		Account[playerid][Logged] = false;
		new ip[128];
		GetPlayerIp(playerid,ip,sizeof(ip));
		dini_Set("ZeroAdmin/Zero_Info.ini",pName(playerid),ip);
		//
		return 1;
	}

	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerDisconnect(playerid, reason)
{
	new PlayerName[MAX_PLAYER_NAME], file[256],str[128];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",PlayerName);
	
	new h, m, s;
    TotalGameTime(playerid, h, m, s);
    #if AntiPause == true
    if(Desktop_Timer_Started[playerid] == 1) { KillTimer(Desktop_Timer[playerid]); }
    #endif
	dini_IntSet(file,"Banned", Account[playerid][Banned]);
	dini_IntSet(file,"Kills", Account[playerid][Kills]);
	dini_IntSet(file,"Deaths",Account[playerid][Deaths]);
	dini_IntSet(file,"Score",GetPlayerScore(playerid));
	dini_IntSet(file,"Cash", GetPlayerMoney(playerid));
	dini_IntSet(file,"Hours", h);
	dini_IntSet(file,"Minutes", m);
	dini_IntSet(file,"Seconds", s);
	new year,month,day;
	getdate(year, month, day);
	new strdate[20];
	format(strdate, sizeof(strdate), "%d.%d.%d",day,month,year);
	dini_Set(file,"LastOn",strdate);
	Account[playerid][Logged] = false;
	dini_IntSet(file,"Logged",0);
	AutoGm[playerid] = 0;
 	KillTimer(TimeGm[playerid]);
 	PasswordAtt[playerid]=0;
	switch (reason)
	{
	case 0:format(str, sizeof(str), "* Player %s (Id:%d) has left the Server (Timeout)", PlayerName, playerid);
	case 1:format(str, sizeof(str), "* Player %s (Id:%d) has left the Server (Leaving)", PlayerName, playerid);
	case 2:format(str, sizeof(str), "* Player %s (Id:%d) has left the Server (Kicked/Banned)", PlayerName, playerid);
	}
	SendClientMessageToAll(COLOR_BLUE, str);
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerRequestSpawn(playerid)
{
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerText(playerid, text[])
{
 	if(Account[playerid][Muted] == 1)
	{
		SendClientMessage(playerid, Red, "You are muted, noone can hear you!");
		return 0;
	}
	if(text[0] == '!' && Account[playerid][Level] >= 1)
	{
	    new string[256]; 
		format(string,sizeof(string),"Admin Chat: %s: %s",pName(playerid),text[1]);
		MessageToAdmins(COLOR_GREEN,string);
	    return 0;
	}
	if(ServerInfo[AntiSpam] == 1)
	{
	if(Account[playerid][Level] == 0)
	{
	if(Account[playerid][SpamCount] == 0) Account[playerid][SpamTime] = TimeStamp();

	    Account[playerid][SpamCount]++;
		if(TimeStamp() - Account[playerid][SpamTime] > SPAM_TIMELIMIT)
		{
			Account[playerid][SpamCount] = 0;
			Account[playerid][SpamTime] = TimeStamp();
		}
		else if(Account[playerid][SpamCount] == MAX_SPAM_MSGS)
		{
			KickPlayer(playerid,"Spam Protection");
		}
		else if(Account[playerid][SpamCount] == MAX_SPAM_MSGS-1)
		{
			SendClientMessage(playerid,Red,"* Anti Spam Warning! Next is a Kick! *");
			return 0;
		}
	}
	}
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerDeath(playerid, killerid, reason)
{
    Account[playerid][Deaths]++;
	if(IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID)
	{
		Account[killerid][Kills]++;
	}
	
	InDuel[playerid] = 0;

	if(InDuel[playerid] == 1 && InDuel[killerid] == 1)
	{
	GameTextForPlayer(playerid,"~r~Loser!",3000,3);
	GameTextForPlayer(killerid,"~g~Winner!",3000,3);
	InDuel[killerid] = 0;
	SetPlayerPos(killerid, 0.0, 0.0, 0.0);
	SpawnPlayer(killerid);
	}
	else if(InDuel[playerid] == 1 && InDuel[killerid] == 0)
	{
	GameTextForPlayer(playerid,"~r~Loser !",3000,3);
	}
	
	if(ServerInfo[Killing_Spree] == 1)
	{
	PlayerKillingSpree[playerid] = 0;
	if(IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID)
	{
	PlayerKillingSpree[killerid]++;
 	}
	KillingSpree(killerid);
	}
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerSpawn(playerid)
{
	Timer[playerid] = SetTimerEx("CheckPing",1000,1,"i",playerid);
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new x = 0;
	while(x!=MAX_PLAYERS) {
	    if( IsPlayerConnected(x) &&	GetPlayerState(x) == PLAYER_STATE_SPECTATING &&
			gSpectateID[x] == playerid && gSpectateType[x] == ADMIN_SPEC_TYPE_PLAYER )
   		{
   		    SetPlayerInterior(x,newinteriorid);
		}
		x++;
	}
}
//----------------------------------------------------------------------------//
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new string[128];
	new tmp[256];
	new idx;
	//-------------------//
	//    All Players    //
	//-------------------//
	dcmd(pm,2,cmdtext);
	dcmd(kill,4,cmdtext);
	dcmd(stats,5,cmdtext);
	dcmd(report,6,cmdtext);
	dcmd(admins,6,cmdtext);
	dcmd(zcredits,8,cmdtext);
	dcmd(resetstats,10,cmdtext);
	dcmd(changepass,10,cmdtext);
	//-------------------//
	//      Level 1      //
	//-------------------//
	dcmd(ip,2,cmdtext);
	dcmd(cc,2,cmdtext);
	dcmd(say,3,cmdtext);
	dcmd(jail,4,cmdtext);
	dcmd(slap,4,cmdtext);
	dcmd(mute,4,cmdtext);
	dcmd(level,5,cmdtext);
	dcmd(unjail,6,cmdtext);
	dcmd(repair,6,cmdtext);
	dcmd(freeze,6,cmdtext);
	dcmd(unmute,6,cmdtext);
	dcmd(reports,7,cmdtext);
	dcmd(unfreeze,8,cmdtext);
	//-------------------//
	//      Level 2      //
	//-------------------//
	dcmd(fix,3,cmdtext);
	dcmd(ann,3,cmdtext);
	dcmd(flip,4,cmdtext);
	dcmd(kick,4,cmdtext);
	dcmd(drop,4,cmdtext);
	dcmd(warn,4,cmdtext);
	dcmd(zcam,4,cmdtext);
	dcmd(spawn,5,cmdtext);
	dcmd(eject,5,cmdtext);
	dcmd(zspec,5,cmdtext);
	dcmd(laston,6,cmdtext);
	dcmd(addnos,6,cmdtext);
	dcmd(getcord,7,cmdtext);
	dcmd(godmode,7,cmdtext);
	dcmd(specoff,7,cmdtext);
	dcmd(megajump,8,cmdtext);
	dcmd(highlight,9,cmdtext);
	dcmd(clearchat,9,cmdtext);
 	//-------------------//
	//      Level 3      //
	//-------------------//
	dcmd(fu,2,cmdtext);
	dcmd(aka,3,cmdtext);
	dcmd(ban,3,cmdtext);
	dcmd(car,3,cmdtext);
	dcmd(goto,4,cmdtext);
	dcmd(duel,4,cmdtext);
	dcmd(force,5,cmdtext);
 	dcmd(unban,5,cmdtext);
	dcmd(zmenu,5,cmdtext);
	dcmd(setcord,7,cmdtext);
	dcmd(givegun,7,cmdtext);
	dcmd(setname,7,cmdtext);
	dcmd(gethere,7,cmdtext);
	dcmd(explode,7,cmdtext);
	dcmd(sethealth,9,cmdtext);
	dcmd(setarmour,9,cmdtext);
	dcmd(engineoff,9,cmdtext);
	dcmd(setgravity,10,cmdtext);
	dcmd(setallcash,10,cmdtext);
	dcmd(killplayer,10,cmdtext);
	dcmd(changeskin,10,cmdtext);
	dcmd(setallskin,10,cmdtext);
	dcmd(setallscore,11,cmdtext);
	dcmd(setallwanted,12,cmdtext);
	dcmd(setallweather,13,cmdtext);
	//-------------------//
	//      Level 4      //
	//-------------------//
	dcmd(ed,2,cmdtext);
	dcmd(cmd,3,cmdtext);
	dcmd(hide,4,cmdtext);
	dcmd(unhide,6,cmdtext);
	dcmd(disarm,6,cmdtext);
	dcmd(getall,6,cmdtext);
	dcmd(healall,7,cmdtext);
	dcmd(jetpack,7,cmdtext);
	dcmd(unbanip,7,cmdtext);
	dcmd(killall,7,cmdtext);
	dcmd(muteall,7,cmdtext);
	dcmd(fakechat,8,cmdtext);
 	dcmd(ejectall,8,cmdtext);
 	dcmd(spawnall,8,cmdtext);
	dcmd(disarmall,9,cmdtext);
	dcmd(armourall,9,cmdtext);
	dcmd(unmuteall,9,cmdtext);
	dcmd(lockserver,10,cmdtext);
	dcmd(explodeall,10,cmdtext);
	dcmd(unlockserver,12,cmdtext);
	//-------------------//
	//      Level 5      //
	//-------------------//
	dcmd(gmx,3,cmdtext);
	dcmd(delacc,6,cmdtext);
	dcmd(object,6,cmdtext);
	dcmd(kickall,7,cmdtext);
	dcmd(setlevel,8,cmdtext);
	dcmd(zconsole,8,cmdtext);
	//-------------------//

	cmd = strtok(cmdtext, idx);
	
	if(strcmp(cmd, "/tempban", true) == 0) //Credits to LuxAdmin
	{
		new name[MAX_PLAYER_NAME];
		new giveplayer[MAX_PLAYER_NAME];
		new giveplayerid;

		if(Account[playerid][Level] < 5) return SendClientMessage(playerid,Red,"ERROR: You are not a high enough level to use this command");
			tmp = strtok(cmdtext,idx);
			if(!strlen(tmp))
			{
  				SendClientMessage(playerid,COLOR_ERROR, "{6EF83C}Usage: {FFFFFF}/tempban [PlayerID] [Day(s)] [Reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    tmp = strtok(cmdtext, idx);
			    if (!strlen(tmp))
			    {
				SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage: {FFFFFF}/tempban [PlayerID] [Day(s)] [Reason]");
				return 1;
				}
				new days = strval(tmp);
				if(!IsNumeric(tmp))
				return SendClientMessage(playerid, Red, "ERROR: Invalid Day! Only Numbers!");

				if(strval(tmp) <= 0 || strval(tmp) > 1000)
				return SendClientMessage(playerid, Red, "ERROR: Invalid Day! (1-1000)");

				new reason[128];
				reason = strtok2(cmdtext,idx);
				if (!strlen(reason))
				return SendClientMessage(playerid, Red, "ERROR: Reason not Specified!");

				if (strlen(reason) <= 0 || strlen(reason) > 100)
				return SendClientMessage(playerid, Red, "ERROR: Invalid Reason length!");

				new ip[15];
				GetPlayerIp(giveplayerid,ip,15);
				GetPlayerName(playerid, name, sizeof name);
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				new File:tempban = fopen("ZeroAdmin/Logs/TempBans.ban", io_append);
				if (tempban)
				{
				    new year,month,day;
				    getdate(year, month, day);
				    day += days;
				    if (IsMonth31(month))
				    {
				        if (day > 31)
				        {
				            month += 1;
				            if (month > 12)
				            {
				                year += 1;
				                while(day > 31) day -= 31;
				            }
				            else while(day > 31) day -= 31;
				        }
				    }
				    else if (!IsMonth31(month))
				    {
				        if (day > 30)
				        {
				            month += 1;
				            if (month > 12)
				            {
				                year += 1;
				                while(day > 30) day -= 30;
				            }
				            else while(day > 30) day -= 30;
				        }
				    }
				    else if (!IsMonth31(month) && IsMonth29(year) && month == 2)
				    {
				        if (day > 29)
				        {
				            month += 1;
				            if (month > 12)
				            {
				                year += 1;
				                while(day > 29) day -= 29;
				            }
				            else while(day > 29) day -= 29;
				        }
				    }
				    else if (!IsMonth31(month) && !IsMonth29(year) && month == 2)
				    {
				        if (day > 28)
				        {
				            month += 1;
				            if (month > 12)
				            {
				                year += 1;
				                while(day > 28) day -= 28;
				            }
				            else while(day > 28) day -= 28;
				        }
				    }
				    format(string, sizeof string, "%d|%d|%d|%s\n", day, month, year, ip);
				    fwrite(tempban, string);
				    fclose(tempban);
				}
				format(string,128,"Administrator %s Temporarily Banned %s for %d Day(s)  Reason: %s",name,giveplayer,days,reason);
				SendClientMessageToAll(Red,string);
				Kick(giveplayerid);

    			format(string, sizeof string, "Admin %s Temporarily Banned %s for %d Day(s)  Reason: %s",name,giveplayer,days,reason);
			    SaveLogs("TempBansLog",string);
			}
			else
			{
   			SendClientMessage(playerid,Red,"ERROR: Player is not connected");
			}
	}
	return 0;
}
//----------------------------------------------------------------------------//
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_JUMP)
	{
		if (MegaJump[playerid] == 1)
		{
		   	new Float:Jump[3];
		    GetPlayerVelocity(playerid, Jump[0], Jump[1], Jump[2]);
		    SetPlayerVelocity(playerid, Jump[0], Jump[1], Jump[2]+5);
			return 1;
		}
	}
	return 1;
}
//----------------------------------------------------------------------------//
public GmTime(playerid)
{
	if (AutoGm[playerid] == 0) return 1;
 	if (AutoGm[playerid] == 1)
  	{
		if(IsPlayerConnected(playerid))
		{
			SetPlayerHealth(playerid,100000);
		}
		if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
		{
			SetVehicleHealth(GetPlayerVehicleID(playerid),10000);
		}
	}
	return 1;
}
//----------------------------------------------------------------------------//
forward HighLight(playerid);
public HighLight(playerid)
{
	if(!IsPlayerConnected(playerid))
	return 1;

	if(pHighLight[playerid] == 0)
	{
	SetPlayerColor(playerid, 0xFF0000FF);
	pHighLight[playerid] = 1;
	}
	else
	{
	SetPlayerColor(playerid, 0xFF000000);
	pHighLight[playerid] = 0;
	}
	return 0;
}
//----------------------------------------------------------------------------//
public OnPlayerEditObject( playerid, playerobject, objectid, response,
Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ )
{
if(response == EDIT_RESPONSE_FINAL || EDIT_RESPONSE_CANCEL)
{
new string[256];
format(string, sizeof(string), "CreateObject(%d, %0.2f, %0.2f, %0.2f, %0.2f, %0.2f, %0.2f);", ObjModel[playerid], fX, fY, fZ, fRotX, fRotY, fRotZ);
SaveLogs("CreatedObjects",string);
format(string, sizeof(string), "* Object Created: (Id: %d) (Position: X: %0.2f, Y: %0.2f, Z: %0.2f) (Rot: X: %0.2f, Y: %0.2f, Z: %0.2f) *", ObjModel[playerid], fX, fY, fZ, fRotX, fRotY, fRotZ);
SendClientMessage(playerid,	COLOR_ERROR, string);
ObjModel[playerid] = -1;
}
return 1;
}
//----------------------------------------------------------------------------//
public SaveLogs(filename[],text[])
{
	new File:file;
	new filepath[256];
	new string[256];
	new year,month,day;
	new hour,minute,second;

	getdate(year,month,day);
	gettime(hour,minute,second);
	format(filepath,sizeof(filepath),"ZeroAdmin/Logs/%s.txt",filename);
	file = fopen(filepath,io_append);
	format(string,sizeof(string),"[%02d/%02d/%02d] [%02d:%02d:%02d] %s\r\n",day,month,year,hour,minute,second,text);
	fwrite(file,string);
	fclose(file);
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(Caroff[playerid] == 1)
	{
	new veh = GetPlayerVehicleID(playerid);
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(veh,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
	Caroff[playerid] = 0;
	}
	
	if(CCPlayer[playerid] == 1)
	{
	CCPlayer[playerid] = 0;
	}
	return 1;
}
//----------------------------------------------------------------------------//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOGID_REGISTER)
	{
	if(response)
	{
	if(!strlen(inputtext))
	{
 	new string[256];
    format(string,256,"{FFFFFF}Welcome to the {0049FF}'%s'\n\n{FFFFFF}Account {0049FF}'%s' {FFFFFF}is not registred!\n\n{FFFFFF}Enter the {F3FF02}password {FFFFFF}to Register your Account:",GetServerHostName(),pName(playerid));
	ShowPlayerDialog(playerid,DIALOGID_REGISTER,DIALOG_STYLE_INPUT,"Register",string,"Register","Quit");
	}
	else
	{
		new file[256],PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid,PlayerName,MAX_PLAYER_NAME);
 		new strdate[20], year,month,day,ip[128];
		getdate(year, month, day);
		format(strdate,sizeof(strdate),"%d/%d/%d",day,month,year);
 		format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",PlayerName);
 		GetPlayerIp(playerid,ip,sizeof(ip));
  		dini_Create(file);
  		dini_IntSet(file,"Password",encodepass(inputtext));
  		dini_Set(file,"RegisteredDate",strdate);
  		dini_Set(file,"Ip",ip);
  		dini_IntSet(file,"Registered",1);
  		dini_IntSet(file,"Logged",1);
  		dini_IntSet(file,"Banned",0);
  		dini_IntSet(file,"Kills",0);
  		dini_IntSet(file,"Level",0);
  		dini_IntSet(file,"LastOn",0);
  		dini_IntSet(file,"Hours",0);
  		dini_IntSet(file,"Minutes",0);
  		dini_IntSet(file,"Seconds",0);
  		dini_IntSet(file,"Deaths",0);
  		dini_IntSet(file,"Score",Account[playerid][Score] = 0);
  		dini_IntSet(file,"Cash",Account[playerid][Cash] = 0);
  		Account[playerid][Registered] = 1;
  		Account[playerid][Logged] = true;
  		Account[playerid][Muted] = 0;
  		SendClientMessage(playerid,COLOR_LBLUE,"*-* You are now registered and automatically logged in *-*");
		}
	}
	else if(!response)
	{
	Kick(playerid);
	}
	return 1;
	}
	if(dialogid == DIALOGID_LOGIN)
	{
		if(response)
		{
		new file[128], vardas[128], pass[256];
		GetPlayerName(playerid, vardas, 128);
		format(file,128,"ZeroAdmin/Accounts/%s.ini",vardas);
		pass = dini_Get(file,"Password");
		
		if(encodepass(inputtext) != strval(pass))
		{
		Account[playerid][FailLogin]++;
		new string[256];
		format(string, sizeof(string), "{0049FF}'%s'\n\n{FFFFFF}Welcome back {0049FF}%s\n\n{FFFFFF}Before playing you must login\n\nEnter your {F3FF02}password {FFFFFF}below and click login\n\n{F81414}Wrong password Attempt %d/%d",GetServerHostName(),pName(playerid),Account[playerid][FailLogin],MAX_FAIL_LOGINS);
		ShowPlayerDialog(playerid,DIALOGID_LOGIN,DIALOG_STYLE_INPUT,"Login Error",string,"Login","Cancel");
		if(Account[playerid][FailLogin] == MAX_FAIL_LOGINS)
		{
		format(string, sizeof(string), "Player %s has been automatically kicked (Reason: Many attempts Incorrect Passwords)", pName(playerid));
		SendClientMessageToAll(Red, string);
		SaveLogs("KickLog",string);
		Kick(playerid);
		}
		}
		else
		{
		LoginPlayer(playerid);
		return 0;
		}
		}
		else if(!response)
		{
		Kick(playerid);
		}
		return 1;
	}

if(dialogid == DIALOG_Enable/Disable)
{
if(response)
{
new string[256];
switch(listitem)
{
case 0: // Anti Spam
{
EnabDisab[playerid][AntiSpam] = 1;
format(string, sizeof string,"Enable or Disable Anti Spam");
}
case 1: // Auto Login
{
EnabDisab[playerid][AutoLogin] = 1;
format(string, sizeof string,"Enable or Disable Auto Login");
}
case 2: // Max Ping
{
EnabDisab[playerid][MaxPing] = 1;
format(string, sizeof string,"Enable or Disable Max Ping Kick");
}
case 3: // Killing Spree
{
EnabDisab[playerid][Killing_Spree] = 1;
format(string, sizeof string,"Enable or Disable Killing Spree");
}
case 4: // Admin Teleport
{
EnabDisab[playerid][AdminTeleport] = 1;
format(string, sizeof string,"Enable or Disable Admin Teleport");
}
}
ShowPlayerDialog(playerid,DIALOG_Enable/Disable+1,DIALOG_STYLE_MSGBOX,"Enable/Disable",string,"Enable","Disable");
}
}
if(dialogid == DIALOG_Enable/Disable+1)
{
new file[256];
format(file,sizeof(file),"ZeroAdmin/Config.ini");
if(response)
{
if(EnabDisab[playerid][AntiSpam] == 1)
{
ServerInfo[AntiSpam] = 1;
dini_IntSet(file,"AntiSpam", ServerInfo[AntiSpam]);
EnabDisab[playerid][AntiSpam] = 0;
}
if(EnabDisab[playerid][AutoLogin] == 1)
{
ServerInfo[AutoLogin] = 1;
dini_IntSet(file,"AutoLogin", ServerInfo[AutoLogin]);
EnabDisab[playerid][AutoLogin] = 0;
}
if(EnabDisab[playerid][Killing_Spree] == 1)
{
ServerInfo[Killing_Spree] = 1;
dini_IntSet(file,"KillingSpree", ServerInfo[Killing_Spree]);
EnabDisab[playerid][Killing_Spree] = 0;
}
if(EnabDisab[playerid][MaxPing] == 1)
{
ServerInfo[MaxPing] = 1;
dini_IntSet(file,"MaxPing", ServerInfo[MaxPing]);
EnabDisab[playerid][MaxPing] = 0;
}
if(EnabDisab[playerid][AdminTeleport] == 1)
{
ServerInfo[AdminTeleport] = 1;
dini_IntSet(file,"AdminTeleport", ServerInfo[AdminTeleport]);
EnabDisab[playerid][AdminTeleport] = 0;
}
}
else
{
if(EnabDisab[playerid][AntiSpam] == 1)
{
ServerInfo[AntiSpam] = 0;
dini_IntSet(file,"AntiSpam", ServerInfo[AntiSpam]);
EnabDisab[playerid][AntiSpam] = 0;
}
if(EnabDisab[playerid][AutoLogin] == 1)
{
ServerInfo[AutoLogin] = 0;
dini_IntSet(file,"AutoLogin", ServerInfo[AutoLogin]);
EnabDisab[playerid][AutoLogin] = 0;
}
if(EnabDisab[playerid][Killing_Spree] == 1)
{
ServerInfo[Killing_Spree] = 0;
dini_IntSet(file,"KillingSpree", ServerInfo[Killing_Spree]);
EnabDisab[playerid][Killing_Spree] = 0;
}
if(EnabDisab[playerid][MaxPing] == 1)
{
ServerInfo[MaxPing] = 0;
dini_IntSet(file,"MaxPing", ServerInfo[MaxPing]);
EnabDisab[playerid][MaxPing] = 0;
}
if(EnabDisab[playerid][AdminTeleport] == 1)
{
ServerInfo[AdminTeleport] = 0;
dini_IntSet(file,"AdminTeleport", ServerInfo[AdminTeleport]);
EnabDisab[playerid][AdminTeleport] = 0;
}
}
}
if(dialogid == DIALOGID_ADMIN)
{
if(response)
{
switch(listitem)
{
case 0:
{
new string[768], str[256];
new h,m,s;
new TargetID = CmdPlayer[playerid];
TotalGameTime(TargetID, h, m, s);
format(string, sizeof(string),
"{6EF83C}Level: {FFFFFF}%d\n{6EF83C}Kills: {FFFFFF}%d\n{6EF83C}Deaths: {FFFFFF}%d\n{6EF83C}Score: {FFFFFF}%d\n{6EF83C}Money: {FFFFFF}$%d\n{6EF83C}Hours: {FFFFFF}%d\n{6EF83C}Min: {FFFFFF}%d\n{6EF83C}Sec: {FFFFFF}%d", Account[TargetID][Level], Account[TargetID][Kills], Account[TargetID][Deaths], GetPlayerScore(TargetID), GetPlayerMoney(TargetID),h,m,s);
format(str,sizeof(str),"{6EF83C}%s's {FFFFFF}Stats",pName(TargetID));
ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_MSGBOX, str, string, "OK","");
}
case 1:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot kick Admin!");
ShowPlayerDialog(playerid,2011,DIALOG_STYLE_INPUT,"{6EF83C}Kick.","{FFFFFF}Write the reson for the kick:","Kick","Exit");
}
case 2:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot ban Admin!");
ShowPlayerDialog(playerid,2010,DIALOG_STYLE_INPUT,"{6EF83C}Ban.","{FFFFFF}Write the reson for the ban:","Ban","Exit");
}
case 3:
{
ShowPlayerDialog(playerid,2013,DIALOG_STYLE_INPUT,"{6EF83C}Score.","{FFFFFF}Write the new score value for the player:","Ok","");
}
case 4:
{
ShowPlayerDialog(playerid,2014,DIALOG_STYLE_INPUT,"{6EF83C}Money.","{FFFFFF}Write the new money value for the player:","Ok","");
}
case 5:
{
ShowPlayerDialog(playerid,2015,DIALOG_STYLE_INPUT,"{6EF83C}Weapon.","{FFFFFF}Write the id of the weapon:","Ok","");
}
case 6:
{
new string[256];
new Float:x,Float:y,Float:z;
GetPlayerPos(playerid, x, y, z);
SetPlayerPos(CmdPlayer[playerid], x, y, z+1);
format(string,sizeof(string),"You teleported %s to you.",GetName(CmdPlayer[playerid]));
SendClientMessage(playerid,COLOR_ERROR,string);CmdPlayer[playerid] = -1;
}
case 7:
{
new string[256];
new Float:x,Float:y,Float:z;
GetPlayerPos(CmdPlayer[playerid], x, y, z);
SetPlayerPos(playerid, x, y, z+1);
format(string,sizeof(string),"You been teleported to %s",GetName(CmdPlayer[playerid]));
SendClientMessage(playerid,COLOR_ERROR,string);CmdPlayer[playerid] = -1;
}
case 8:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot eject Admin!");
new string[256];
new Float:x,Float:y,Float:z;
GetPlayerPos(CmdPlayer[playerid], x, y, z);
SetPlayerPos(CmdPlayer[playerid], x, y, z+3);
format(string,sizeof(string),"You have ejected player %s from his vehicle.",GetName(CmdPlayer[playerid]));
SendClientMessage(playerid,COLOR_ERROR,string);CmdPlayer[playerid] = -1;
}
case 9:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot jail Admin!");
new string[256];
TogglePlayerControllable(CmdPlayer[playerid],false);
SetPlayerInterior(CmdPlayer[playerid],6);
SetPlayerPos(CmdPlayer[playerid],264.0946,77.6202,1001.0391);
ResetPlayerWeapons(CmdPlayer[playerid]);
SetCameraBehindPlayer(CmdPlayer[playerid]);
Account[CmdPlayer[playerid]][Jailed] = 1;
timer = SetTimerEx("Unjail", 120000, 0, "i", CmdPlayer[playerid]);
format(string,sizeof(string),"Admin %s has jailed player %s",GetName(playerid),GetName(CmdPlayer[playerid]));
SendClientMessageToAll(Red,string);CmdPlayer[playerid] = -1;
}
case 10:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot salp Admin!");
new string[256];
new Float:x,Float:y,Float:z;
GetPlayerPos(CmdPlayer[playerid], x, y, z);
SetPlayerPos(CmdPlayer[playerid], x, y, z+5);
format(string,sizeof(string),"Admin %s has slapped player %s!",GetName(playerid),GetName(CmdPlayer[playerid]));
SendClientMessageToAll(COLOR_ERROR,string);CmdPlayer[playerid]=-1;
}
case 11:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot drop Admin!");
new string[256];
new Float:x,Float:y,Float:z;
GetPlayerPos(CmdPlayer[playerid], x, y, z);
SetPlayerPos(CmdPlayer[playerid], x, y, z+20);
format(string,sizeof(string),"You have dropped player %s from 20 feet.",GetName(CmdPlayer[playerid]));
SendClientMessage(playerid,COLOR_ERROR,string);CmdPlayer[playerid]=-1;
}
case 12:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot disarm Admin!");
new string[256];
ResetPlayerWeapons(CmdPlayer[playerid]);
format(string,sizeof(string),"You have disarmed player %s",GetName(CmdPlayer[playerid]));
SendClientMessage(playerid,COLOR_ERROR,string);CmdPlayer[playerid]=-1;
}
case 13:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot explode Admin!");
new string[256];
new Float:x, Float:y, Float:z;
GetPlayerPos(CmdPlayer[playerid],x, y, z);
CreateExplosion(x, y , z, 7,10.0);
format(string,sizeof(string),"You have exploded player %s",GetName(CmdPlayer[playerid]));
SendClientMessage(playerid,COLOR_ERROR,string);CmdPlayer[playerid]=-1;
}
case 14:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot kill Admin!");
new string[256];
SetPlayerHealth(CmdPlayer[playerid], 0);
format(string,sizeof(string),"Admin %s has killed player %s",GetName(playerid),GetName(CmdPlayer[playerid]));
SendClientMessageToAll(COLOR_ERROR,string);CmdPlayer[playerid]=-1;
}
case 15:
{
if(Account[CmdPlayer[playerid]][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot rape Admin!");
new string[256];
SetPlayerHealth(CmdPlayer[playerid],1);
SetPlayerArmour(CmdPlayer[playerid],1);
SetPlayerDrunkLevel(CmdPlayer[playerid],3000);
SetPlayerWantedLevel(CmdPlayer[playerid], 6);
SetPlayerSkin(CmdPlayer[playerid], 85);
SetPlayerColor(CmdPlayer[playerid],COLOR_WHITE);
format(string,sizeof(string),"RAPE TIME: %s has been rapped!",GetName(CmdPlayer[playerid]));
SendClientMessageToAll(Red,string);CmdPlayer[playerid]=-1;
}
}
}
}
if(dialogid == 2010)
{
if(response)
{
if(!strlen(inputtext))
return SendClientMessage(playerid, COLOR_ERROR, "ERROR: Reason unspecified!") &&
ShowPlayerDialog(playerid,2010,DIALOG_STYLE_INPUT,"{6EF83C}Ban.","{FFFFFF}Write the reson for the ban:","Ban","Exit");
new str[256];
format(str,sizeof(str),"Admin %s has banned %s, Reason:%s",GetName(playerid),GetName(CmdPlayer[playerid]),inputtext);
SendClientMessageToAll(COLOR_ERROR,str);
Account[CmdPlayer[playerid]][Banned] = 1;
BanEx(CmdPlayer[playerid],inputtext);CmdPlayer[playerid] = -1;
}
}
if(dialogid == 2011)
{
if(response)
{
if(!strlen(inputtext))
return SendClientMessage(playerid, COLOR_ERROR, "ERROR: Reason unspecified!") &&
ShowPlayerDialog(playerid,2011,DIALOG_STYLE_INPUT,"{6EF83C}Kick.","{FFFFFF}Write the reson for the kick:","Kick","Exit");
new str[256];
format(str,sizeof(str),"Admin %s has kicked %s, Reason:%s",GetName(playerid),GetName(CmdPlayer[playerid]),inputtext);
SendClientMessageToAll(COLOR_BLUE,str);
Kick(CmdPlayer[playerid]);CmdPlayer[playerid] = -1;
}
}
if(dialogid == 2013)
{
if(response)
{
new string[128];
new score = strval(inputtext);
format(string, sizeof(string), "* You have set %s's Score to %d *",pName(CmdPlayer[playerid]),score);
SendClientMessage(playerid,Red,string);
SetPlayerScore(CmdPlayer[playerid], score);CmdPlayer[playerid]=-1;
}
}
if(dialogid == 2014)
{
if(response)
{
new string[128];
new money = strval(inputtext);
format(string, sizeof(string), "* You have set %s's Money to %d *",pName(CmdPlayer[playerid]),money);
SendClientMessage(playerid,Red,string);
ResetPlayerMoney(CmdPlayer[playerid]);
GivePlayerMoney(CmdPlayer[playerid], money);CmdPlayer[playerid]=-1;
}
}
if(dialogid == 2015)
{
if(response)
{
new weap = strval(inputtext), ammo, WeapName[32];	ammo = 150;
if (weap > 0 && weap < 19 || weap > 21 && weap < 47)
{
GetWeaponName(weap,WeapName,32);
GivePlayerWeapon(CmdPlayer[playerid], weap, ammo);CmdPlayer[playerid]=-1;
}
else
{
SendClientMessage(playerid,COLOR_ERROR,"Invalid Weapon ID");
return 1;
}
}
}
if(dialogid == DIALOGID_ZCONSOLE)
{
if(response)
{
// Change Mode //
if(listitem == 0) { ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE+1,DIALOG_STYLE_INPUT,"Zero Admin Console","Changemode:\n","Load","Back");}
// Gmx //
if(listitem == 1) { SendRconCommand("gmx"); SendClientMessage(playerid,COLOR_ERROR,"Console Command Sent!");}
// Load Filterscript   //
if(listitem == 2) { ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE+2,DIALOG_STYLE_INPUT,"Zero Admin Console","Load FilterScript:\n","Load","Back");}
// UnLoad Filterscript //
if(listitem == 3) { ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE+3,DIALOG_STYLE_INPUT,"Zero Admin Console","Unload FilterScript:\n","Unload","Back");}
// Reload Zero Admin //
if(listitem == 4) { SendRconCommand("reloadfs zeroadmin"); SendClientMessage(playerid,COLOR_ERROR,"Console Command Sent!");}
// Unban IP //
if(listitem == 5) { ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE+4,DIALOG_STYLE_INPUT,"Zero Admin Console","Unban IP:\n","Unban","Back");}
}
}
if(dialogid == DIALOGID_ZCONSOLE+1)
{
if(response)
{
new str[256],string[256];
format(string,sizeof(string),"%s has been Changed %s GameMode",pName(playerid),inputtext); SaveLogs("ConsoleLog",string);
format(str,sizeof(string),"changemode %s",inputtext);
SendClientMessage(playerid,COLOR_ERROR,"Console Command Sent!");
SendRconCommand(str);
}
else
{
ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE,DIALOG_STYLE_LIST, "Zero Admin Console",
"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nUnban IP", "Select", "Cancel");
}
}
if(dialogid == DIALOGID_ZCONSOLE+2)
{
if(response)
{
new str[256],string[256];
format(string,sizeof(string),"%s has been Loaded %s Filterscript",pName(playerid),inputtext); SaveLogs("ConsoleLog",string);
format(str,sizeof(string),"loadfs %s",inputtext);
SendClientMessage(playerid,COLOR_ERROR,"Console Command Sent!");
SendRconCommand(str);
ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE,DIALOG_STYLE_LIST, "Zero Admin Console",
"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nUnban IP", "Select", "Cancel");
}
else
{
ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE,DIALOG_STYLE_LIST, "Zero Admin Console",
"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nUnban IP", "Select", "Cancel");
}
}
if(dialogid == DIALOGID_ZCONSOLE+3)
{
if(response)
{
new str[256],string[256];
format(string,sizeof(string),"%s has been Unloaded %s Filterscript",pName(playerid),inputtext); SaveLogs("ConsoleLog",string);
format(str,sizeof(string),"unloadfs %s",inputtext);
SendClientMessage(playerid,COLOR_ERROR,"Console Command Sent!");
SendRconCommand(str);
ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE,DIALOG_STYLE_LIST, "Zero Admin Console",
"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nUnban IP", "Select", "Cancel");
}
else
{
ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE,DIALOG_STYLE_LIST, "Zero Admin Console",
"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nUnban IP", "Select", "Cancel");
}
}
if(dialogid == DIALOGID_ZCONSOLE+4)
{
if(response)
{
new str[256],string[256];
format(string,sizeof(string),"%s has been Unbaned %s Ip",pName(playerid),inputtext); SaveLogs("ConsoleLog",string);
format(str,sizeof(string),"unbanip %s",inputtext);
SendClientMessage(playerid,COLOR_ERROR,"Console Command Sent!");
SendRconCommand(str);
ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE,DIALOG_STYLE_LIST, "Zero Admin Console",
"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nUnban IP", "Select", "Cancel");
}
else
{
ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE,DIALOG_STYLE_LIST, "Zero Admin Console",
"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nUnban IP", "Select", "Cancel");
}
}
if(dialogid == DIALOGID_ZMENU)
{
if(response)
{
if(listitem == 0)
{
ShowPlayerDialog(playerid,DIALOGID_ZMENU+1,DIALOG_STYLE_LIST,
"Server Weather","Blue Sky\nSand Storm\nThunderstorm\nFoggy\nCloudy\nHigh Tide\nPurple Sky\nBlack/White Sky\nDark, Green Sky\nHeatwave", "Select", "Back");
}
if(listitem == 1)
{
ShowPlayerDialog(playerid,DIALOGID_ZMENU+2,DIALOG_STYLE_LIST,
"Server Time","Morning\nMid day\nAfternoon\nEvening\nMidnight", "Select", "Back");
}
if(listitem == 2)
{
ShowPlayerDialog(playerid,DIALOGID_ZMENU+3,DIALOG_STYLE_LIST,
"Vehicles","Bicycles\nBikes\nMonster Trucks\nBoats\nHelicopters\nPlanes\nCars\nVehicles RC","Select","Cancel");
}
if(listitem == 3)
{
ShowPlayerDialog(playerid,DIALOGID_ZMENU+4,DIALOG_STYLE_LIST,
"Weapons","Machine Guns\nPistols\nRifles\nShotguns\nHeavy Assault\nSpecial Weapons\nHand Held\nMelee \nProjectile", "Select", "Back");
}
}
}
if(dialogid == DIALOGID_ZMENU+1) // Server Weather
{
if(response)
{
if(listitem == 0) {SetWeather(5); }
if(listitem == 1) {SetWeather(19);}
if(listitem == 2) {SetWeather(8); }
if(listitem == 3) {SetWeather(20);}
if(listitem == 4) {SetWeather(9); }
if(listitem == 5) {SetWeather(16);}
if(listitem == 6) {SetWeather(45);}
if(listitem == 7) {SetWeather(44);}
if(listitem == 8) {SetWeather(22);}
if(listitem == 9) {SetWeather(11);}
}
}
if(dialogid == DIALOGID_ZMENU+2) // Server Time
{
if(response)
{
if(listitem == 0) {for(new i = 0; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i))SetPlayerTime(i,7,0); }
if(listitem == 1) {for(new i = 0; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i))SetPlayerTime(i,12,0);}
if(listitem == 2) {for(new i = 0; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i))SetPlayerTime(i,16,0);}
if(listitem == 3) {for(new i = 0; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i))SetPlayerTime(i,20,0);}
if(listitem == 4) {for(new i = 0; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i))SetPlayerTime(i,0,0); }
}
}
if(dialogid == DIALOGID_ZMENU+3) // Vehicles
{
if(response)
{
if(listitem == 0){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+14, DIALOG_STYLE_LIST, "Bicycles", "Bike\nBMX\nMountain Bike", "Select", "Back");}
if(listitem == 1){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+15, DIALOG_STYLE_LIST, "Bikes", "NRG-500\nFaggio\nFCR-900\nPCJ-600\nFreeway\nBF-400\nPizzaBoy\nWayfarer\nCop Bike\nSanchez\nQuad", "Select", "Back");}
if(listitem == 2){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+16, DIALOG_STYLE_LIST, "Monster Trucks", "Dumper\nDuneride\nMonster\nMonster A\nMonster B", "Select", "Back");}
if(listitem == 3){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+17, DIALOG_STYLE_LIST, "Boats", "Coastguard\nDinghy\nJetmax\nLaunch\nMarquis\nPredator\nReefer\nSpeeder\nSqualo\nTropic", "Select", "Back");}
if(listitem == 4){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+18, DIALOG_STYLE_LIST, "Helicopters", "Cargobob\nHunter\nLeviathn\nMaverick\nPolmav\nRaindanc\nSeasparr\nSparrow\nVCN Helicopter", "Select", "Back");}
if(listitem == 5){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+19, DIALOG_STYLE_LIST, "Planes", "Hydra\nRustler\nDodo\nNevada\nSuntplane\nCropdust\nAT-400\nAndromeda\nBeagle\nVortex\nSkimmer\nShamal", "Select", "Back");}
if(listitem == 6){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+20, DIALOG_STYLE_LIST, "Cars", "Lowriders\nStreet Racers\nMuscle cars\nSuvs & Wagons\nSport Cars\nRecreational\nCivil\nGovernment\n4 door luxury\n2 door sedans\nHeavy trucks\nLight trucks", "Select", "Back");}
if(listitem == 7){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+21, DIALOG_STYLE_LIST, "Vehicles RC","RC Goblin\nRC Raider\nRC Barron \nRC Bandit\nRC Cam\nRC Tiger", "Select", "Back");}
}
}
if(dialogid == DIALOGID_ZMENU+4) // Weapons
{
if(response)
{
if(listitem == 0){ShowPlayerDialog(playerid, DIALOGID_ZMENU+5, DIALOG_STYLE_LIST, "Machine Guns", "Micro SMG \nSMG \nAK47 \nM4 \nTec9", "Select", "Back");}
if(listitem == 1){ShowPlayerDialog(playerid, DIALOGID_ZMENU+6, DIALOG_STYLE_LIST, "Pistols", "9mm \nSilenced 9mm \nDeagle", "Select", "Back");}
if(listitem == 2){ShowPlayerDialog(playerid, DIALOGID_ZMENU+7, DIALOG_STYLE_LIST, "Rifles", "Country Rifle \nSniper Rifle", "Select", "Back");}
if(listitem == 3){ShowPlayerDialog(playerid, DIALOGID_ZMENU+8, DIALOG_STYLE_LIST, "Shotguns", "Shotgun \nSawnoff Shotgun \nCombat Shotgun", "Select", "Back");}
if(listitem == 4){ShowPlayerDialog(playerid, DIALOGID_ZMENU+9, DIALOG_STYLE_LIST, "Heavy Assaults", "Rocket Launcher \nHS Rocket Launcher \nFlamethrower \nMinigun", "Select", "Back");}
if(listitem == 5){ShowPlayerDialog(playerid, DIALOGID_ZMENU+10, DIALOG_STYLE_LIST, "Special", "Camera \nNightvision Goggles \nInfared Vision \nParachute", "Select", "Back");}
if(listitem == 6){ShowPlayerDialog(playerid, DIALOGID_ZMENU+11, DIALOG_STYLE_LIST, "Hand Held", "Spraycan \nFire Extinguisher", "Select", "Back");}
if(listitem == 7){ShowPlayerDialog(playerid, DIALOGID_ZMENU+12, DIALOG_STYLE_LIST, "Melee","Brass Knuckles \nGolf Club \nNite Stick \nKnife \nBaseball Bat \nShovel \nPool Cue \nKatana \nChainsaw \nPurple Dildo \nSmall White Vibrator \nLarge White Vibrator \nSilver Vibrator \nFlowers \nCane", "Select", "Back");}
if(listitem == 8){ShowPlayerDialog(playerid, DIALOGID_ZMENU+13, DIALOG_STYLE_LIST, "Projetile", "Grenade \nTear Gas \nMolotov Cocktail \nSatchel Charge \nDetonator", "Select", "Back");}
}
}
if(dialogid == DIALOGID_ZMENU+5)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,28, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,29, 999);}
if(listitem == 2){GivePlayerWeapon(playerid,30, 999);}
if(listitem == 3){GivePlayerWeapon(playerid,31, 999);}
if(listitem == 4){GivePlayerWeapon(playerid,32, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+6)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,22, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,23, 999);}
if(listitem == 2){GivePlayerWeapon(playerid,24, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+7)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,33, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,34, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+8)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,25, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,26, 999);}
if(listitem == 2){GivePlayerWeapon(playerid,27, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+9)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,35, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,36, 999);}
if(listitem == 2){GivePlayerWeapon(playerid,37, 999);}
if(listitem == 3){GivePlayerWeapon(playerid,38, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+10)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,43, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,44, 999);}
if(listitem == 2){GivePlayerWeapon(playerid,45, 999);}
if(listitem == 3){GivePlayerWeapon(playerid,46, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+11)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,41, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,42, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+12)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,1, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,2, 999);}
if(listitem == 2){GivePlayerWeapon(playerid,3, 999);}
if(listitem == 3){GivePlayerWeapon(playerid,4, 999);}
if(listitem == 4){GivePlayerWeapon(playerid,5, 999);}
if(listitem == 5){GivePlayerWeapon(playerid,6, 999);}
if(listitem == 6){GivePlayerWeapon(playerid,7, 999);}
if(listitem == 7){GivePlayerWeapon(playerid,8, 999);}
if(listitem == 8){GivePlayerWeapon(playerid,9, 999);}
if(listitem == 9){GivePlayerWeapon(playerid,10, 999);}
if(listitem == 10){GivePlayerWeapon(playerid,11, 999);}
if(listitem == 11){GivePlayerWeapon(playerid,12, 999);}
if(listitem == 12){GivePlayerWeapon(playerid,13, 999);}
if(listitem == 13){GivePlayerWeapon(playerid,14, 999);}
if(listitem == 14){GivePlayerWeapon(playerid,15, 999);}
if(listitem == 15){GivePlayerWeapon(playerid,16, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+13)
{
if(response)
{
if(listitem == 0){GivePlayerWeapon(playerid,16, 999);}
if(listitem == 1){GivePlayerWeapon(playerid,17, 999);}
if(listitem == 2){GivePlayerWeapon(playerid,18, 999);}
if(listitem == 3){GivePlayerWeapon(playerid,39, 999);}
if(listitem == 4){GivePlayerWeapon(playerid,40, 999);}
}
}
if(dialogid == DIALOGID_ZMENU+14)
{
if(response)
{
if(listitem == 0){ VC(playerid,509);}
if(listitem == 1){ VC(playerid,481);}
if(listitem == 2){ VC(playerid,510);}
}
}
if(dialogid == DIALOGID_ZMENU+15)
{
if(response)
{
if(listitem == 0){VC(playerid,522);}
if(listitem == 1){VC(playerid,462);}
if(listitem == 2){VC(playerid,521);}
if(listitem == 3){VC(playerid,461);}
if(listitem == 4){VC(playerid,463);}
if(listitem == 5){VC(playerid,581);}
if(listitem == 6){VC(playerid,448);}
if(listitem == 7){VC(playerid,586);}
if(listitem == 8){VC(playerid,523);}
if(listitem == 9){VC(playerid,468);}
if(listitem == 10){VC(playerid,471);}
}
}
if(dialogid == DIALOGID_ZMENU+16)
{
if(response)
{
if(listitem == 0){ VC(playerid,406);}
if(listitem == 1){ VC(playerid,573);}
if(listitem == 2){ VC(playerid,444);}
if(listitem == 3){ VC(playerid,556);}
if(listitem == 4){ VC(playerid,557);}
}
}
if(dialogid == DIALOGID_ZMENU+17)
{
if(response)
{
if(listitem == 0){ VC(playerid,472);}
if(listitem == 1){ VC(playerid,473);}
if(listitem == 2){ VC(playerid,493);}
if(listitem == 3){ VC(playerid,595);}
if(listitem == 4){ VC(playerid,484);}
if(listitem == 5){ VC(playerid,430);}
if(listitem == 6){ VC(playerid,453);}
if(listitem == 7){ VC(playerid,452);}
if(listitem == 8){ VC(playerid,446);}
if(listitem == 9){ VC(playerid,454);}
}
}
if(dialogid == DIALOGID_ZMENU+18)
{
if(response)
{
if(listitem == 0){ VC(playerid,548);}
if(listitem == 1){ VC(playerid,425);}
if(listitem == 2){ VC(playerid,417);}
if(listitem == 3){ VC(playerid,487);}
if(listitem == 4){ VC(playerid,497);}
if(listitem == 5){ VC(playerid,563);}
if(listitem == 6){ VC(playerid,447);}
if(listitem == 7){ VC(playerid,469);}
if(listitem == 8){ VC(playerid,488);}
}
}
if(dialogid == DIALOGID_ZMENU+19)
{
if(response)
{
if(listitem == 0){ VC(playerid,520);}
if(listitem == 1){ VC(playerid,476);}
if(listitem == 2){ VC(playerid,593);}
if(listitem == 3){ VC(playerid,553);}
if(listitem == 4){ VC(playerid,513);}
if(listitem == 5){ VC(playerid,512);}
if(listitem == 6){ VC(playerid,577);}
if(listitem == 7){ VC(playerid,592);}
if(listitem == 8){ VC(playerid,511);}
if(listitem == 9){ VC(playerid,539);}
if(listitem == 10){ VC(playerid,460);}
if(listitem == 11){ VC(playerid,519);}
}
}
if(dialogid == DIALOGID_ZMENU+20)
{
if(response)
{
if(listitem == 0){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+22, DIALOG_STYLE_LIST, "Lowriders", "Blade\nBroadway\nRemmington\nSavanna\nSlamvan\nTornado\nVoodoo", "Select", "Back");}
if(listitem == 1){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+23, DIALOG_STYLE_LIST, "Street Racers","Elegy\nFlash\nJester\nStratum\nSultan\nUranus", "Select", "Back");}
if(listitem == 2){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+24, DIALOG_STYLE_LIST, "Muscle Cars", "Buffalo\nClover\nPhoenix\nSabre", "Select", "Back");}
if(listitem == 3){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+25, DIALOG_STYLE_LIST, "Suvs & Wagons", "Huntley\nLandstalker\nPerenial\nRancher\nRegina\nRomero\nSolair", "Select", "Back");}
if(listitem == 4){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+26, DIALOG_STYLE_LIST, "Sport Cars", "Banshee\nBullet\nCheetah\nComet\nHotknife\nHotring Racer\nInfernus\nSuper GT\nTurismo\nWindsor\nZR-350", "Select", "Back");}
if(listitem == 5){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+27, DIALOG_STYLE_LIST, "Recreational", "Bandito\nBF Injection\nBloodring Banger\nCaddy\nCamper\nJourney\nKart\nMesa\nSandking\nVortex", "Select", "Back");}
if(listitem == 6){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+28, DIALOG_STYLE_LIST, "Civil", "Baggage\nBus\nCabbie\nCoach\nSweeper\nTaxi\nTowtruck\nTrashmaster\nUtiliy van", "Select", "Back");}
if(listitem == 7){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+29, DIALOG_STYLE_LIST, "Government", "Ambulance\nBarracks\nEnforcer\nFBI Rancher\nFBI Truck\nFiretruck\nPatriot\nPolite Car SF\nRanger\nSecuricar\nS.W.A.T", "Select", "Back");}
if(listitem == 8){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+30, DIALOG_STYLE_LIST, "4 Door Luxury", "Admiral\nElegant\nEmperor\nEuros\nGlendale\nGreenwood\nIntruder\nMerit\nNebula\nOceanic\nPremier\nPrimo\nSentinel\nStretch\nSunrise\nTahoma\nVincent\nWashington\nWillard", "Select", "Back");}
if(listitem == 9){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+31, DIALOG_STYLE_LIST, "2 Door Sedans", "Alpha\nBlista Compact\nBravura\nBaccaneer\nCadrona\nClub\nEsperanto\nFeltzer\nFortune\nHermer\nHustler\nMagestic\nManana\nPicador\nPrevion\nStafford\nStallion\nTampa\nVirgo", "Select", "Back");}
if(listitem == 10){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+32, DIALOG_STYLE_LIST, "Heavy trucks", "Benson\nBoxville\nCement truck\nCombine Harvester\nDFT-30\nDozer\nFlatbed\nHotdog\nLinerunner\nMr Whoopee\nMule\nPacker\nRoadtrain\nTanker\nTractor\nYankee", "Select", "Back");}
if(listitem == 11){ ShowPlayerDialog(playerid, DIALOGID_ZMENU+33, DIALOG_STYLE_LIST, "Light trucks", "Berkley's RC van\nBobcat\nBurrito\nForklift\nMoonbeam\nMower\nNewsvan\nNext page\nPony\nRumpo\nSadler\nTug\nWalton\nYosemite", "Select", "Back");}
}
}
if(dialogid == DIALOGID_ZMENU+21)
{
if(response)
{
if(listitem == 0){ VC(playerid,501);}
if(listitem == 0){ VC(playerid,465);}
if(listitem == 0){ VC(playerid,464);}
if(listitem == 0){ VC(playerid,441);}
if(listitem == 0){ VC(playerid,594);}
if(listitem == 0){ VC(playerid,564);}
}
}
if(dialogid == DIALOGID_ZMENU+22)
{
if(response)
{
if(listitem == 0){ VC(playerid,536);}
if(listitem == 1){ VC(playerid,575);}
if(listitem == 2){ VC(playerid,534);}
if(listitem == 3){ VC(playerid,567);}
if(listitem == 4){ VC(playerid,535);}
if(listitem == 5){ VC(playerid,576);}
if(listitem == 6){ VC(playerid,412);}
}
}
if(dialogid == DIALOGID_ZMENU+23)
{
if(response)
{
if(listitem == 0){ VC(playerid,562);}
if(listitem == 1){ VC(playerid,565);}
if(listitem == 2){ VC(playerid,559);}
if(listitem == 3){ VC(playerid,561);}
if(listitem == 4){ VC(playerid,560);}
if(listitem == 5){ VC(playerid,558);}
}
}
if(dialogid == DIALOGID_ZMENU+24)
{
if(response)
{
if(listitem == 0){ VC(playerid,402);}
if(listitem == 1){ VC(playerid,542);}
if(listitem == 2){ VC(playerid,603);}
if(listitem == 3){ VC(playerid,475);}
}
}
if(dialogid == DIALOGID_ZMENU+25)
{
if(response)
{
if(listitem == 0){ VC(playerid,579);}
if(listitem == 1){ VC(playerid,400);}
if(listitem == 2){ VC(playerid,404);}
if(listitem == 3){ VC(playerid,489);}
if(listitem == 4){ VC(playerid,479);}
if(listitem == 5){ VC(playerid,442);}
if(listitem == 6){ VC(playerid,458);}
}
}
if(dialogid == DIALOGID_ZMENU+26)
{
if(response)
{
if(listitem == 0){ VC(playerid,429);}
if(listitem == 1){ VC(playerid,541);}
if(listitem == 2){ VC(playerid,415);}
if(listitem == 3){ VC(playerid,480);}
if(listitem == 4){ VC(playerid,434);}
if(listitem == 5){ VC(playerid,494);}
if(listitem == 6){ VC(playerid,411);}
if(listitem == 7){ VC(playerid,506);}
if(listitem == 8){ VC(playerid,451);}
if(listitem == 9){ VC(playerid,555);}
if(listitem == 10){ VC(playerid,477);}
}
}
if(dialogid == DIALOGID_ZMENU+27)
{
if(response)
{
if(listitem == 0){ VC(playerid,568);}
if(listitem == 1){ VC(playerid,424);}
if(listitem == 2){ VC(playerid,504);}
if(listitem == 3){ VC(playerid,457);}
if(listitem == 4){ VC(playerid,483);}
if(listitem == 5){ VC(playerid,508);}
if(listitem == 6){ VC(playerid,571);}
if(listitem == 7){ VC(playerid,500);}
if(listitem == 8){ VC(playerid,495);}
if(listitem == 9){ VC(playerid,539);}
}
}
if(dialogid == DIALOGID_ZMENU+28)
{
if(response)
{
if(listitem == 0){ VC(playerid,485);}
if(listitem == 1){ VC(playerid,431);}
if(listitem == 2){ VC(playerid,438);}
if(listitem == 3){ VC(playerid,437);}
if(listitem == 4){ VC(playerid,574);}
if(listitem == 5){ VC(playerid,420);}
if(listitem == 6){ VC(playerid,525);}
if(listitem == 7){ VC(playerid,408);}
if(listitem == 8){ VC(playerid,552);}
}
}
if(dialogid == DIALOGID_ZMENU+29)
{
if(response)
{
if(listitem == 0){ VC(playerid,416);}
if(listitem == 1){ VC(playerid,433);}
if(listitem == 2){ VC(playerid,427);}
if(listitem == 3){ VC(playerid,490);}
if(listitem == 4){ VC(playerid,528);}
if(listitem == 5){ VC(playerid,407);}
if(listitem == 6){ VC(playerid,570);}
if(listitem == 7){ VC(playerid,597);}
if(listitem == 8){ VC(playerid,599);}
if(listitem == 9){ VC(playerid,428);}
if(listitem == 10){ VC(playerid,601);}
}
}
if(dialogid == DIALOGID_ZMENU+30)
{
if(response)
{
if(listitem == 0){ VC(playerid,445);}
if(listitem == 1){ VC(playerid,507);}
if(listitem == 2){ VC(playerid,585);}
if(listitem == 3){ VC(playerid,587);}
if(listitem == 4){ VC(playerid,466);}
if(listitem == 5){ VC(playerid,492);}
if(listitem == 6){ VC(playerid,546);}
if(listitem == 7){ VC(playerid,551);}
if(listitem == 8){ VC(playerid,516);}
if(listitem == 9){ VC(playerid,467);}
if(listitem == 10){ VC(playerid,426);}
if(listitem == 11){ VC(playerid,547);}
if(listitem == 12){ VC(playerid,405);}
if(listitem == 13){ VC(playerid,409);}
if(listitem == 14){ VC(playerid,550);}
if(listitem == 15){ VC(playerid,566);}
if(listitem == 16){ VC(playerid,540);}
if(listitem == 17){ VC(playerid,421);}
if(listitem == 18){ VC(playerid,529);}
}
}
if(dialogid == DIALOGID_ZMENU+31)
{
if(response)
{
if(listitem == 0){ VC(playerid,602);}
if(listitem == 1){ VC(playerid,496);}
if(listitem == 2){ VC(playerid,401);}
if(listitem == 3){ VC(playerid,518);}
if(listitem == 4){ VC(playerid,527);}
if(listitem == 5){ VC(playerid,589);}
if(listitem == 6){ VC(playerid,419);}
if(listitem == 7){ VC(playerid,533);}
if(listitem == 8){ VC(playerid,526);}
if(listitem == 9){ VC(playerid,474);}
if(listitem == 10){ VC(playerid,545);}
if(listitem == 11){ VC(playerid,517);}
if(listitem == 12){ VC(playerid,410);}
if(listitem == 13){ VC(playerid,600);}
if(listitem == 14){ VC(playerid,436);}
if(listitem == 15){ VC(playerid,580);}
if(listitem == 16){ VC(playerid,439);}
if(listitem == 17){ VC(playerid,549);}
if(listitem == 18){ VC(playerid,491);}
}
}
if(dialogid == DIALOGID_ZMENU+32)
{
if(response)
{
if(listitem == 0){ VC(playerid,499);}
if(listitem == 1){ VC(playerid,498);}
if(listitem == 2){ VC(playerid,524);}
if(listitem == 3){ VC(playerid,532);}
if(listitem == 4){ VC(playerid,578);}
if(listitem == 5){ VC(playerid,486);}
if(listitem == 6){ VC(playerid,455);}
if(listitem == 7){ VC(playerid,588);}
if(listitem == 8){ VC(playerid,403);}
if(listitem == 9){ VC(playerid,423);}
if(listitem == 10){ VC(playerid,414);}
if(listitem == 11){ VC(playerid,443);}
if(listitem == 12){ VC(playerid,515);}
if(listitem == 13){ VC(playerid,514);}
if(listitem == 14){ VC(playerid,531);}
if(listitem == 15){ VC(playerid,456);}
}
}
if(dialogid == DIALOGID_ZMENU+33)
{
if(response)
{
if(listitem == 0){ VC(playerid,459);}
if(listitem == 1){ VC(playerid,422);}
if(listitem == 2){ VC(playerid,482);}
if(listitem == 3){ VC(playerid,530);}
if(listitem == 4){ VC(playerid,418);}
if(listitem == 5){ VC(playerid,572);}
if(listitem == 6){ VC(playerid,582);}
if(listitem == 7){ VC(playerid,413);}
if(listitem == 8){ VC(playerid,440);}
if(listitem == 9){ VC(playerid,543);}
if(listitem == 10){ VC(playerid,583);}
if(listitem == 11){ VC(playerid,478);}
if(listitem == 12){ VC(playerid,554);}
}
}
if(dialogid == DIALOG_TYPE_SERV_PASS)
{
if (response)
{
new string[256];
new file[256];
format(file,sizeof(file),"ZeroAdmin/Config.ini");
new pass[256];
pass = dini_Get(file,"Password");
if(PasswordAtt[playerid] == 3) return KickPlayer(playerid,"Server Password Attempts");
if(strcmp(pass, inputtext, false) == 0 && !(!strlen(inputtext)))
{
SendClientMessage(playerid,COLOR_WHITE,"SERVER: You have successsfully entered the server Password!");
format(string, sizeof(string), "* %s has Successfully entered server Password *",pName(playerid));
MessageToAdmins(COLOR_WHITE, string);
} else {
if(PasswordAtt[playerid] == 2)
{
Kick(playerid);
}
SendClientMessage(playerid, Red, "*Invalid server password, try again or cancel *");
new str[256];
PasswordAtt[playerid]++;
format(str,256,"Wrong Password(Attempt %d/3)\nEnter the password to access it:",PasswordAtt[playerid]);
ShowPlayerDialog(playerid, DIALOG_TYPE_SERV_PASS, DIALOG_STYLE_INPUT, "Server is currently locked.",str , "Enter", "Cancel");
}
} else {
SendClientMessage(playerid, Red, "You have no business here.");
Kick(playerid);
}
return 1;
}

if(dialogid == DIALOG_TYPE_SERV_UNLOCK)
{
if(response)
{
new adminname[MAX_PLAYER_NAME];
GetPlayerName(playerid, adminname, sizeof(adminname));
new string[256];
ServerInfo[Locked] = 0;
strmid(ServerInfo[Password], "", 0, strlen(""), 256);
new file[256];
format(file,sizeof(file),"ZeroAdmin/Config.ini");
dini_IntSet(file,"Locked", 0);
dini_Set(file,"Password","");
format(string, sizeof(string), "* Administrator %s has Unlocked the Server *",adminname);
SendClientMessageToAll(COLOR_GREEN,string);
CmdToAdmins(playerid,"Unlock Server");
}
return 1;
}
if(dialogid == DIALOG_TYPE_RCON2) //Credits to LuxAdmin
	{
	    if (response)
	    {
        	if (!strcmp(TwoRconPass, inputtext) && !(!strlen(inputtext)))
			{
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~g~Welcome ~r~Administrator!",3000,3);
			}
			else
			{
				if(Account[playerid][RconAtt] == 3)
				{
      				KickPlayer(playerid,"Maximum number of Two Rcon attempts");
				}
				Account[playerid][RconAtt]++;
				new str[140];
   				format(str,sizeof(str),"{F81414}Invalid Password!. \n\n{6EF83C}For access the account, you must enter the Correct second password Rcon.\n\n{F81414}Attempts: %d/3", Account[playerid][RconAtt]);
				ShowPlayerDialog(playerid, DIALOG_TYPE_RCON2, DIALOG_STYLE_INPUT, "{6EF83C}Zero Admin Rcon",str, "Enter", "Exit");
			}
   		}
		else
		{
			SendClientMessage(playerid, Red, "{F81414}ERROR: Kicked!");
	    	return Kick(playerid);
	    }
	    return 1;
	}
return 1;
}

//----------------------------------------------------------------------------//
LoginPlayer(playerid)
{
new file[256],PlayerName[MAX_PLAYER_NAME];
GetPlayerName(playerid,PlayerName,MAX_PLAYER_NAME);
format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",PlayerName);

dini_IntSet(file,"Logged",1);
new str[128];

Account[playerid][Level]  = dini_Int(file,"Level");
Account[playerid][Kills]  = dini_Int(file,"Kills");
Account[playerid][Deaths] = dini_Int(file,"Deaths");
Account[playerid][hours] = dini_Int(file,"Hours");
Account[playerid][mins] = dini_Int(file,"Minutes");
Account[playerid][secs] = dini_Int(file,"Seconds");

SetPlayerScore(playerid, dini_Int(file, "Score"));
GivePlayerMoney(playerid, dini_Int(file, "Cash"));

TogglePlayerControllable(playerid,true);
Account[playerid][Muted] = 0;
Account[playerid][Logged] = true;
new ARank[128];

if(Account[playerid][Level] > 0)
{
switch(Account[playerid][Level])
{
case 1: ARank = "Moderator";
case 2: ARank = "Master Moderator";
case 3: ARank = "Admin";
case 4: ARank = "Master Admin";
case 5: ARank = "Server Owner";
}
format(str,128,"*-* You have been Automatically Logged in - Level: %d - %s *-*",Account[playerid][Level],ARank);
SendClientMessage(playerid,COLOR_LBLUE,str);
}
else
{
format(str,128,"*-* You have been Automatically Logged in *-*");
SendClientMessage(playerid,COLOR_LBLUE,str);
}
}
//----------------------------------------------------------------------------//
public CheckPing(playerid)
{
if(ServerInfo[MaxPing] == 1)
{
if(GetPlayerPing(playerid) > MAX_PING)
{
new string[128],playername[MAX_PLAYER_NAME];
GetPlayerName(playerid,playername,sizeof(playername));
format(string,sizeof(string),"{F81414}SYSTEM: {FFFFFF}%s was kicked. Reason: Ping Over The Limit of:[%d] [Player ping is: %d].",playername,MAX_PING,GetPlayerPing(playerid));
SendClientMessageToAll(Red,string);
Kick(playerid);
}
}
}
//----------------------------------------------------------------------------//
public AntiCheat()
{
for(new i=0; i<MAX_PLAYERS; i++)
{
if(GetPlayerSpecialAction(i) == 2 && !IsPlayerAdmin(i) && Account[i][Level] < 4)
{
BanPlayer(i,"Jetpack");
return 1;
}

#if EnableMiniGun == false
if(GetPlayerWeapon(i) == WEAPON_MINIGUN && !IsPlayerAdmin(i) && Account[i][Level] < 1)
{
BanPlayer(i,"Weapon Hack: MiniGun");
return 1;
}
#endif
#if EnableRocketLauncher == false
if(GetPlayerWeapon(i) == WEAPON_ROCKETLAUNCHER && !IsPlayerAdmin(i) && Account[i][Level] < 1)
{
BanPlayer(i,"Weapon Hack: RocketLauncher");
return 1;
}
#endif
#if EnableHeatSeeker == false
if(GetPlayerWeapon(i) == WEAPON_HEATSEEKER && !IsPlayerAdmin(i) && Account[i][Level] < 1)
{
BanPlayer(i,"Weapon Hack: HeatSeeker");
return 1;
}
#endif
#if EnableFlameThrower == false
if(GetPlayerWeapon(i) == WEAPON_FLAMETHROWER && !IsPlayerAdmin(i) && Account[i][Level] < 1)
{
BanPlayer(i,"Weapon Hack: FlameThrower");
return 1;
}
#endif
#if EnableRifle == false
if(GetPlayerWeapon(i) == WEAPON_RIFLE && !IsPlayerAdmin(i) && Account[i][Level] < 1)
{
BanPlayer(i,"Weapon Hack: Rifle");
return 1;
}
#endif
}
return 1;
}
//----------------------------------------------------------------------------//
public OnRconLoginAttempt(ip[], password[], success)
{
	if(success)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
  			if(IsPlayerConnected(i))
  			{
  			    new pIP[128];
				GetPlayerIp(i, pIP, 16);
				if(!strcmp(pIP,ip,true))
				{
					new string[128];
					format(string,sizeof(string),"{FFFFFF}This server uses a system of two Rcon passwords. \n\nFor access the account, you must enter the second password Rcon.");
					ShowPlayerDialog(i, DIALOG_TYPE_RCON2, DIALOG_STYLE_INPUT,"{6EF83C}Zero Admin Rcon!",string, "Enter", "Exit");
				}
			}
		}
		}
}
//----------------------------------------------------------------------------//
public BanPlayer(playerid,const reason[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
	    format(string,sizeof(string),"{F81414}SYSTEM: {FFFFFF}%s Baned. Reason: %s.",GetName(playerid), reason);
		SendClientMessageToAll(Red,string);
		new file[256];
		format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",GetName(playerid));
    	dini_IntSet(file,"Banned",1);
		print(string);
		SaveLogs("BanLog",string);
		BanEx(playerid,reason);
	}
	return 1;
}
//----------------------------------------------------------------------------//
public KickPlayer(playerid,const reason[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
	    format(string,sizeof(string),"{F81414}SYSTEM: {FFFFFF}%s Kicked. Reason: %s.",GetName(playerid), reason);
		SendClientMessageToAll(Red,string);
		SaveLogs("KickLog",string);
		print(string);
		Kick(playerid);
	}
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
   	if(GetPVarInt(playerid, "skinc_active") == 0) return 0;

	// Handle: They cancelled (with ESC)
	if(clickedid == Text:INVALID_TEXT_DRAW) {
        DestroySkinSelectionMenu(playerid);
        SetPVarInt(playerid, "skinc_active", 0);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        return 1;
	}

	return 0;
}
//---------------------------------------------------------------------------//
public Desktop_Function(playerid)
{
#if AntiPause == true
if(Desktop_Check[playerid] > 0) { Desktop_Status[playerid] = 0; }
if(Desktop_Check[playerid] <= 0) { Desktop_Status[playerid] +=1; }
Desktop_Check[playerid] = 0;
if(Desktop_Status[playerid] >= MAX_DESKTOP_TIME)
{
new string[128];
format(string,sizeof(string),"being idle for %d minutes.",MAX_DESKTOP_TIME/60);
KickPlayer(playerid,string);
}
#endif
return 1;
}
//---------------------------------------------------------------------------//
public Duel(player1, player2)
{
	if(counttime[player1]==6) {
		GameTextForPlayer(player1,"~g~Duel Starting",1000,6); GameTextForPlayer(player2,"~g~Duel Starting",1000,6);
	}

	counttime[player1]--;
	if(counttime[player1]==0)
	{
		TogglePlayerControllable(player1,1); TogglePlayerControllable(player2,1);
		GameTextForPlayer(player1,"~g~GO~ r~!",1000,6); GameTextForPlayer(player2,"~g~GO~ r~!",1000,6);
		return 0;
	}
	else
	{
		new text[7]; format(text,sizeof(text),"~w~%d",counttime[player1]);
		PlayerPlaySound(player1, 1056, 0.0, 0.0, 0.0); PlayerPlaySound(player2, 1056, 0.0, 0.0, 0.0);
		TogglePlayerControllable(player1,0); TogglePlayerControllable(player2,0);
		GameTextForPlayer(player1,text,1000,6); GameTextForPlayer(player2,text,1000,6);
	}

	SetTimerEx("Duel",1000,0,"dd", player1, player2);
	return 0;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "skinc_active") == 0) return 0;

	new curpage = GetPVarInt(playerid, "skinc_page");

	// Handle: next button
	if(playertextid == gNextSkinButtonTextDrawId[playerid]) {
	    if(curpage < (GetNumberOfSkinPages() - 1)) {
	        SetPVarInt(playerid, "skinc_page", curpage + 1);
	        ShowPlayerSkinModelPreviews(playerid);
         	UpdateSkinPageTextDraw(playerid);
         	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}

	// Handle: previous button
	if(playertextid == gPrevSkinButtonTextDrawId[playerid]) {
	    if(curpage > 0) {
	    	SetPVarInt(playerid, "skinc_page", curpage - 1);
	    	ShowPlayerSkinModelPreviews(playerid);
	    	UpdateSkinPageTextDraw(playerid);
	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}

	// Search in the array of textdraws used for the items
	new x=0;
	while(x != SELECTION_SKIN_ITEMS) {
	    if(playertextid == gSelectionSkinItems[playerid][x]) {
	        HandlePlayerSkinItemSelection(playerid, x);
	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	        DestroySkinSelectionMenu(playerid);
	        CancelSelectTextDraw(playerid);
        	SetPVarInt(playerid, "skinc_active", 0);
        	return 1;
		}
		x++;
	}

	return 0;
}

//---------------------------------------------------------------------------//
public Unjail(playerid)
{
TogglePlayerControllable(playerid,true);
SetPlayerInterior(playerid,0);
SpawnPlayer(playerid);
Account[playerid][Jailed] = 0;
KillTimer(timer);
return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerUpdate(playerid)
{
if(Caroff[playerid] == 1)
{
new veh = GetPlayerVehicleID(playerid);
new engine,lights,alarm,doors,bonnet,boot,objective;
GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(veh,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
}
if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY){
new keys,ud,lr;
GetPlayerKeys(playerid,keys,ud,lr);
if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
{MoveCamera(playerid);}
if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
{if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0){
StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
noclipdata[playerid][mode]      = 0;
noclipdata[playerid][accelmul]  = 0.0;
}else{
noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);
MoveCamera(playerid);}}
noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr;
return 0;}
#if AntiPause == true
if(Desktop_Timer_Started[playerid] == 0){
Desktop_Timer[playerid] = SetTimerEx("Desktop_Function",1000,1,"d",playerid);
Desktop_Timer_Started[playerid] = 1;}Desktop_Check[playerid] += 1;
#endif
return 1;
}
//----------------------------------------------------------------------------//
stock pName(playerid)
{
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}

//----------------------------------------------------------------------------//
stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, name, sizeof(name));
	}
	else
	{
	    name = "Unknown";
	}
	return name;
}
//----------------------------------------------------------------------------//
stock GetServerHostName(){new Str[256];GetServerVarAsString("hostname", Str, sizeof(Str));return Str;}
//----------------------------------------------------------------------------//
stock CheckFolders()
{
	if(!fexist("ZeroAdmin/"))
	{
    print("\n ERROR!");
    print("Folder 'ZeroAdmin' not localized!\n");
	return 1;
	}else{Filles++;}
	if(!fexist("ZeroAdmin/Logs/")){
    print("\n ERROR!");
    print("Folder 'Logs' not localized!\n");
    return 1;
    }else{Filles++;}
	if(!fexist("ZeroAdmin/Accounts/")){
    print("\n ERROR!");
    print("Folder 'Accounts' not localized!\n");
	return 1;
    }else{Filles++;}
    return printf("Folders Loaded			[%d]",Filles);
}
//----------------------------------------------------------------------------//
stock ServerInformtion()
{
printf("Max Warnigs: 			[%d]",MAX_WARNINGS);
printf("Max Reports: 			[%d]",MAX_REPORTS);
printf("Max Ping:    			[%d]",MAX_PING);
//----------------------------------------------------------------------------//
if(ServerInfo[Killing_Spree] == 1)print("Killing Spree: 			[Enabled]");
else print("Killing Spree: 			[Disabled]");
//----------------------------------------------------------------------------//
if(ServerInfo[AutoLogin] == 1)print("Auto Login: 			[Enabled]");
else print("Auto Login: 			[Disabled]");
//----------------------------------------------------------------------------//
if(ServerInfo[AdminTeleport] == 1)print("Admin Teleport: 		[Enabled]");
else print("Admin Teleport: 		[Disabled]");
//----------------------------------------------------------------------------//
print(">>>Weapons Enabled For Players:");
#if EnableMiniGun == true
print("Mini Gun: 			[Enabled]");
#else
print("Mini Gun: 			[Disabled]");
#endif
//----------------------------------------------------------------------------//
#if EnableHeatSeeker == true
print("Heat Seeker: 			[Enabled]");
#else
print("Heat Seeker: 			[Disabled]");
#endif
//----------------------------------------------------------------------------//
#if EnableRocketLauncher == true
print("Rocket Launcher: 		[Enabled]");
#else
print("Rocket Launcher: 		[Disabled]");
#endif
//----------------------------------------------------------------------------//
#if EnableRifle == true
print("Rifle: 				[Enabled]");
#else
print("Rifle: 				[Disabled]");
#endif
//----------------------------------------------------------------------------//
#if EnableFlameThrower == true
print("Flame Thrower: 			[Enabled]");
#else
print("Flame Thrower: 			[Disabled]");
#endif
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
}
//----------------------------------------------------------------------------//
public MessageToAdmins(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i) == 1)
	if(Account[i][Level] >= 1)
	SendClientMessage(i, color, string);
	}
	return 1;
}
//----------------------------------------------------------------------------//
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(ServerInfo[AdminTeleport] == 1)
	{
 	if(IsPlayerInAnyVehicle(playerid))
	{
    SetVehiclePos(GetPlayerVehicleID(playerid),fX, fY, fZ);
    }
	else
	{
	SetPlayerPos(playerid, fX, fY, fZ);
	}
	}
}
//----------------------------------------------------------------------------//
//---------------------------------COMMANDS-----------------------------------//
//----------------------------------------------------------------------------//
//==============================================================================
dcmd_stats(playerid,params[])
{
        #pragma unused params
		new string[256],str[256];
		new TargetID, h, m, s;
		
		if(!strlen(params)) TargetID = playerid;
		else TargetID = strval(params);
		
		TotalGameTime(TargetID, h, m, s);
 		format(string, sizeof(string),
		 "{6EF83C}Level: {FFFFFF}%d\n{6EF83C}Kills: {FFFFFF}%d\n{6EF83C}Deaths: {FFFFFF}%d\n{6EF83C}Score: {FFFFFF}%d\n{6EF83C}Money: {FFFFFF}$%d\n{6EF83C}Hours: {FFFFFF}%d\n{6EF83C}Min: {FFFFFF}%d\n{6EF83C}Sec: {FFFFFF}%d", Account[TargetID][Level], Account[TargetID][Kills], Account[TargetID][Deaths], GetPlayerScore(TargetID), GetPlayerMoney(TargetID),h,m,s);
		format(str,sizeof(str),"{6EF83C}%s's {FFFFFF}Stats",pName(TargetID));
		return ShowPlayerDialog(playerid, 2002, DIALOG_STYLE_MSGBOX, str, string, "OK","");
}

dcmd_zcredits(playerid,params[])
{
	#pragma unused params
	new string[256];
	format(string,sizeof(string),"{6EF83C}	     Z.A.S\n\n{6EF83C}Zero Admin System %s\n\n{6EF83C}   Created by Zero_Cool\n",Version);
	return ShowPlayerDialog(playerid, 23, DIALOG_STYLE_MSGBOX, "{6EF83C}Credits", string, "OK","");
}

dcmd_changeskin(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 3 ) return SendClientMessage(playerid,COLOR_ERROR,"You need be level 3 to use this command!");
	DestroySkinSelectionMenu(playerid);
  	SetPVarInt(playerid, "skinc_active", 1);
  	CreateSkinSelectionMenu(playerid);
  	SelectTextDraw(playerid, 0xACCBF1FF);
	return 1;
}

dcmd_setname(playerid,params[])
{
		if(Account[playerid][Level] < 3 ) return SendClientMessage(playerid,COLOR_ERROR,"You need be level 3 to use this command!");
	    new Index;
	    new tmp[256];  tmp  = strtok(params,Index);
	    new tmp2[256]; tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return
		SendClientMessage(playerid,COLOR_ERROR , "{6EF83C}Usage:{FFFFFF} /setname [Playerid] [NewName]");
		new TargetID = strval(tmp);
		new length = strlen(tmp2);
		new string[256];
		if(length < 3 || length > MAX_PLAYER_NAME) return SendClientMessage(playerid,Red,"ERROR: Incorrect Name Length");
		if(Account[TargetID][Level] > 3)return SendClientMessage(playerid,Red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
        CmdToAdmins(playerid,"SetName");
		format(string, sizeof(string), "* You have set %s's Name to %s *", pName(TargetID), tmp2);
		SendClientMessage(playerid,COLOR_ERROR,string);
		if(TargetID != playerid)
		{
		format(string,sizeof(string),"* Administrator %s has set your Name to %s *", pName(playerid), tmp2);
		SendClientMessage(TargetID,COLOR_ERROR,string);
		}
		SetPlayerName(TargetID, tmp2);
		return 1;
}

dcmd_kill(playerid,params[])
{
		#pragma unused params
        SetPlayerHealth (playerid, 0.0);
		return 1;
}

dcmd_changepass(playerid,params[])
{
	if(Account[playerid][Logged] == false) return SendClientMessage(playerid,COLOR_ERROR, "ERROR: You must have an account to use this command");
		if(!strlen(params)) return
		SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /changepass [NewPassword]");
		if(strlen(params) < 4) return SendClientMessage(playerid,COLOR_ERROR,"ERROR:Incorrect password length!");
		new string[128];
		new file[128];
    	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",pName(playerid));
		dini_IntSet(file, "Password", encodepass(params));
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"* You have successfully changed your account Password to %s *",params);
		return SendClientMessage(playerid,COLOR_ERROR,string);
}

dcmd_setlevel(playerid,params[])
{
	new level,TargetID,file[256];
	new tmp[256], tmp2[256], Index,str[50],str2[50];
	tmp = strtok(params,Index), tmp2 = strtok(params,Index),TargetID = strval(tmp),level = strval(tmp2);
	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",GetName(TargetID));
	
	if(Account[playerid][Level] < 5 && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid,COLOR_ERROR,"* You need be level 5 to use this command!");

	if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setlevel [playerid] [level]");

	if(level > 5 ) return SendClientMessage(playerid,COLOR_ERROR,"Incorrect Level");

	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");

	Account[TargetID][Level] = level;
	
	dini_IntSet(file,"Level",level);
	format(str,sizeof(str),"* You have set %s's level to %d *",GetName(TargetID),level);
	SendClientMessage(playerid,COLOR_ERROR,str);
	format(str2,sizeof(str2),"* Admin %s has made you level %d *",GetName(playerid),level);
	SendClientMessage(TargetID,COLOR_ERROR,str2);
	new string[256];
	format(string,sizeof(string),"* Admin %s has made %s Level %d *",GetName(playerid),GetName(TargetID),level);
	
	SaveLogs("SetLevelLog",string);
	print(string);
	return 1;
}

dcmd_kick(playerid,params[])
{
	new TargetID, PlayerName[MAX_PLAYER_NAME],on[MAX_PLAYER_NAME];
	new tmp[256],tmp2[256], Index, str[256];
	
	tmp = strtok(params,Index);
	tmp2 = strtok(params,Index);
	
	TargetID = strval(tmp);
	
	GetPlayerName(TargetID,on,sizeof(on));
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	
	if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /kick [playerid] [reason]");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot kick yourself");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot kick Admin!");
	CmdToAdmins(playerid,"Kick");
	format(str,sizeof(str),"* Admin %s has kicked %s [Reason: %s] *",PlayerName,on,params[2]);
	
 	SaveLogs("KickLog",str);
	print(str);
	SendClientMessageToAll(COLOR_ERROR,str);
	Kick(TargetID);
	return 1;
}

dcmd_ban(playerid,params[])
{
	new TargetID, PlayerName[MAX_PLAYER_NAME],on[MAX_PLAYER_NAME];
	new tmp[256],tmp2[256], Index, string[256];
	tmp = strtok(params,Index);
	tmp2 = strtok(params,Index);
	TargetID = strval(tmp);
	GetPlayerName(TargetID,on,sizeof(on));
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /ban [playerid] [reason]");
	if(!strlen(tmp2))
	return SendClientMessage(playerid, COLOR_ERROR, "ERROR: Reason unspecified!");
	if(TargetID == playerid) return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot ban yourself");
	if(!IsPlayerConnected(TargetID)) return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot ban Admin!");
	CmdToAdmins(playerid,"Ban");
	format(string,sizeof(string),"* Admin %s has banned %s [Reason: %s] *",PlayerName,on,params[2]);
	SendClientMessageToAll(COLOR_ERROR,string);
	new file[256];
	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",GetName(TargetID));
    dini_IntSet(file,"Banned",1);
    SaveLogs("BanLog",string);
	print(string);
	BanEx(TargetID, string);
	return 1;
}

dcmd_unban(playerid,params[])
{
	new tmp[256], Index, file[256];
	tmp = strtok(params,Index);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(!strlen(tmp)) return
	SendClientMessage(playerid,COLOR_ERROR , "{6EF83C}Usage:{FFFFFF} /unban [Player Name]");
	format(file,sizeof(file),"ZeroAdmin/Zero_Info.ini");

	new ip[256],string[256];
	ip = dini_Get(file,tmp);
	format(string,256,"unbanip %s",ip);
	SendRconCommand(string);
	return 1;
}

dcmd_say(playerid,params[])
{
	new string[128];
	new tmp[256], Index;
	tmp = strtok(params,Index);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(params)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /say [text]");
	format(string, sizeof(string), "*Admin* %s: %s", GetName(playerid), params[0]);
	SaveLogs("SayLog",string); print(string);
	return SendClientMessageToAll(COLOR_ERROR,string);
}

dcmd_ann(playerid,params[])
{
	new string[256];
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	if(!strlen(params)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /ann [text]");
	format(string, sizeof(string), "%s", params[0]);
	return GameTextForAll(string,4000,5);
}

dcmd_jail(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /jail [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Jailed] == 1) return SendClientMessage(playerid,COLOR_ERROR,"Player is jailed already");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot jailed yourself");
	
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot jailed Admin!");
	CmdToAdmins(playerid,"Jail");
	TogglePlayerControllable(TargetID,false);
	SetPlayerInterior(TargetID,6);
	SetPlayerPos(TargetID,264.0946,77.6202,1001.0391);
	ResetPlayerWeapons(TargetID);
	SetCameraBehindPlayer(TargetID);
	Account[TargetID][Jailed] = 1;
	timer = SetTimerEx("Unjail", 120000, 0, "i", TargetID);
	format(string,sizeof(string),"* Admin %s has jailed player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(Red,string);
	return 1;
}

dcmd_unjail(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /unjail [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Jailed] == 0) return SendClientMessage(playerid,COLOR_ERROR,"Player is not in jail!");
	TogglePlayerControllable(TargetID,true);
	SetPlayerInterior(TargetID,0);
	SpawnPlayer(TargetID);
	Account[TargetID][Jailed] = 0;
	KillTimer(timer);
	format(string,sizeof(string),"* Admin %s has unjailed player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(Red,string);
	return 1;
}

dcmd_freeze(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /freeze [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Frozen] == 1) return SendClientMessage(playerid,COLOR_ERROR,"Player is frozen already");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot freeze yourself");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot freeze Admin!");
	CmdToAdmins(playerid,"Freeze");
	TogglePlayerControllable(TargetID,false);
	SetCameraBehindPlayer(TargetID);
	Account[TargetID][Frozen] = 1;
	format(string,sizeof(string),"* Admin %s has freezed player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(Red,string);
	return 1;
}

dcmd_unfreeze(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /unfreeze [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Frozen] == 0) return SendClientMessage(playerid,COLOR_ERROR,"Player is not frozen");
	TogglePlayerControllable(TargetID,true);
	Account[TargetID][Frozen] = 1;
	format(string,sizeof(string),"* Admin %s has unfreeze player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(Red,string);
	return 1;
}

dcmd_slap(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256],Float:health;
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /slap [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot slap yourself");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot slap Admin!");
	CmdToAdmins(playerid,"Slap");
	GetPlayerHealth(TargetID, health);
	SetPlayerHealth(TargetID, health-25);
	format(string,sizeof(string),"* Admin %s has slapped player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(COLOR_ERROR,string);
	return 1;
}

dcmd_drop(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /drop [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot drop yourself");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot drop Admin!");
	CmdToAdmins(playerid,"Drop");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(TargetID, x, y, z);
	SetPlayerPos(TargetID, x, y, z+20);
	format(string,sizeof(string),"* You have dropped player %s from 20 feet. *",GetName(TargetID));
	SendClientMessage(playerid,COLOR_ERROR,string);
	return 1;
}

dcmd_explode(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /explode [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot explode yourself");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot explode Admin!");
	CmdToAdmins(playerid,"Explode");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(TargetID,x, y, z);
	CreateExplosion(x, y , z, 7,10.0);
	format(string,sizeof(string),"* You have exploded player %s! *",GetName(TargetID));
	SendClientMessage(playerid,COLOR_ERROR,string);
	return 1;
}

dcmd_killplayer(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /killplayer [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot kill Admin!");
	CmdToAdmins(playerid,"KillPlayer");
	SetPlayerHealth(TargetID, 0);
	format(string,sizeof(string),"* Admin %s has killed player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(COLOR_ERROR,string);
	return 1;
}

dcmd_godmode(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	CmdToAdmins(playerid,"GodMode");
	if (AutoGm[playerid] == 0)
	{
	AutoGm[playerid] = 1;
	SendClientMessage(playerid, COLOR_GREEN, "GodMode On");
	TimeGm[playerid] = SetTimerEx("GmTime",100,true,"i",playerid);
	return 1;
	}
	else if (AutoGm[playerid] == 1)
	{
	AutoGm[playerid] = 0;
	SendClientMessage(playerid, Red, "GodMode Off");
 	KillTimer(TimeGm[playerid]);
	SetPlayerHealth(playerid,100);
	return 1;
	}
	return 1;
}

dcmd_mute(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /mute [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Muted] == 1) return SendClientMessage(playerid,COLOR_ERROR,"Player is muted already");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot mute yourself");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot mute Admin!");
	CmdToAdmins(playerid,"Mute");
	Account[playerid][Muted] = 1;
	format(string,sizeof(string),"* Admin %s has muted player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(Red,string);
	return 1;
}

dcmd_unmute(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /unmute [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Muted] == 0) return SendClientMessage(playerid,COLOR_ERROR,"Player is not muted");
	Account[playerid][Muted] = 0;
	format(string,sizeof(string),"* Admin %s has unmuted player %s! *",GetName(playerid),GetName(TargetID));
	SendClientMessageToAll(Red,string);
	return 1;
}
dcmd_fu(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /fu [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot rape yourself");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot rape Admin!");
	CmdToAdmins(playerid,"Fu");
	SetPlayerHealth(TargetID,1);
    SetPlayerArmour(TargetID,1);
    SetPlayerDrunkLevel(TargetID,3000);
	SetPlayerWantedLevel(TargetID, 6);
	SetPlayerSkin(TargetID, 85);
	SetPlayerColor(TargetID,COLOR_WHITE);
	format(string,sizeof(string),"* RAPE TIME: %s has been rapped! *",GetName(TargetID));
	SendClientMessageToAll(Red,string);
	return 1;
}

dcmd_megajump(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	CmdToAdmins(playerid,"MegaJump");
	if (MegaJump[playerid] == 1)
	{
	MegaJump[playerid] = 0;
	SendClientMessage(playerid, COLOR_GREEN, "MegaJump Off");
	return 1;
	}
	else if (MegaJump[playerid] == 0)
	{
	MegaJump[playerid] = 1;
	SendClientMessage(playerid, Red, "MegaJump On");
	return 1;
	}
	return 1;
}

dcmd_jetpack(playerid,params[])
{
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"Jetpack");
	if(!strlen(params)) return SetPlayerSpecialAction(playerid, 2);
	new TargetID;
	new tmp[256], Index;
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	SetPlayerSpecialAction(TargetID, 2);
	SendClientMessage(TargetID,Red,"* Admin give you a jetpack! *");
	return 1;
}

dcmd_kickall(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 5) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 5 to use this command!");
    for(new i = 0; i < MAX_PLAYERS; i++) {if(IsPlayerConnected(i) && (i != playerid)) {Kick(i);}}
	return 1;
}

dcmd_healall(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"HealAll");
	for(new i = 0; i < MAX_PLAYERS; i++) {if(IsPlayerConnected(i)) {PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,100.0);}}
	GameTextForAll("~g~~h~health",4000,3);
	new string[128]; format(string,sizeof(string),"* Admin %s has healed all players *",GetName(playerid));
	return SendClientMessageToAll(COLOR_GREEN, string);
}

dcmd_armourall(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"ArmourAll");
	for(new i = 0; i < MAX_PLAYERS; i++) {if(IsPlayerConnected(i)) {PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerArmour(i,100.0);}}
	GameTextForAll("~g~~h~armour",4000,3);
	new string[128]; format(string,sizeof(string),"* Admin %s has give Armour to all players *", GetName(playerid) );
	return SendClientMessageToAll(COLOR_GREEN, string);
}
dcmd_killall(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"KillAll");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){SetPlayerHealth(i,0.0);}}
	new string[128];
	format(string,sizeof(string),"* Administrator %s has Killed all players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_aka(playerid,params[])
{
    if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	    if(!strlen(params)) return
		SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /aka [PlayerID]");
    	new TargetID, playername[MAX_PLAYER_NAME], str[128], IP[50];
		TargetID = strval(params);
	 	if(IsPlayerConnected(TargetID))
		 {
  		  	GetPlayerIp(TargetID,IP,50);
  		  	new str2[128];
			GetPlayerName(TargetID, playername, sizeof(playername));
			format(str2,sizeof(str),"{6EF83C}%s(%d) {FFFFFF}AKA ",playername,TargetID);
		    format(str,sizeof(str),"{FFFFFF}Ip: {6EF83C}%s \n{FFFFFF}Names: {6EF83C}%s", IP, dini_Get("ZeroAdmin/aka.txt",IP));
	        return ShowPlayerDialog(playerid, 123, DIALOG_STYLE_MSGBOX, str2, str, "Ok", "");
		}
		else return SendClientMessage(playerid, Red, "Player is not connected");
}
dcmd_explodeall(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"ExplodeAll");
	new Float:x, Float:y, Float:z;
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){GetPlayerPos(i,x,y,z);CreateExplosion(x,y,z,7,10.0);}}
	new string[128]; format(string,sizeof(string),"* Administrator %s has Exploded all players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_setallwanted(playerid,params[])
{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(!strlen(params)) return
 	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setallwanted [WantedLevel]");
	new var = strval(params), string[128];
	CmdToAdmins(playerid,"SetAllWanted");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i)){SetPlayerWantedLevel(i,var);}}
	format(string,sizeof(string),"* Administrator %s has set all players wanted level to %d *", pName(playerid), var);
	return SendClientMessageToAll(COLOR_ERROR, string);

}

dcmd_setallskin(playerid,params[])
{
 	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(!strlen(params)) return
 	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setallskin [SkinID]");
	new var = strval(params), string[128];
	if(!IsValidSkin(var)) return SendClientMessage(playerid, Red, "ERROR: Invaild Skin ID");
	CmdToAdmins(playerid,"SetAllSkin");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i)){SetPlayerSkin(i,var);}}
	format(string,sizeof(string),"* Administrator %s has set all players Skin to %d *", pName(playerid), var );
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_setallweather(playerid,params[])
{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(!strlen(params)) return
 	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setallweather [WeatherID]");
	new var = strval(params), string[128];
	CmdToAdmins(playerid,"SetAllWeather");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i)){SetPlayerWeather(i, var);}}
	format(string,sizeof(string),"* Administrator %s has set all players Weather to %d *", pName(playerid), var );
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_disarmall(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"DisarmAll");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){ResetPlayerWeapons(i);}}
	new string[128];
	format(string,sizeof(string),"* Administrator %s has Disarmed all Players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_ejectall(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"EjectAll");
 	new Float:x, Float:y, Float:z;
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){if(IsPlayerInAnyVehicle(i)){GetPlayerPos(i,x,y,z);SetPlayerPos(i,x,y,z+3);}}}
	new string[128];
	format(string,sizeof(string),"* Administrator %s has Ejected all Players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_setallcash(playerid,params[])
{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(!strlen(params)) return
  	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setallcash [Value]");
	new var = strval(params), string[128];
	CmdToAdmins(playerid,"SetAllCash");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i)){ResetPlayerMoney(i);GivePlayerMoney(i,var);}}
	format(string,sizeof(string),"* Administrator %s has set all Players Cash to $%d *", pName(playerid), var );
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_setallscore(playerid,params[])
{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(!strlen(params)) return
  	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setallscore [Score]");
	new var = strval(params), string[128];
	CmdToAdmins(playerid,"SetAllScore");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i)){SetPlayerScore(i,var);}}
	format(string,sizeof(string),"* Administrator %s has set all Players Scores to %d *",pName(playerid),var);
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_getall(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"GetAll");
	new Float:x,Float:y,Float:z, interior = GetPlayerInterior(playerid);
	GetPlayerPos(playerid,x,y,z);
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){SetPlayerPos(i,x+(playerid/4)+1,y+(playerid/4),z);SetPlayerInterior(i,interior);}}
	new string[128];
	format(string,sizeof(string),"* Administrator %s has Teleported all players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_muteall(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"MuteAll");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){Account[i][Muted] = 1;}}
	new string[128];
	format(string,sizeof(string),"* Administrator %s has Muted all players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_unmuteall(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"UnmuteAll");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){Account[i][Muted] = 0;}}
	new string[128];
	format(string,sizeof(string),"* Administrator %s has Unmuted all players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_spawnall(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	CmdToAdmins(playerid,"SpawnAll");
	for(new i = 0; i < MAX_PLAYERS; i++){if(IsPlayerConnected(i) && (i != playerid)){SetPlayerPos(i, 0.0, 0.0, 0.0); SpawnPlayer(i);}}
	new string[128];
	format(string,sizeof(string),"* Administrator %s has Spawned all players *", pName(playerid));
	return SendClientMessageToAll(COLOR_ERROR, string);
}
dcmd_eject(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /eject [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot eject Admin!");
	CmdToAdmins(playerid,"Eject");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(TargetID, x, y, z);
	SetPlayerPos(TargetID, x, y, z+3);
	format(string,sizeof(string),"* You have ejected player %s from his vehicle. *",GetName(TargetID));
	SendClientMessage(playerid,COLOR_ERROR,string);
	return 1;
}

dcmd_disarm(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /disarm [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(TargetID == playerid)return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot disarm yourself");
	if(Account[TargetID][Level] > 3) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: You cannot disarm Admin!");
	CmdToAdmins(playerid,"Disarm");
	ResetPlayerWeapons(TargetID);
	format(string,sizeof(string),"* You have disarmed player %s *",GetName(TargetID));
	SendClientMessage(playerid,COLOR_ERROR,string);
	return 1;
}

dcmd_ip(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /ip [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
   	GetPlayerIp(TargetID,tmp,50);
	format(string,sizeof(string),"* IP From Player %s is %s *", GetName(TargetID), tmp);
	SendClientMessage(playerid,COLOR_ERROR,string);
	return 1;
}

dcmd_fakechat(playerid,params[])
{
    if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	new tmp[256], tmp2[256], Index;
	tmp = strtok(params,Index);
	tmp2 = strtok(params,Index);
	if(!strlen(tmp) || !strlen(tmp2)) return
	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /fakechat [playerid] [Message]");
	new TargetID = strval(tmp);
	if(Account[TargetID][Level] > 3)
	return SendClientMessage(playerid,Red,"ERROR: You cannot use this command on this admin");
	CmdToAdmins(playerid,"FakeChat");
	if(IsPlayerConnected(TargetID) && TargetID != INVALID_PLAYER_ID)
	{
		SendPlayerMessageToAll(TargetID, params[strlen(tmp)+1]);
		return SendClientMessage(playerid,Red,"* Fake message sent! *");
	}
	else return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
}

dcmd_goto(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /goto [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	CmdToAdmins(playerid,"Goto");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(TargetID, x, y, z);
	SetPlayerPos(playerid, x, y, z+1);
	format(string,sizeof(string),"* You been teleported to %s *",GetName(TargetID));
	SendClientMessage(playerid,COLOR_ERROR,string);
	return 1;
}

dcmd_gethere(playerid,params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /gethere [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	CmdToAdmins(playerid,"GetHere");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(TargetID, x, y, z+1);
	format(string,sizeof(string),"* You teleported %s to you. *",GetName(TargetID));
	SendClientMessage(playerid,COLOR_ERROR,string);
	return 1;
}

dcmd_level(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 1) return  SendClientMessage(playerid,COLOR_ERROR,"ERROR: You are not a high enough level to use this command");
 	if(!strlen(params))return SendClientMessage(playerid,COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /level [1/2/3/4/5]");
	new DialogText[1024];
	new LevelText[256];
	if(strcmp(params,"1",true) == 0)
	{
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	strcat(DialogText,"{00FF00}[1]{0094FF} /ip\n");
	strcat(DialogText,"{00FF00}[2]{0094FF} /reports\n");
	strcat(DialogText,"{00FF00}[3]{0094FF} /say\n");
	strcat(DialogText,"{00FF00}[4]{0094FF} /jail\n");
	strcat(DialogText,"{00FF00}[5]{0094FF} /unjail\n");
	strcat(DialogText,"{00FF00}[6]{0094FF} /freeze\n");
	strcat(DialogText,"{00FF00}[7]{0094FF} /unfreeze\n");
	strcat(DialogText,"{00FF00}[8]{0094FF} /slap\n");
	strcat(DialogText,"{00FF00}[9]{0094FF} /repair\n");
	strcat(DialogText,"{00FF00}[10]{0094FF} /mute\n");
	strcat(DialogText,"{00FF00}[11]{0094FF} /unmute\n");
	strcat(DialogText,"{00FF00}[12]{0094FF} /cc\n");
 	format(LevelText,sizeof(LevelText),""COL_GREEN"Moderator "COL_WHITE"[Level 1]");
	}
	if(strcmp(params,"2",true) == 0)
	{
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	strcat(DialogText,"{00FF00}[1]{0094FF} /kick \n");
	strcat(DialogText,"{00FF00}[2]{0094FF} /ann - (Announce) \n");
	strcat(DialogText,"{00FF00}[3]{0094FF} /drop \n");
	strcat(DialogText,"{00FF00}[4]{0094FF} /godmode \n");
	strcat(DialogText,"{00FF00}[5]{0094FF} /megajump \n");
	strcat(DialogText,"{00FF00}[6]{0094FF} /eject \n");
	strcat(DialogText,"{00FF00}[7]{0094FF} /spawn \n");
	strcat(DialogText,"{00FF00}[8]{0094FF} /fix \n");
	strcat(DialogText,"{00FF00}[9]{0094FF} /zspec \n");
	strcat(DialogText,"{00FF00}[10]{0094FF} /specoff \n");
	strcat(DialogText,"{00FF00}[11]{0094FF} /warn \n");
	strcat(DialogText,"{00FF00}[12]{0094FF} /zcam \n");
	strcat(DialogText,"{00FF00}[13]{0094FF} /flip \n");
	strcat(DialogText,"{00FF00}[14]{0094FF} /laston \n");
	strcat(DialogText,"{00FF00}[15]{0094FF} /addnos \n");
	strcat(DialogText,"{00FF00}[16]{0094FF} /highlights \n");
	strcat(DialogText,"{00FF00}[17]{0094FF} /clearchat \n");
	strcat(DialogText,"{00FF00}[18]{0094FF} /getcord - (Get Cordinates) \n");
    format(LevelText,sizeof(LevelText),""COL_GREEN"Master Moderator "COL_WHITE"[Level 2]");
	}
	if(strcmp(params,"3",true) == 0)
	{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	strcat(DialogText,"{00FF00}[1]{0094FF} /goto \n");
	strcat(DialogText,"{00FF00}[2]{0094FF} /gethere \n");
	strcat(DialogText,"{00FF00}[3]{0094FF} /fu \n");
	strcat(DialogText,"{00FF00}[4]{0094FF} /killplayer \n");
	strcat(DialogText,"{00FF00}[5]{0094FF} /explode \n");
	strcat(DialogText,"{00FF00}[6]{0094FF} /ban \n");
	strcat(DialogText,"{00FF00}[7]{0094FF} /unban \n");
	strcat(DialogText,"{00FF00}[8]{0094FF} /sethealth \n");
	strcat(DialogText,"{00FF00}[9]{0094FF} /setarmour \n");
	strcat(DialogText,"{00FF00}[10]{0094FF} /givegun \n");
	strcat(DialogText,"{00FF00}[11]{0094FF} /engineoff \n");
	strcat(DialogText,"{00FF00}[12]{0094FF} /setname\n");
	strcat(DialogText,"{00FF00}[13]{0094FF} /zmenu\n");
	strcat(DialogText,"{00FF00}[14]{0094FF} /car \n");
	strcat(DialogText,"{00FF00}[15]{0094FF} /duel \n");
	strcat(DialogText,"{00FF00}[16]{0094FF} /force \n");
	strcat(DialogText,"{00FF00}[17]{0094FF} /aka \n");
	strcat(DialogText,"{00FF00}[18]{0094FF} /setcord - (Set Cordinates) \n");
	strcat(DialogText,"{00FF00}[19]{0094FF} /setgravity \n");
	strcat(DialogText,"{00FF00}[20]{0094FF} /setallcash \n");
	strcat(DialogText,"{00FF00}[21]{0094FF} /changeskin \n");
	strcat(DialogText,"{00FF00}[22]{0094FF} /setallskin \n");
	strcat(DialogText,"{00FF00}[23]{0094FF} /setallscore \n");
	strcat(DialogText,"{00FF00}[24]{0094FF} /setallwanted \n");
	strcat(DialogText,"{00FF00}[25]{0094FF} /setallweather \n");
    format(LevelText,sizeof(LevelText),""COL_GREEN"Admin "COL_WHITE"[Level 3]");
    }
	if(strcmp(params,"4",true) == 0)
	{
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	strcat(DialogText,"{00FF00}[1]{0094FF} /healall \n");
	strcat(DialogText,"{00FF00}[2]{0094FF} /armourall \n");
	strcat(DialogText,"{00FF00}[3]{0094FF} /jetpack \n");
	strcat(DialogText,"{00FF00}[4]{0094FF} /disarm \n");
	strcat(DialogText,"{00FF00}[5]{0094FF} /unbanip \n");
	strcat(DialogText,"{00FF00}[6]{0094FF} /fakechat \n");
	strcat(DialogText,"{00FF00}[7]{0094FF} /cmd \n");
	strcat(DialogText,"{00FF00}[8]{0094FF} /getall \n");
	strcat(DialogText,"{00FF00}[9]{0094FF} /killall \n");
	strcat(DialogText,"{00FF00}[10]{0094FF} /muteall \n");
	strcat(DialogText,"{00FF00}[11]{0094FF} /ejectall \n");
	strcat(DialogText,"{00FF00}[12]{0094FF} /spawnall \n");
	strcat(DialogText,"{00FF00}[13]{0094FF} /disarmall \n");
	strcat(DialogText,"{00FF00}[14]{0094FF} /unmuteall \n");
	strcat(DialogText,"{00FF00}[15]{0094FF} /explodeall \n");
	strcat(DialogText,"{00FF00}[16]{0094FF} /lockserver \n");
	strcat(DialogText,"{00FF00}[17]{0094FF} /unlockserver \n");
	strcat(DialogText,"{00FF00}[18]{0094FF} /ed - (Enable/Disable) \n");
    format(LevelText,sizeof(LevelText),""COL_GREEN"Master Admin "COL_WHITE"[Level 4]");
	}
	if(strcmp(params,"5",true) == 0)
	{
	if(Account[playerid][Level] < 5) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 5 to use this command!");
	strcat(DialogText,"{00FF00}[1]{0094FF} /setlevel \n");
	strcat(DialogText,"{00FF00}[2]{0094FF} /kickall \n");
	strcat(DialogText,"{00FF00}[3]{0094FF} /gmx \n");
	strcat(DialogText,"{00FF00}[4]{0094FF} /tempban \n");
	strcat(DialogText,"{00FF00}[5]{0094FF} /zconsole \n");
	strcat(DialogText,"{00FF00}[5]{0094FF} /object \n");
	strcat(DialogText,"{00FF00}[5]{0094FF} /delacc - (Delete Account) \n");
    format(LevelText,sizeof(LevelText),""COL_GREEN"Server Owner "COL_WHITE"[Level 5]");
	}
	ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX,LevelText, DialogText, "OK","");
	return 1;
}

dcmd_ed(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	new string[256];
	format(string, sizeof string,"Anti Spam\nAuto Login\nMax Ping\nKilling Spree\nAdminTeleport");
	ShowPlayerDialog(playerid,DIALOG_Enable/Disable, DIALOG_STYLE_LIST, "Enable/Disable", string, "Ok", "Cancle");
	return 1;
}

dcmd_clearchat(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	CmdToAdmins(playerid,"ClearChat");
	for(new i = 0; i < 50; i++)SendClientMessageToAll(COLOR_ERROR,"");
	return 1;
}

dcmd_gmx(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 5) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 5 to use this command!");
	new string[256];
	format(string,256,"* Admin %s Restart Server. *",pName(playerid));
	SaveLogs("GmxLogo",string);
	SendRconCommand("gmx");
	return 1;
}

dcmd_unbanip(playerid,params[])
{
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	if(!strlen(params)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /unbanip [ip]");
	new string[64];
	format(string,64,"unbanip %s",params);
	SendRconCommand(string);
	format(string,64,"* You have unbanned IP: %s *",params);
	SendClientMessage(playerid,Red,string);
	return 1;
}

dcmd_sethealth(playerid, params[])
{
	new TargetID;
	new tmp[256],tmp2[256], Index, string[256], health;
	tmp = strtok(params,Index);
	tmp2 = strtok(params,Index);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");

	if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /sethealth [playerid] [amount]");
 	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
 	CmdToAdmins(playerid,"SetHealth");
	TargetID = strval(tmp);
	health = strval(tmp2);
	SetPlayerHealth(TargetID, health);
	format(string, sizeof(string), "* You set %s's health to: %d *", GetName(TargetID), health);
	SendClientMessage(playerid, COLOR_ERROR, string);
	return 1;
}

dcmd_setarmour(playerid, params[])
{
	new TargetID;
	new tmp[256],tmp2[256], Index, string[256], armour;
	tmp = strtok(params,Index);
	tmp2 = strtok(params,Index);
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	
	if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setarmour [playerid] [amount]");
 	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
 	CmdToAdmins(playerid,"SetArmour");
	TargetID = strval(tmp);
	armour = strval(tmp2);
	SetPlayerArmour(TargetID, armour);
	format(string, sizeof(string), "* You set %s's armour to: %d *", GetName(TargetID), armour);
	SendClientMessage(playerid, COLOR_ERROR, string);
	return 1;
}

dcmd_spawn(playerid, params[])
{
	new TargetID;
	new tmp[256], Index, string[256];
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /spawn [playerid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
 	CmdToAdmins(playerid,"Spawn");
	SpawnPlayer(TargetID);
	format(string, sizeof(string), "* You forced player %s to re-spawn. *", GetName(TargetID));
	SendClientMessage(playerid, COLOR_ERROR, string);
	return 1;
}

dcmd_report(playerid, params[])
{
	new TargetID;
	new tmp[256], tmp2[256], Index, string[128];
	tmp = strtok(params,Index);
	tmp2 = strtok(params,Index);
	TargetID = strval(tmp);
	if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /report [playerid] [reason]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	SendClientMessage(playerid,COLOR_ERROR,"Your report has been sent to online admins!");
	format(string, sizeof(string), "%s(ID: %i) has reported %s(ID: %i) for %s", GetName(playerid),playerid, GetName(TargetID),TargetID,params[2]);
	SaveLogs("ReportLog",string);
	for(new i = 1;i < MAX_REPORTS-1; i++) Reports[i] = Reports[i+1];
	Reports[MAX_REPORTS-1] = string;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i) == 1) if (Account[i][Level] >= 1) SendClientMessage(i, Red, string);
	}
	return 1;
}

dcmd_givegun(playerid,params[])
{

	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	new weap, ammo, WeapName[32];	ammo = 150;
	new Index;
	new tmp[256];  tmp  = strtok(params,Index);
	new tmp2[256]; tmp2 = strtok(params,Index);
	new TargetID = strval(tmp);
	weap = strval(tmp2);
	if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /givgun [playerid] [wepid]");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if (weap > 0 && weap < 19 || weap > 21 && weap < 47)
	{
	GetWeaponName(weap,WeapName,32);
	GivePlayerWeapon(TargetID, weap, ammo);
	CmdToAdmins(playerid,"GiveGun");
	}
	else
	{
	SendClientMessage(playerid,COLOR_ERROR,"Invalid Weapon ID");
	return 1;
	}
	return 1;
}

dcmd_zspec(playerid,params[])
{
	new TargetID;
	new tmp[256], Index;
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	if(PlayerUseZcam[playerid] == 1) return SendClientMessage(playerid,COLOR_ERROR,"You cant use zspec!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /zspec [playerid]");
	if(TargetID == playerid)return SendClientMessage(playerid, Red, "ERROR: You cannot spec yourself");
	if(PlayerUseSpec[playerid] == 0)
	{
	TargetID = strval(tmp);
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	ZSpecActive(playerid,TargetID);
	PlayerUseSpec[playerid] = 1;
	}
	return 1;
}

dcmd_specoff(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	TogglePlayerSpectating(playerid, 0);
	gSpectateID[playerid] = INVALID_PLAYER_ID;
	gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
	TextDrawHideForPlayer(playerid,ZSpecTd[0]);
	TextDrawHideForPlayer(playerid,ZSpecTd[1]);
	TextDrawHideForPlayer(playerid,ZSpecTd[2]);
	TextDrawHideForPlayer(playerid,ZSpecTd[3]);
	PlayerUseSpec[playerid] = 0;
	return 1;
}

dcmd_fix(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "You are not in vehicle!");
	CmdToAdmins(playerid,"Fix");
   	RepairVehicle(GetPlayerVehicleID(playerid));
	return 1;
}

dcmd_pm(playerid,params[])
{
	new TargetID;
	new tmp[256], tmp2[256], Index, string[256];
	tmp = strtok(params,Index);
	tmp2 = strtok(params,Index);
	TargetID = strval(tmp);
	if(!strlen(tmp) || !strlen(tmp2))
	{
	    SendClientMessage(playerid,COLOR_ERROR,"{6EF83C}Usage:{FFFFFF} /pm [playerid] [Message]");
	    return 1;
	}
 	if(!IsPlayerConnected(TargetID))
	{
	    format(string, sizeof(string), "The Player ID (%d) is not connected to the server.",TargetID);
	    SendClientMessage(playerid,Red,string);
	    return 1;
    }
    if(playerid != TargetID)
    {
   	format(string, sizeof(string), "PM Sent to: %s(%d): %s",pName(TargetID),TargetID,params[1+strlen(tmp)]);
	SendClientMessage(playerid,COLOR_ERROR,string);

	format(string, sizeof(string), "PM From: %s(%d) %s",pName(playerid),playerid,params[1+strlen(tmp)]);
	SendClientMessage(TargetID,COLOR_ERROR,string);
	GameTextForPlayer(TargetID, "~y~~n~~n~~n~~n~~n~~n~Private Message", 4000, 5);
	}
	else
	{
	SendClientMessage(playerid,COLOR_ERROR,"You cannot PM yourself");
	}
	return 1;
}

dcmd_reports(playerid,params[])
{
   	#pragma unused params
   	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
    new ReportCount = 0;
    new string[1024];
    new fstring[1024];
	for(new i = 1; i < MAX_REPORTS; i++)
	{
	if(strcmp( Reports[i], "<none>", true) != 0)
	{
	ReportCount++;
	format(fstring, sizeof(fstring), "{FFFFFF}%s \n",Reports[i]);
	strcat(string, fstring);
	}
	}
	if(ReportCount == 0) return ShowPlayerDialog(playerid, 122, DIALOG_STYLE_MSGBOX, "{6EF83C}Reports", "{FFFFFF}There have been no reports", "Ok","");
	else
	{
	format(fstring, sizeof(fstring), "\r\n{6EF83C}Total Reports: {FFFFFF}%d", ReportCount);
 	strcat(string, fstring);
 	ShowPlayerDialog(playerid, 122, DIALOG_STYLE_MSGBOX, "{6EF83C}Reports", string, "Ok", "");
	}
	return 1;
}

dcmd_engineoff(playerid,params[])
{
	new TargetID;
	new tmp[256], Index;
	tmp = strtok(params,Index);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /engineoff [playerid]");
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	TargetID = strval(tmp);
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	if(!IsPlayerInAnyVehicle(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not in Vehicle!");
	CmdToAdmins(playerid,"EngineOff");
	Caroff[TargetID] = 1;
	return 1;
}

dcmd_cmd(playerid,params[])
{
	new TargetID;
	new tmp[256], Index;
	tmp = strtok(params,Index), TargetID = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /cmd [playerid]");
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
	CmdPlayer[playerid] = TargetID;
	ShowPlayerDialog(playerid,DIALOGID_ADMIN,DIALOG_STYLE_LIST,"{FF0000}Admin Commands.",
	"Stats\nKick\nBan\nSet Score\nGive Money\nGive Weapon\nTeleport him to me\nTeleport to him\nEject\nJail\nSlap\nDrop\nDisarm\nExplode\nKill\nRape","OK","Exit");
    CmdToAdmins(playerid,"Cmd");
	return 1;
}

dcmd_zcam(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(PlayerUseSpec[playerid] == 1) return SendClientMessage(playerid,COLOR_ERROR,"You cant use zcam!");
	if(GetPVarType(playerid, "FlyMode"))
	{
 	CancelFlyMode(playerid);
    PlayerUseZcam[playerid] = 0;
    }
	else
	{
	FlyMode(playerid);
	PlayerUseZcam[playerid] = 1;
	}
	return 1;
}

dcmd_zconsole(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 5) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 5 to use this command!");
	ShowPlayerDialog(playerid,DIALOGID_ZCONSOLE, DIALOG_STYLE_LIST, "Zero Admin Console",
	"Change Mode\nRestart (Gmx)\nLoad Filterscript\nUnload Filterscript\nReload Zero Admin\nUnban IP", "Select", "Cancel");
	return 1;
}

dcmd_zmenu(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	ShowPlayerDialog(playerid,DIALOGID_ZMENU, DIALOG_STYLE_LIST, "Zero Admin Menu",
	"Server Weather\nServer Time\nVehicles\nWeapons", "Select", "Cancel");
	return 1;
}
dcmd_flip(playerid,params[])
{
	new TargetID;
	new tmp[256], Index;
	tmp = strtok(params,Index);
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	TargetID = strlen(tmp);
	if(!IsPlayerConnected(TargetID))return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
 	if(IsPlayerInAnyVehicle(TargetID))
	{
	new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle;
	GetPlayerPos(TargetID, X, Y, Z);
	VehicleID = GetPlayerVehicleID(TargetID);
	GetVehicleZAngle(VehicleID, Angle);
	SetVehiclePos(VehicleID, X, Y, Z);
	SetVehicleZAngle(VehicleID, Angle);
	SetVehicleHealth(VehicleID,1000.0);
	CmdToAdmins(playerid,"Flip");
	return SendClientMessage(playerid, COLOR_ERROR,"* Vehicle Flipped! *");
	}
	return 1;
}
dcmd_warn(playerid,params[])
{
    	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	    new Index;
	    new tmp[256];  tmp  = strtok(params,Index);
		new tmp2[256]; tmp2 = strtok(params,Index);

	    if(!strlen(tmp) || !strlen(tmp2)) return
		SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /warn [Playerid] [Reason]");
    	new TargetID = strval(tmp);
		new str[128];
		if(Account[TargetID][Level] > 3)return SendClientMessage(playerid,Red,"ERROR: You cannot use this command on this admin");
		CmdToAdmins(playerid,"Warn");
	 	if(IsPlayerConnected(TargetID))
		 {
 	    	if(TargetID != playerid)
			 {
				Account[TargetID][Warnings]++;
				if( Account[TargetID][Warnings] == MAX_WARNINGS)
				{
				format(str, sizeof (str), "* Administrator %s has kicked %s. | Reason: %s (Warnings: %d/%d) *", pName(playerid), pName(TargetID), params[1+strlen(tmp)], Account[TargetID][Warnings], MAX_WARNINGS);
				SendClientMessageToAll(COLOR_ERROR, str);
				SaveLogs("KickLog",str);
				Kick(TargetID);
				return Account[TargetID][Warnings] = 0;
				}
				else
				{
				format(str, sizeof (str), "* Administrator %s has given %s a Warning.  Reason: %s (Warnings: %d/%d) *", pName(playerid), pName(TargetID), params[1+strlen(tmp)], Account[TargetID][Warnings], MAX_WARNINGS);
				return SendClientMessageToAll(COLOR_ERROR, str);
				}
			}
			else return SendClientMessage(playerid, COLOR_ERROR, "ERROR: You cannot warn yourself");
		}
		else return SendClientMessage(playerid,COLOR_ERROR,"Player is not connected!");
}
dcmd_duel(playerid,params[])
{
	    new Index;
 		new tmp[256];  tmp  = strtok(params,Index);
		new tmp2[256]; tmp2 = strtok(params,Index);
        if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	    if(!strlen(tmp) || !strlen(tmp2))
		{
		SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /duel [playerid 1] [playerid 2]");
		return 1;
		}

		new TargetID = strval(tmp);
		new TargetID2 = strval(tmp2);
		new string[128];

		if(IsPlayerConnected(TargetID))
		{
 		 	if(IsPlayerConnected(TargetID2))
			  {
				if(InDuel[TargetID] == 1) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: Player One is already in a Duel!");
				if(InDuel[TargetID2] == 1) return SendClientMessage(playerid,COLOR_ERROR,"ERROR: Player Two is already in a Duel!");

				SetPlayerInterior(TargetID,16);
				SetPlayerPos(TargetID,-1404.067,1270.3706,1042.8672);
				SetPlayerInterior(TargetID2,16);
				SetPlayerPos(TargetID2,-1395.067,1261.3706,1042.8672);

				InDuel[TargetID] = 1;
				InDuel[TargetID2] = 1;
				CmdToAdmins(playerid,"Duel");
				counttime[TargetID] = 6;
				SetTimerEx("Duel",1000,0,"dd", TargetID, TargetID2);
				format(string, sizeof(string), "* Administrator %s has started a duel Between %s and %s *",pName(playerid),pName(TargetID),pName(TargetID2));
				SendClientMessage(TargetID, COLOR_ERROR, string); SendClientMessage(TargetID2, COLOR_ERROR, string);
				return SendClientMessage(playerid, COLOR_ERROR, string);
 		 	}
			  else return SendClientMessage(playerid, COLOR_ERROR, "ERROR: Player Two is not connected");
		}
		else return SendClientMessage(playerid, COLOR_ERROR, "ERROR: Player One is not connected");
}
dcmd_car(playerid,params[])
{
		new Index;
	    new tmp[256];  tmp  = strtok(params,Index);
		new tmp2[256]; tmp2 = strtok(params,Index);
		new tmp3[256]; tmp3 = strtok(params,Index);
		if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	    if(!strlen(tmp)) return
		SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /car [ModelID/Name] [Colour1] [Colour2]");
		new car;
		new colour1, colour2;
   		if(!IsNumeric(tmp))
	 	car = GetVehicleModelIDFromName(tmp);
  		else car = strval(tmp);
		if(car < 400 || car > 611) return  SendClientMessage(playerid, Red, "ERROR: Invalid Vehicle Model ID!");
		if(!strlen(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);

		new VehicleID;
		new Float:X,Float:Y,Float:Z;
		new Float:Angle,int1;
		GetPlayerPos(playerid, X,Y,Z);
		GetPlayerFacingAngle(playerid,Angle);
		int1 = GetPlayerInterior(playerid);
		VehicleID = CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1);
		LinkVehicleToInterior(VehicleID,int1);
		CmdToAdmins(playerid,"Car");
		return 1;
}

dcmd_addnos(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
	if(IsPlayerInAnyVehicle(playerid))
	{
 		switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,Red,"ERROR: You can not tune this vehicle!");
		}
	        AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	        CmdToAdmins(playerid,"AddNos");
			return 1;
	}
	else return SendClientMessage(playerid,Red,"ERROR: You must be in a vehicle.");
}

dcmd_repair(playerid,params[])
{
	#pragma unused params
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if (IsPlayerInAnyVehicle(playerid))
	{
 		new VehicleID = GetPlayerVehicleID(playerid);
		RepairVehicle(VehicleID);
		CmdToAdmins(playerid,"Repair");
		return SetVehicleHealth(VehicleID, 1000);
	}
	else return SendClientMessage(playerid,Red,"ERROR: You must be in a vehicle.");
}

dcmd_resetstats(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Logged] == false) return SendClientMessage(playerid,COLOR_ERROR, "ERROR: You must have an account to use this command");

	 new file[256],PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,PlayerName,MAX_PLAYER_NAME);
	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",PlayerName);
		
	Account[playerid][Kills] = 0;
	Account[playerid][Deaths] = 0;
		
	dini_IntSet(file,"Kills",Account[playerid][Kills]);
	dini_IntSet(file,"Deaths",Account[playerid][Deaths]);
	   	
	return SendClientMessage(playerid,COLOR_ERROR,"* You have Successfully reset your Stats! *");
}

dcmd_laston(playerid,params[])
{
    if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");
    new TargetID;
    new playername[MAX_PLAYER_NAME];
	new adminname [MAX_PLAYER_NAME];
	new str[128];
	new file[256];
 	new tmp2[256];
	GetPlayerName(playerid, adminname, sizeof(adminname));
 	if(!strlen(params))
	{
	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",adminname);
	if(!fexist(file))return SendClientMessage(playerid, Red, "ERROR: File not found, Player is not registered!");
	if(dini_Int(file,"LastOn") ==0)
	{
		format(str, sizeof(str),"Never"); tmp2 = str;
	}
	else
	{
		tmp2 = dini_Get(file,"LastOn"); }
		format(str, sizeof(str),"Your last Time on Server was: %s",tmp2);
		return SendClientMessage(playerid, Red, str);
	}
		TargetID = strval(params);
		if(IsPlayerConnected(TargetID) && TargetID != INVALID_PLAYER_ID && TargetID != playerid)
		{
		CmdToAdmins(playerid,"Last On");
 		GetPlayerName(TargetID,playername,sizeof(playername));
		format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",playername);
		if(!fexist(file)) return SendClientMessage(playerid, Red, "ERROR: File not found, Player is not registered!");
		if(dini_Int(file,"LastOn") ==0){format(str, sizeof(str),"Never"); tmp2 = str;} else {tmp2 = dini_Get(file,"LastOn");}
		format(str, sizeof(str),"The last time of %s in server was: %s",playername,tmp2);
		return SendClientMessage(playerid, Red, str);
		}
	else return SendClientMessage(playerid,Red,"ERROR: Player is not connected or is yourself");
}

dcmd_highlight(playerid,params[])
{
    if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");

	if(!strlen(params)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /highlight [playerid]");
	new TargetID;
	new playername[MAX_PLAYER_NAME];
	new string[128];
 	TargetID = strval(params);
	if(Account[TargetID][pColour] >= 0){ Account[TargetID][pColour] = GetPlayerColor(TargetID);}
	if(IsPlayerConnected(TargetID) && TargetID != INVALID_PLAYER_ID)
 	{
 		GetPlayerName(TargetID, playername, sizeof(playername));
   		if(Account[TargetID][highlight] == 0)
	    {
			CmdToAdmins(playerid,"HighLight");
			Account[TargetID][highlight] = 1;
			HighlightTimer[TargetID] = SetTimerEx("HighLight", 500, 1, "i", TargetID);
			format(string,sizeof(string),"*You have Highlighted %s's marker*", playername);
			}
			else
			{
			KillTimer( HighlightTimer[TargetID]);
			Account[TargetID][highlight] = 0;
			SetPlayerColor(TargetID, Account[TargetID][pColour]);
			Account[TargetID][pColour] = 0;
			format(string,sizeof(string),"* You have Stopped Highlighting %s's marker *", playername);
			}
		return SendClientMessage(playerid,COLOR_ERROR,string);
	}
	else return SendClientMessage(playerid,Red,"ERROR: Player is not connected");
}

dcmd_setgravity(playerid,params[])
{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
 	if(!strlen(params) ||!(strval(params)<=50&&strval(params)>=-50)) return
	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setgravity [<-50.0 - 50.0->]");
 	CmdToAdmins(playerid,"SetGravity");
	new string[128],adminname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, adminname, sizeof(adminname));
	new Float:Gravity = floatstr(params);
	format(string,sizeof(string),"* Admnistrator %s has set the Server Gravity to %f *",adminname,Gravity);
	SetGravity(Gravity);
	return SendClientMessageToAll(COLOR_BLUE,string);
}

dcmd_force(playerid,params[])
{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
	
	    if(!strlen(params)) return
		SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /force [playerid]");
		new TargetID = strval(params);
		new string[128];
		if(Account[TargetID][Level] > 3)
		return SendClientMessage(playerid,Red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(TargetID))
		{
			CmdToAdmins(playerid,"Force");
			if(TargetID != playerid)
		 	{
			format(string,sizeof(string),"* Administrator %s has forced you into class selection *", pName(playerid));
			SendClientMessage(TargetID,COLOR_ERROR,string);
			}
			format(string,sizeof(string),"* You have forced %s into class selection *", pName(TargetID));
			SendClientMessage(playerid,COLOR_ERROR,string);
			ForceClassSelection(TargetID);
			return SetPlayerHealth(TargetID,0.0);
	    }
		else return SendClientMessage(playerid,Red,"ERROR: Player is not connected");
}

dcmd_lockserver(playerid,params[])
{
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");

	if(ServerInfo[Locked] == 0)
	{
	new adminname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, adminname, sizeof(adminname));
	if(!strlen(params)) return
	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /lockserver [Password]");
	new string[256];
		
	ServerInfo[Locked] = 1;
	strmid(ServerInfo[Password], params[0], 0, strlen(params[0]), 256);
	new file[256];
	format(file,sizeof(file),"ZeroAdmin/Config.ini");
	dini_IntSet(file,"Locked", ServerInfo[Locked]);
	dini_Set(file,"Password", ServerInfo[Password]);
		
	format(string, sizeof(string), "* Administrator %s has Locked the Server *",adminname);
	SendClientMessageToAll(Red,string);
		
	format(string, sizeof(string), "* Administrator %s has set the Server Password to %s *",adminname, ServerInfo[Password]);
	MessageToAdmins(COLOR_WHITE, string);
	return 1;
	}
	else return SendClientMessage(playerid,Red,"ERROR: Server is Locked!");
}

dcmd_unlockserver(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	
	if(ServerInfo[Locked] == 1)
	{
 	return ShowPlayerDialog(playerid, DIALOG_TYPE_SERV_UNLOCK, DIALOG_STYLE_MSGBOX, "Unlock Server","You are sure to want unlock the server?", "Yes", "No");
	}
	else return SendClientMessage(playerid,Red,"ERROR: Server is not Locked");
}

dcmd_admins(playerid,params[])
{
    #pragma unused params
        new count = 0;
        new string[1024];
        new fstring[1024];
        new ARank[128];
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
	 		if (IsPlayerConnected(i))
 			{
				if(Account[i][Level] > 0 && Account[i][Hide] == 0)
 				{
 					if(IsPlayerAdmin(i))
				  	{
				  		ARank = "Rcon Admin";
				  	}
				    else
				    {
				 		switch(Account[i][Level])
						{
							case 1: {ARank = "Moderator";}
							case 2: {ARank = "Master Moderator";}
							case 3: {ARank = "Admin";}
							case 4: {ARank = "Master Admin";}
							case 5: {ARank = "Server Owner";}
						}
					}
					format(fstring, sizeof(fstring), "{FFFFFF}Level: {6EF83C}%d{FFFFFF} - %s (%i) {6EF83C}%s \n",Account[i][Level], pName(i),i,ARank);
     				strcat(string, fstring);
					count++;
				}
			}
		}
		if (count == 0) return ShowPlayerDialog(playerid, 120, DIALOG_STYLE_MSGBOX, "{6EF83C}Online Admins", "{FFFFFF}No admin online in the list", "Ok","");
		else
		{
		format(fstring, sizeof(fstring), "\r\n{6EF83C}Total Admins: {FFFFFF}%d", count);
        strcat(string, fstring);
        ShowPlayerDialog(playerid, 120, DIALOG_STYLE_MSGBOX, "{6EF83C}Online Admins", string, "Ok", "");
		}
		return 1;
}
dcmd_object(playerid,params[])
{
	if(Account[playerid][Level] < 5) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 5 to use this command!");

	if(!strlen(params)) return
 	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /object [objectid]");

	new ObjID = strval(params);
	new Float:X, Float:Y, Float:Z, Float:Ang;
 	CmdToAdmins(playerid,"Object");
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, Ang);
	X += (3 * floatsin(-Ang, degrees));
	Y += (3 * floatcos(-Ang, degrees));
	ObjModel[playerid] = ObjID;
	new obj = CreateObject(ObjID, X+1, Y+1, Z+1, 0.0, 0.0, Ang);
	EditObject(playerid,obj);
	return 1;
}
dcmd_getcord(playerid,params[])
{
	if(Account[playerid][Level] < 2) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 2 to use this command!");

	if(!strlen(params)) return
 	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /getcord [playerid]");
	new TargetID = strval(params);
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(TargetID,X,Y,Z);
	new str1[256],str2[256];
	format(str1,sizeof(str1),"{6EF83C}%s {FFFFFF}Cordinates");
	format(str2,sizeof(str2),"{6EF83C}Cordinates: {FFFFFF}X: %0.1f, Y: %0.1f, Z: %0.1f",X,Y,Z);
	SendClientMessage(playerid, COLOR_ERROR, str2);
	ShowPlayerDialog(playerid, 121, DIALOG_STYLE_MSGBOX, str1, str2, "Ok", "");
	return 1;
}

dcmd_setcord(playerid,params[])
{
	if(Account[playerid][Level] < 3) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 3 to use this command!");
    	
	new Index;
  	new tmp[256];  tmp  = strtok(params,Index);
	new tmp2[256]; tmp2 = strtok(params,Index);
	new tmp3[256]; tmp3 = strtok(params,Index);
	new tmp4[256]; tmp4 = strtok(params,Index);
		
  	if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3) || !strlen(tmp4)) return
  	SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /setcord [playerid] [X] [Y] [Z]");
	    
	new TargetID = strval(tmp);
	new Float:X = strval(tmp2);
	new Float:Y = strval(tmp3);
	new Float:Z = strval(tmp4);
	SetPlayerPos(TargetID,X,Y,Z);
	return 1;
}

dcmd_hide(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
 	if (Account[playerid][Hide] == 1)return SendClientMessage(playerid,Red,"ERROR: You are already have Hidden in the Admin List!");
	Account[playerid][Hide] = 1;
	return SendClientMessage(playerid,COLOR_GREEN,"* You are now Hidden from the Admin List *");
}
dcmd_unhide(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 4) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 4 to use this command!");
	if (Account[playerid][Hide] != 1)return SendClientMessage(playerid,Red,"ERROR: You are not Hidden in the Admin List!");
	Account[playerid][Hide] = 0;
	return SendClientMessage(playerid,COLOR_GREEN,"* You are now Visible in the Admin List *");
}
dcmd_delacc(playerid,params[])
{
	new file[256];
	new Index;
	new str[256];
 	new tmp[256];  tmp  = strtok(params,Index);
	if(Account[playerid][Level] < 5) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 5 to use this command!");
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ERROR, "{6EF83C}Usage:{FFFFFF} /delacc [player name]");
	format(file,sizeof(file),"ZeroAdmin/Accounts/%s.ini",tmp);
	if(!fexist(file))
	return SendClientMessage(playerid, Red, "ERROR: File not found, Player is not registered!");
    format(str,sizeof(str),"* You have Successfully delete %s account *",tmp);
	Kick(GetPlayerID(tmp));
	dini_Remove(file);
	return 1;
}
dcmd_cc(playerid,params[])
{
    #pragma unused params
	if(Account[playerid][Level] < 1) return SendClientMessage(playerid,COLOR_ERROR,"You need to be level 1 to use this command!");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "You are not in vehicle!");
	if(CCPlayer[playerid] == 0)CCPlayer[playerid] = 1;
	else
	CCPlayer[playerid] = 0;
	return 1;
}
public C_C_Player()
{
for(new i;i<MAX_PLAYERS;i++)
{
if(IsPlayerConnected(i))
{
if(IsPlayerInAnyVehicle(i))
{
if(CCPlayer[i] == 1)
{
ChangeVehicleColor(GetPlayerVehicleID(i),random(256),random(256));
}
}
}
}
return 1;
}
stock ZSpecActive(player1,player2)
{
TogglePlayerSpectating(player1, 1);
PlayerSpectatePlayer(player1, player2);
SetPlayerInterior(player1,GetPlayerInterior(player2));
gSpectateID[player1] = player2;
gSpectateType[player1] = ADMIN_SPEC_TYPE_PLAYER;
new Float:Hp,Float:Ar,Mo,Ip[265],str[256];
GetPlayerHealth(player2,Hp);
GetPlayerArmour(player2,Ar);
Mo = GetPlayerMoney(player2);
GetPlayerIp(player2,Ip,sizeof(Ip));
new str2[128];format(str2,sizeof(str2),"~g~%s",pName(player2));
format(str,sizeof(str),"~b~Health:~w~%0.1f ~n~~n~~b~Armour:~w~%0.1f ~n~~n~~b~Money:~w~%d~n~~n~~b~Ip:~w~%s",Hp,Ar,Mo,Ip);
ShowSpecTd(player1,0,str2,str);
}
//----------------------------------------------------------------------------//

stock CmdToAdmins(playerid,command[])
{
	if(Account[playerid][Level] >= 5) return 1;
	new string[256];
	GetPlayerName(playerid,string,sizeof(string));
	format(string,sizeof(string),"[Admin]: %s [Lvl: %d] [Command: %s]",string,Account[playerid][Level],command);
	return MessageToAdmins(COLOR_GREEN,string);
}

stock TotalGameTime(playerid, &h=0, &m=0, &s=0)
{
    Account[playerid][TotalTime] = ( (gettime() - Account[playerid][ConnectTime]) + (Account[playerid][hours]*60*60) + (Account[playerid][mins]*60) + (Account[playerid][secs]) );

    h = floatround(Account[playerid][TotalTime] / 3600, floatround_floor);
    m = floatround(Account[playerid][TotalTime] / 60,   floatround_floor) % 60;
    s = floatround(Account[playerid][TotalTime] % 60,   floatround_floor);

    return Account[playerid][TotalTime];
}

stock UpdateConfig()
{
new file[256];

format(file,sizeof(file),"ZeroAdmin/Config.ini");

ServerInfo[Locked] = dini_Int(file,"Locked");
ServerInfo[Password] = dini_Int(file,"Password");
ServerInfo[AntiSpam] = dini_Int(file,"AntiSpam");
ServerInfo[AutoLogin] = dini_Int(file,"AutoLogin");
ServerInfo[MaxPing] = dini_Int(file,"MaxPing");
ServerInfo[Killing_Spree] = dini_Int(file,"KillingSpree");
ServerInfo[AdminTeleport] = dini_Int(file,"AdminTeleport");
}
stock ShowSpecTd(playerid,type,name[],string[])
{
if(type == 0)
{
TextDrawShowForPlayer(playerid,ZSpecTd[0]);
TextDrawShowForPlayer(playerid,ZSpecTd[1]);
TextDrawSetString(ZSpecTd[2],name);
TextDrawShowForPlayer(playerid,ZSpecTd[2]);
TextDrawSetString(ZSpecTd[3],string);
TextDrawShowForPlayer(playerid,ZSpecTd[3]);
}
else if(type == 1)
{
TextDrawHideForPlayer(playerid,ZSpecTd[0]);
TextDrawHideForPlayer(playerid,ZSpecTd[1]);
TextDrawHideForPlayer(playerid,ZSpecTd[2]);
TextDrawHideForPlayer(playerid,ZSpecTd[3]);
}
}

//-----------------------------------[END]------------------------------------//
