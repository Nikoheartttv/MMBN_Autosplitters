state("MMBN_LC1") 
{
	// --- Main Menu of Legacy Collection
	byte LC1_GameChoice : 0x989B384; // BN1 = 0, BN2 = 2, BN3W = 3, BN3B = 4
	byte LC1_GameSelected : 0x989BA88; // when chosen, value turns 0

	// --- Global Pointers Throughout Games
	byte LC1_GameState : 0x29EE840, 0xB8, 0x0; // 28 on ng/continue select - 0 is hit when selecting "Return to Title Screen"
	byte LC1_AreaID : 0x29EE840, 0xB8, 0x4;
	byte LC1_SubAreaID : 0x29EE840, 0xB8, 0x5;
	byte LC1_Progress : 0x29EE840, 0xB8, 0x6;
	byte LC1_BattlePaused : 0x29EE840, 0xB8, 0x9;
	int LC1_Zenny : 0x29EE840, 0xB8, 0x74;
	// int KeyItems : 0x29EE840, 0xB8, 0xC0;
	int LC1_ENo1 : 0x29EE840, 0x50, 0x0;
	int LC1_ENo2 : 0x29EE840, 0x50, 0x4;
	int LC1_ENo3 : 0x29EE840, 0x50, 0x8;

	// --- Mega Man Battle Network 1 Pointers
	short MMBN1_HP : 0x29F3148, 0x20;
	short MMBN1_ENoHP1 : 0x29F21F8, 0x60;
	short MMBN1_ENoHP2 : 0x29F21F8, 0x110;
	short MMBN1_ENoHP3 : 0x29F21F8, 0x1C0;
	byte MMBN1_HigsMemo : 0x29EE840, 0xB8, 0xF4;
	byte MMBN1_LabMemo : 0x29EE840, 0xB8, 0xF5;
	byte MMBN1_YuriMemo : 0x29EE840, 0xB8, 0xF6;
	byte MMBN1_PaMemo : 0x29EE840, 0xB8, 0xF7;
	short MMBN1_FinalSplit : 0x29F21F8, 0x4;

	// --- Mega Man Battle Network 2 Pointers
	short MMBN2_HP : 0x29F5988, 0x24;
	short MMBN2_ENoHP1 : 0x29F21F8, 0x1A4;
	short MMBN2_ENoHP2 : 0x29F21F8, 0x264;
	short MMBN2_ENoHP3 : 0x29F21F8, 0x264;
	byte MMBN2_BLicense: 0x29EE840, 0xB8, 0x148;
	byte MMBN2_HeatData : 0x29EE840, 0xB8, 0x134;
	int MMBN2_FinalSplit: 0x29F4CD8, 0x4;

	// --- Mega Man Battle Network 3 White/Blue Pointers
	short MMBN3_HP : 0x29F9748, 0x34;
	short MMBN3_ENoHP1 : 0x29F9748, 0x108;
	short MMBN3_ENoHP2 : 0x29F9748, 0x1DC;
	short MMBN3_ENoHP3 : 0x29F9748, 0x2B0;
	int MMBN3_MainRNG : 0x16485EAA, 0x897;
	int MMBN3_LazyRNG : 0x16485EAA, 0x89B;
	ushort MMBN3_WindStarChip : 0x29EE840, 0xB8, 0xE13;
	byte MMBN3_IceballMChip : 0x29EE840, 0xB8, 0x5C4;
	byte MMBN3_YoyoGChip : 0x29EE840, 0xB8, 0x8DE;
	byte MMBN3_N1Prelim3Win : 0x29FA938, 0x94;
	short MMBN3_Tally : 0x29EE840, 0xB8, 0x104;
	short MMBN3_ToraJobsFinished : 0x29EE840, 0xB8, 0x69C;
	byte MMBN3_Rank10OnScreen : 0x29F0938;
	byte MMBN3_CompletedSplit : 0x29FA938, 0x60;
}

// startup
// {
// 	settings.Add("Vol1", true, "Legacy Collection 1");
// 	settings.CurrentDefaultParent = "Vol1";

