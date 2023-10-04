state("MMBN_LC2") 
{
	// --- Main Menu of Legacy Collection
	byte LC2_GameChoice : 0xAC13F84; // BN4RS - 5/BM - 6,  BN5TM - 7/TC - 8, BN6CG - 9/CF - 10
	byte LC2_GameSelected : 0xAC14688; // when chosen, value turns 0
	
	// --- Mega Man Battle Network 4
    // pointers that work without RAM offset
    byte MMBN4_ENo1 : 0x3D5B608, 0xC0;
    byte MMBN4_ENo2 : 0x3D5B608, 0xC4;
    byte MMBN4_ENo3 : 0x3D5B608, 0xC8;
    short MMBN4_ENo1HP : 0x3D5F838, 0x34;
    short MMBN4_ENo1HP : 0x3D5F838, 0x10C;
    short MMBN4_ENo1HP : 0x3D5F838, 0x1E4;

	// byte MMBN4_GameState : 0x03D617C8, 0xF52;
	// byte MMBN4_AreaID : 0x3D53B28, 0x158;
	// byte MMBN4_SubAreaID : 0x3D53B28, 0x160;
	// byte MMBN4_ENo1 : 0x142CC291, 0xB4x1F;
	// byte MMBN4_ENo1HP : 0x1169D9E6, 0x75C;
	// byte MMBN4_ENo2 : 0x142CC291, 0xB53;
	// byte MMBN4_ENo2HP : 0x1169D9E6, 0x834;
	// byte MMBN4_ENo3 : 0x142CC291, 0xB57;
	// byte MMBN4_ENo3HP : 0x1169D9E6, 0x90C;
	// byte MMBN4_HP : 0x1169D9E6, 0x684;

	// Progress hard to find - if absolutely needed, more delving into ram_offset
	// Battle_Paused & Zenny also affected by RAM_Offset
	// --- https://github.com/TeamBattleNet/Scripts/blob/dea3a2d44963007c8b2a1e1bba3fe5f05dda9829/HUD/BN4/RAM.lua#L12-L28
	
	// --- Mega Man Battle Network 5 Pointers
	// byte MMBN5_GameState : 0xB70FEF3, 0x7EA;
	// byte MMBN5_AreaID : 0xB70FEF3, 0x7EE;
	// byte MMBN5_SubAreaID : 0xB70FEF3, 0x7EF;
	// byte MMBN5_Progress : 0xB70FEF3, 0x7F0;
	// byte MMBN5_GameState : 0xE47634F, 0x200;
	// byte MMBN5_AreaID : 0xE47634F, 0x204;
	// byte MMBN5_SubAreaID : 0xE47634F, 0x205;
	// byte MMBN5_Progress : 0xE47634F, 0x206;
	byte MMBN5_GameState : 0x1DCF1861, 0x793;
	byte MMBN5_AreaID : 0x1DCF1861, 0x797;
	byte MMBN5_SubAreaID : 0x1DCF1861, 0x798;
	byte MMBN5_Progress : 0x1DCF1861, 0x799;
	short MMBN5_ENo1HP : 0x3D679D8, 0x10C;
	short MMBN5_ENo1 : 0x3D679D8, 0x110;
	short MMBN5_ENo2HP : 0x3D679D8, 0x1E4;
	short MMBN5_ENo2 : 0x3D679D8, 0x1E8;
	short MMBN5_ENo2HP : 0x3D679D8, 0x2B8;
	short MMBN5_ENo3 : 0x3D679D8, 0x2BC;

	// --- Mega Man Battle Network 6 Pointers
	byte MMBN6_GameState : 0x1DCF1861, 0xE3;
	byte MMBN6_AreaID : 0x1DCF1861, 0xE7;
	byte MMBN6_SubAreaID : 0x1DCF1861, 0xE8;
	byte MMBN6_Progress : 0x1DCF1861, 0xE9;
	byte MMBN6_BattlePaused : 0x1DCF1861, 0xED;
	short MMBN6_ENo1HP : 0x3D6FFC8, 0x110;
	short MMBN6_ENo1 : 0x3D6FFC8, 0x110;
	short MMBN6_ENo2HP : 0x3D6FFC8, 0x1E4;
	short MMBN6_ENo2 : 0x3D6FFC8, 0x1E8;
	short MMBN6_ENo3HP : 0x3D6FFC8, 0x2BC;
	short MMBN6_ENo3 : 0x3D6FFC8, 0x2C0;
}