// 	settings.Add("Vol1Logging", false, "Global Logging");
// 	settings.CurrentDefaultParent = "Vol1Logging";
// 	settings.Add("Vol1GameChoice", false, "Game Choice");
// 	settings.Add("Vol1GameSelected", false, "Game Selected");
// 	settings.Add("Vol1GameState", false, "Game State");
// 	settings.Add("Vol1AreaID", false, "Area ID");
// 	settings.Add("Vol1SubAreaID", false, "Sub Area ID");
// 	settings.Add("Vol1Progress", false, "Progress");
// 	settings.Add("Vol1ENo1", false, "Enemy Number 1 ID");
// 	settings.Add("Vol1ENo2", false, "Enemy Number 2 ID");
// 	settings.Add("Vol1ENo3", false, "Enemy Number 3 ID");
// 	settings.CurrentDefaultParent = "Vol1";

// 	settings.Add("BN1", true, "Mega Man Battle Network 1");
// 	settings.CurrentDefaultParent = "BN1";

// 	settings.Add("BN1Logging", false, "BN1 Logging");
// 	settings.CurrentDefaultParent = "BN1Logging";
// 	settings.Add("BN1HigsMemoLog", false, "Higs Memo Get");
// 	settings.Add("BN1LabMemoLog", false, "Lab Memo Get");
// 	settings.Add("BN1YuriMemoLog", false, "Yuri Memo Get");
// 	settings.Add("BN1PaMemoLog", false, "Pa Memo Get");
// 	settings.CurrentDefaultParent = "BN1";


// 	settings.Add("BN1FinalSplit", true, "Final Split");
// 	settings.CurrentDefaultParent = "BN1FinalSplit";
// 	settings.Add("BN1LifeVirusSplit", true, "Life Virus Kill + End Split");
// 	settings.Add("BN1NoLifeVirusSplit", false, "Skip Life Virus + End Split");
// 	settings.CurrentDefaultParent = "BN1";
	
// 	settings.Add("BN1MainSplits", true, "Main Splits");
// 	settings.CurrentDefaultParent = "BN1MainSplits";
// 	settings.Add("0FireMan", true, "FireMan");
// 	settings.Add("0NumberMan", true, "NumberMan");
// 	settings.Add("0GutsMan", true, "GutsMan");
// 	settings.Add("0StoneMan", true, "StoneMan");
// 	settings.Add("0ColdBear", true, "ColdBear");
// 	settings.Add("0IceMan", true, "IceMan");
// 	settings.Add("0SkullMan", true, "SkullMan");
// 	settings.Add("0ColorMan", true, "ColorMan");
// 	settings.Add("0ElecMan", false, "ElecMan");
// 	settings.Add("0ProtoMan", true, "ProtoMan");
// 	settings.Add("0Memos", true, "Memos");
// 	settings.Add("0BombMan", true, "BombMan");
// 	settings.Add("0MagicMan", true, "MagicMan");
// 	settings.Add("0LifeVirus", true, "LifeVirus");
// 	settings.CurrentDefaultParent = "BN1";

// 	settings.Add("BN1MBosses", true, "Mini-Bosses");
// 	settings.CurrentDefaultParent = "BN1MBosses";
// 	settings.Add("0Floshell", true, "Floshell");
// 	settings.CurrentDefaultParent = "BN1";

// 	settings.Add("BN1OBosses", false, "Optional Bosses");
// 	settings.CurrentDefaultParent = "BN1OBosses";
// 	settings.Add("0GutsManV2", false, "GutsManV2");
// 	settings.Add("0GutsManV3", false, "GutsManV3");
// 	settings.Add("0ProtoManV2", false, "ProtoManV2");
// 	settings.Add("0ProtoManV3", false, "ProtoManV3");
// 	settings.Add("0WoodMan", false, "WoodMan");
// 	settings.Add("0WoodManV2", false, "WoodManV2");
// 	settings.Add("0WoodManV3", false, "WoodManV3");
// 	settings.Add("0FireManV2", false, "FireManV2");
// 	settings.Add("0FireManV3", false, "FireManV3");
// 	settings.Add("0NumberManV2", false, "NumberManV2");
// 	settings.Add("0NumberManV3", false, "NumberManV3");
// 	settings.Add("0StoneManV2", false, "StoneManV2");
// 	settings.Add("0StoneManV3", false, "StoneManV3");
// 	settings.Add("0IceManV2", false, "IceManV2");
// 	settings.Add("0IceManV3", false, "IceManV3");
// 	settings.Add("0SkullManV2", false, "SkullManV2");
// 	settings.Add("0SkullManV3", false, "SkullManV3");
// 	settings.Add("0ColorManV2", false, "ColorManV2");
// 	settings.Add("0ColorManV3", false, "ColorManV3");
// 	settings.Add("0BombManV2", false, "BombManV2");
// 	settings.Add("0BombManV3", false, "BombManV3");
// 	settings.Add("0SharkMan", false, "SharkMan");
// 	settings.Add("0SharkManV2", false, "SharkManV2");
// 	settings.Add("0SharkManV3", false, "SharkManV3");
// 	settings.Add("0ElecManV2", false, "ElecManV2");
// 	settings.Add("0ElecManV3", false, "ElecManV3");
// 	settings.Add("0PharaohMan", false, "PharaohMan");
// 	settings.Add("0PharaohManV2", false, "PharaohManV2");
// 	settings.Add("0PharaohManV3", false, "PharaohManV3");
// 	settings.Add("0ShadowMan", false, "ShadowMan");
// 	settings.Add("0ShadowManV2", false, "ShadowManV2");
// 	settings.Add("0ShadowManV3", false, "ShadowManV3");
// 	settings.Add("0MagicManV2", false, "MagicManV2");
// 	settings.Add("0MagicManV3", false, "MagicManV3");
// 	settings.Add("0Bass", false, "Bass");
// 	settings.CurrentDefaultParent = "Vol1";

// 	settings.Add("BN2", true, "Mega Man Battle Network 2");
// 	settings.CurrentDefaultParent = "BN2";

// 	settings.Add("BN2MainSplits", true, "Main Splits");
// 	settings.CurrentDefaultParent = "BN2MainSplits";
// 	settings.Add("2ZLicensePassed", false, "Z License Passed");
// 	settings.Add("2AirMan", true, "AirMan");
// 	settings.Add("2BLicensePassed", true, "B License Passed");
// 	settings.Add("2GutsMan", true, "GutsMan");
// 	settings.Add("2QuickMan", true, "QuickMan");
// 	settings.Add("2ALicensePrelims", true, "A License Prelimiaries Passed");
// 	settings.Add("2ALicenseExam", true, "A License Exam Passed");
// 	settings.Add("2CutMan", true, "CutMan");
// 	settings.Add("2EscapedYumland", true, "Escaped Yumland");
// 	settings.Add("2ShadowMan", true, "ShadowMan");
// 	settings.Add("2ThunderMan", true, "ThunderMan");
// 	settings.Add("2SnakeMan", true, "SnakeMan");
// 	settings.Add("2ProtoMan", true, "ProtoMan");
// 	settings.Add("2KnightMan", true, "KnightMan");
// 	settings.Add("2MagnetMan", true, "MagnetMan");
// 	settings.Add("2HeatData", true, "HeatData Acquired");
// 	settings.Add("2FreezeMan", true, "FreezeMan");
// 	settings.Add("2BossRush1", true, "Bosh Rush 1");
// 	settings.Add("2BossRush2", true, "Bosh Rush 2");
// 	settings.Add("2Bass", true, "Bass");
// 	settings.Add("2Completed", true, "Completed");
// 	settings.CurrentDefaultParent = "BN2";

// 	settings.Add("BN2AltSplits", false, "Alternative Splits");
// 	settings.CurrentDefaultParent = "BN2AltSplits";
// 	settings.Add("2Doghouse", false, "Doghouse");
// 	settings.Add("2GospelSplit", false, "Gospel");
// 	settings.CurrentDefaultParent = "BN2";

// 	settings.Add("BN2OBosses", false, "Optional Bosses");
// 	settings.CurrentDefaultParent = "BN2OBosses";
// 	settings.Add("2AirManV2", true, "AirManV2");
// 	settings.Add("2AirManV3", true, "AirManV3");
// 	settings.Add("2QuickManV2", false, "QuickManV2");
// 	settings.Add("2QuickManV3", false, "QuickManV3");
// 	settings.Add("2CutManV2", false, "CutManV2");
// 	settings.Add("2CutManV3", false, "CutManV3");
// 	settings.Add("2ShadowManV2", false, "ShadowManV2");
// 	settings.Add("2ShadowManV3", false, "ShadowManV3");
// 	settings.Add("2KnightManV2", false, "KnightManV2");
// 	settings.Add("2KnightManV3", false, "KnightManV3");
// 	settings.Add("2MagnetManV2", false, "MagnetManV2");
// 	settings.Add("2MagnetManV3", false, "MagnetManV3");
// 	settings.Add("2FreezeManV2", false, "FreezeManV2");
// 	settings.Add("2FreezeManV3", false, "FreezeManV3");
// 	settings.Add("2HeatMan", false, "HeatMan");
// 	settings.Add("2HeatManV2", false, "HeatManV2");
// 	settings.Add("2HeatManV3", false, "HeatManV3");
// 	settings.Add("2ToadMan", false, "ToadMan");
// 	settings.Add("2ToadManV2", false, "ToadManV2");
// 	settings.Add("2ToadManV3", false, "ToadManV3");
// 	settings.Add("2ThunderManV2", false, "ThunderManV2");
// 	settings.Add("2ThunderManV3", false, "ThunderManV3");
// 	settings.Add("2SnakeManV2", false, "SnakeManV2");
// 	settings.Add("2SnakeManV3", false, "SnakeManV3");
// 	settings.Add("2GutsManV2", false, "GutsManV2");
// 	settings.Add("2GutsManV3", false, "GutsManV3");
// 	settings.Add("2ProtoManV2", false, "ProtoManV2");
// 	settings.Add("2ProtoManV3", false, "ProtoManV3");
// 	settings.Add("2GateMan", false, "GateMan");
// 	settings.Add("2GateManV2", false, "GateManV2");
// 	settings.Add("2GateManV3", false, "GateManV3");
// 	settings.Add("2PlanetMan", false, "PlanetMan");
// 	settings.Add("2PlanetManV2", false, "PlanetManV2");
// 	settings.Add("2PlanetManV3", false, "PlanetManV3");
// 	settings.Add("2NapalmMan", false, "NapalmMan");
// 	settings.Add("2NapalmManV2", false, "NapalmManV2");
// 	settings.Add("2NapalmManV3", false, "NapalmManV3");
// 	settings.Add("2PharaohMan", false, "NapalmMan");
// 	settings.Add("2PharaohManV2", false, "PharaohManV2");
// 	settings.Add("2PharaohManV3", false, "PharaohManV3");
// 	settings.Add("2BassDeluxe", false, "Bass Deluxe");
// 	settings.CurrentDefaultParent = "Vol1";

// 	settings.Add("BN3W", true, "Mega Man Battle Network 3 White");
// 	settings.CurrentDefaultParent = "BN3W";

// 	settings.Add("BN3WLogging", false, "BN3W Logging");
// 	settings.CurrentDefaultParent = "BN3WLogging";
// 	settings.Add("3MainRNG", false, "Main RNG Hexidecimal");
// 	settings.Add("3LazyRNG", false, "Lazy RNG Hexidecimal");
// 	settings.CurrentDefaultParent = "BN3W";

// 	settings.Add("BN3WMainSplits", true, "Main Splits");
// 	settings.CurrentDefaultParent = "BN3WMainSplits";
// 	settings.Add("3N1Prelim1", true, "N1 Prelim 1");
// 	settings.Add("3FlashMan", true, "FlashMan");
// 	settings.Add("3N1Prelim2", true, "N1 Prelim 2");
// 	settings.Add("3BeastMan", true, "BeastMan");
// 	settings.Add("3Wind", true, "Wind *");
// 	settings.Add("3N1Prelim3", true, "N1 Prelim 3");
// 	settings.Add("3BubbleMan", true, "BubbleMan");
// 	settings.Add("3BeachGauntlet", true, "Beach Gauntlet");
// 	settings.Add("3DesertMan", true, "DesertMan");
// 	settings.Add("3ToraJobs", true, "Tora Jobs");
// 	settings.Add("3PlantMan", true, "PlantMan");
// 	settings.Add("3FiresStarted", true, "Fires Started - SciLab Train Stairs End Convo");
// 	settings.Add("3FlamMan", true, "FlamMan");
// 	settings.Add("3Rank10", true, "Rank 10");
// 	settings.Add("3DrillMan", true, "DrillMan");
// 	settings.Add("3BubbleManAlpha", true, "BubbleMan Alpha V2");
// 	settings.Add("3Completion", true, "Completion");
// 	settings.CurrentDefaultParent = "BN3W";

// 	settings.Add("BN3WAltSplits", false, "Alternative Splits");
// 	settings.CurrentDefaultParent = "BN3WAltSplits";
// 	settings.Add("3IceballM", false, "Iceball M Chip Get");
// 	settings.Add("3YoyoG", false, "Yo-Yo G Chip Get");
// 	settings.CurrentDefaultParent = "BN3W";

// 	settings.Add("BN3WOBosses", false, "Optional Bosses");
// 	settings.CurrentDefaultParent = "BN3WOBosses";
// 	settings.Add("3FlashManAlpha", true, "FlashMan Alpha / V2");
// 	settings.Add("3FlashManBeta", true, "FlashMan Beta / V3");
// 	settings.Add("3FlashManOmega", true, "FlashMan Omega / SP");
// 	settings.Add("3BeastManAlpha", true, "BeastMan Alpha / V2");
// 	settings.Add("3BeastManBeta", true, "BeastMan Beta / V3");
// 	settings.Add("3BeastManOmega", true, "BeastMan Omega / SP");
// 	settings.Add("3BubbleManBeta", true, "BubbleMan Beta / V3");
// 	settings.Add("3BubbleManOmega", true, "BubbleMan Omega / SP");
// 	settings.Add("3DesertManAlpha", true, "DesertMan Alpha / V2");
// 	settings.Add("3DesertManBeta", true, "DesertMan Beta / V3");
// 	settings.Add("3DesertManOmega", true, "DesertMan Omega / SP");
// 	settings.Add("3PlantManAlpha", true, "PlantMan Alpha / V2");
// 	settings.Add("3PlantManBeta", true, "PlantMan Beta / V3");
// 	settings.Add("3PlantManOmega", true, "PlantMan Omega / SP");
// 	settings.Add("3FlamManAlpha", true, "FlamMan Alpha / V2");
// 	settings.Add("3FlamManBeta", true, "FlamMan Beta / V3");
// 	settings.Add("3FlamManOmega", true, "FlamMan Omega / SP");
// 	settings.Add("3DrillManAlpha", true, "DrillMan Alpha / V2");
// 	settings.Add("3DrillManBeta", true, "DrillMan Beta / V3");
// 	settings.Add("3DrillManOmega", true, "DrillMan Omega / SP");
// 	settings.Add("3Alpha", true, "Alpha");
// 	settings.Add("3AlphaOmega", true, "Alpha Omega");
// 	settings.Add("3GutsMan", true, "GutsMan");
// 	settings.Add("3GutsManAlpha", true, "GutsMan Alpha / V2");
// 	settings.Add("3GutsManBeta", true, "GutsMan Beta / V3");
// 	settings.Add("3GutsManOmega", true, "GutsMan Omega / SP");
// 	settings.Add("3ProtoMan", true, "ProtoMan");
// 	settings.Add("3ProtoManAlpha", true, "ProtoMan Alpha / V2");
// 	settings.Add("3ProtoManBeta", true, "ProtoMan Beta / V3");
// 	settings.Add("3ProtoManOmega", true, "ProtoMan Omega / SP");
// 	settings.Add("3MetalMan", true, "MetalMan");
// 	settings.Add("3MetalManAlpha", true, "MetalMan Alpha / V2");
// 	settings.Add("3MetalManBeta", true, "MetalMan Beta / V3");
// 	settings.Add("3MetalManOmega", true, "MetalMan Omega / SP");
// 	settings.Add("3Punk", true, "Punk");
// 	settings.Add("3PunkAlpha", true, "Punk Alpha / V2");
// 	settings.Add("3PunkBeta", true, "Punk Beta / V3");
// 	settings.Add("3PunkOmega", true, "Punk Omega / SP");
// 	settings.Add("3KingMan", true, "KingMan");
// 	settings.Add("3KingManAlpha", true, "KingMan Alpha / V2");
// 	settings.Add("3KingManBeta", true, "KingMan Beta / V3");
// 	settings.Add("3KingManOmega", true, "KingMan Omega / SP");
// 	settings.Add("3MistMan", true, "MistMan");
// 	settings.Add("3MistManAlpha", true, "MistMan Alpha / V2");
// 	settings.Add("3MistManBeta", true, "MistMan Beta / V3");
// 	settings.Add("3MistManOmega", true, "MistMan Omega / SP");
// 	settings.Add("3BowlMan", true, "BowlMan");
// 	settings.Add("3BowlManAlpha", true, "BowlMan Alpha / V2");
// 	settings.Add("3BowlManBeta", true, "BowlMan Beta / V3");
// 	settings.Add("3BowlManOmega", true, "BowlMan Omega / SP");
// 	settings.Add("3DarkMan", true, "DarkMan");
// 	settings.Add("3DarkManAlpha", true, "DarkMan Alpha / V2");
// 	settings.Add("3DarkManBeta", true, "DarkMan Beta / V3");
// 	settings.Add("3DarkManOmega", true, "DarkMan Omega / SP");
// 	settings.Add("3JapanMan", true, "JapanMan");
// 	settings.Add("3JapanManAlpha", true, "JapanMan Alpha / V2");
// 	settings.Add("3JapanManBeta", true, "JapanMan Beta / V3");
// 	settings.Add("3JapanManOmega", true, "JapanMan Omega / SP");
// 	settings.Add("3Serenade", true, "Serenade");
// 	settings.Add("3SerenadeAlpha", true, "Serenade Alpha / V2");
// 	settings.Add("3SerenadeBeta", true, "Serenade Beta / V3");
// 	settings.Add("3SerenadeOmega", true, "Serenade Alpha / SP");
// 	settings.Add("3Bass", true, "Bass");
// 	settings.Add("3BassGS", true, "Bass GS");
// 	settings.Add("3BassOmega", true, "Bass Omega");
// 	settings.CurrentDefaultParent = "Vol1";

// 	settings.Add("BN3B", true, "Mega Man Battle Network 3 Blue");
// 	settings.CurrentDefaultParent = "BN3B";

// 	settings.Add("BN3BLogging", false, "BN3B Logging");
// 	settings.CurrentDefaultParent = "BN3BLogging";
// 	settings.Add("4MainRNG", false, "Main RNG Hexidecimal");
// 	settings.Add("4LazyRNG", false, "Lazy RNG Hexidecimal");
// 	settings.CurrentDefaultParent = "BN3B";

// 	settings.Add("BN3BMainSplits", true, "Main Splits");
// 	settings.CurrentDefaultParent = "BN3BMainSplits";
// 	settings.Add("4N1Prelim1", true, "N1 Prelim 1");
// 	settings.Add("4FlashMan", true, "FlashMan");
// 	settings.Add("4N1Prelim2", true, "N1 Prelim 2");
// 	settings.Add("4BeastMan", true, "BeastMan");
// 	settings.Add("4Wind", true, "Wind *");
// 	settings.Add("4N1Prelim3", true, "N1 Prelim 3");
// 	settings.Add("4BubbleMan", true, "BubbleMan");
// 	settings.Add("4BeachGauntlet", true, "Beach Gauntlet");
// 	settings.Add("4DesertMan", true, "DesertMan");
// 	settings.Add("4ToraJobs", true, "Tora Jobs");
// 	settings.Add("4PlantMan", true, "PlantMan");
// 	settings.Add("4FiresStarted", true, "Fires Started - SciLab Train Stairs End Convo");
// 	settings.Add("4FlamMan", true, "FlamMan");
// 	settings.Add("4Rank10", true, "Rank 10");
// 	settings.Add("4DrillMan", true, "FlamMan");
// 	settings.Add("4BubbleManV2", true, "BubbleMan V2");
// 	settings.Add("4Completion", true, "Completion");
// 	settings.CurrentDefaultParent = "BN3B";

// 	settings.Add("BN3BAltSplits", false, "Alternative Splits");
// 	settings.CurrentDefaultParent = "BN3BAltSplits";
// 	settings.Add("4IceballM", false, "Iceball M Chip Get");
// 	settings.Add("4YoyoG", false, "Yo-Yo G Chip Get");
// 	settings.CurrentDefaultParent = "BN3B";

// 	settings.Add("BN3BOBosses", false, "Optional Bosses");
// 	settings.CurrentDefaultParent = "BN3BOBosses";
// 	settings.Add("4FlashManAlpha", true, "FlashMan Alpha / V2");
// 	settings.Add("4FlashManBeta", true, "FlashMan Beta / V3");
// 	settings.Add("4FlashManOmega", true, "FlashMan Omega / SP");
// 	settings.Add("4BeastManAlpha", true, "BeastMan Alpha / V2");
// 	settings.Add("4BeastManBeta", true, "BeastMan Beta / V3");
// 	settings.Add("4BeastManOmega", true, "BeastMan Omega / SP");
// 	settings.Add("4BubbleManBeta", true, "BubbleMan Beta / V3");
// 	settings.Add("4BubbleManOmega", true, "BubbleMan Omega / SP");
// 	settings.Add("4DesertManAlpha", true, "DesertMan Alpha / V2");
// 	settings.Add("4DesertManBeta", true, "DesertMan Beta / V3");
// 	settings.Add("4DesertManOmega", true, "DesertMan Omega / SP");
// 	settings.Add("4PlantManAlpha", true, "PlantMan Alpha / V2");
// 	settings.Add("4PlantManBeta", true, "PlantMan Beta / V3");
// 	settings.Add("4PlantManOmega", true, "PlantMan Omega / SP");
// 	settings.Add("4FlamManAlpha", true, "FlamMan Alpha / V2");
// 	settings.Add("4FlamManBeta", true, "FlamMan Beta / V3");
// 	settings.Add("4FlamManOmega", true, "FlamMan Omega / SP");
// 	settings.Add("4DrillManAlpha", true, "DrillMan Alpha / V2");
// 	settings.Add("4DrillManBeta", true, "DrillMan Beta / V3");
// 	settings.Add("4DrillManOmega", true, "DrillMan Omega / SP");
// 	settings.Add("4Alpha", true, "Alpha");
// 	settings.Add("4AlphaOmega", true, "Alpha Omega");
// 	settings.Add("4GutsMan", true, "GutsMan");
// 	settings.Add("4GutsManAlpha", true, "GutsMan Alpha / V2");
// 	settings.Add("4GutsManBeta", true, "GutsMan Beta / V3");
// 	settings.Add("4GutsManOmega", true, "GutsMan Omega / SP");
// 	settings.Add("4ProtoMan", true, "ProtoMan");
// 	settings.Add("4ProtoManAlpha", true, "ProtoMan Alpha / V2");
// 	settings.Add("4ProtoManBeta", true, "ProtoMan Beta / V3");
// 	settings.Add("4ProtoManOmega", true, "ProtoMan Omega / SP");
// 	settings.Add("4MetalMan", true, "MetalMan");
// 	settings.Add("4MetalManAlpha", true, "Metal Man Alpha / V2");
// 	settings.Add("4MetalManBeta", true, "MetalMan Beta / V3");
// 	settings.Add("4MetalManOmega", true, "MetalMan Omega / SP");
// 	settings.Add("4Punk", true, "Punk");
// 	settings.Add("4PunkAlpha", true, "Punk Alpha / V2");
// 	settings.Add("4PunkBeta", true, "Punk Beta / V3");
// 	settings.Add("4PunkOmega", true, "Punk Omega / SP");
// 	settings.Add("4KingMan", true, "KingMan");
// 	settings.Add("4KingManAlpha", true, "KingMan Alpha / V2");
// 	settings.Add("4KingManBeta", true, "KingMan Beta / V3");
// 	settings.Add("4KingManOmega", true, "KingMan Omega / SP");
// 	settings.Add("4MistMan", true, "MistMan");
// 	settings.Add("4MistManAlpha", true, "MistMan Alpha / V2");
// 	settings.Add("4MistManBeta", true, "MistMan Beta / V3");
// 	settings.Add("4MistManOmega", true, "MistMan Omega / SP");
// 	settings.Add("4BowlMan", true, "BowlMan");
// 	settings.Add("4BowlManAlpha", true, "BowlMan Alpha / V2");
// 	settings.Add("4BowlManBeta", true, "BowlMan Beta / V3");
// 	settings.Add("4BowlManOmega", true, "BowlMan Omega / SP");
// 	settings.Add("4DarkMan", true, "DarkMan");
// 	settings.Add("4DarkManAlpha", true, "DarkMan Alpha / V2");
// 	settings.Add("4DarkManBeta", true, "DarkMan Beta / V3");
// 	settings.Add("4DarkManOmega", true, "DarkMan Omega / SP");
// 	settings.Add("4JapanMan", true, "JapanMan");
// 	settings.Add("4JapanManAlpha", true, "JapanMan Alpha / V2");
// 	settings.Add("4JapanManBeta", true, "JapanMan Beta / V3");
// 	settings.Add("4JapanManOmega", true, "JapanMan Omega / SP");
// 	settings.Add("4Serenade", true, "Serenade");
// 	settings.Add("4SerenadeAlpha", true, "Serenade Alpha / V2");
// 	settings.Add("4SerenadeBeta", true, "Serenade Beta / V3");
// 	settings.Add("4SerenadeOmega", true, "Serenade Alpha / SP");
// 	settings.Add("4Bass", true, "Bass");
// 	settings.Add("4BassGS", true, "Bass GS");
// 	settings.Add("4BassOmega", true, "Bass Omega");
// 	settings.CurrentDefaultParent = null;
// }

startup
{
	if (timer.CurrentTimingMethod == TimingMethod.GameTime)
	{
		var timingMessage = MessageBox.Show (
			"This game uses Real Time (RTA) as the main timing method.\n"+
			"LiveSplit is currently set to show Time without Loads (RTA).\n"+
			"Would you like to set the timing method to Real Time?",
			"LiveSplit | Mega Man Battle Network 3",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);

		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.RealTime;
		}
	}

	Action<IEnumerable<System.Xml.Linq.XElement>, string> ReadSettingsXML = null;
    ReadSettingsXML = (elements, parentid) =>
	{
		foreach (var element in elements) 
		{
			settings.Add(element.Attribute("id").Value, element.Attribute("defaultValue") != null && element.Attribute("defaultValue").Value == "true", element.Attribute("name").Value, parentid);
			ReadSettingsXML(element.Elements("setting"), element.Attribute("id").Value);
		}
	};

	var xml = System.Xml.Linq.XDocument.Load(@"Components/MMBN.Settings.xml");
    foreach (var element in xml.Element("settings").Elements("setting"))
    {
        if (element.Attribute("id").Value == "BN1")
        {
            vars.GameSettings = element;
            break;
        }
		if (element.Attribute("id").Value == "BN2")
        {
            vars.GameSettings = element;
            break;
        }
		if (element.Attribute("id").Value == "BN3")
        {
            vars.GameSettings = element;
            break;
        }
    }

    ReadSettingsXML(vars.GameSettings.Elements("setting"), null);
}

