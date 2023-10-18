state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");

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
    
    vars.CheckBossDefeated = (Func<byte, bool>)((bossId) =>
	{
        if (vars.Helper["GameState"].Current != 8) return false;
		if (vars.Helper["EnemyNo1"].Current == bossId && vars.Helper["EnemyNo1HP"].Changed && vars.Helper["EnemyNo1HP"].Current == 0 ||
			vars.Helper["EnemyNo2"].Current == bossId && vars.Helper["EnemyNo2HP"].Changed && vars.Helper["EnemyNo2HP"].Current == 0 ||
			vars.Helper["EnemyNo3"].Current == bossId && vars.Helper["EnemyNo3HP"].Changed && vars.Helper["EnemyNo3HP"].Current == 0)
		{
			// return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
            return true;
		}
		return false;
	});

    vars.CheckProgress = (Func<byte, bool>)((value) =>
	{
		if (vars.Helper == null || vars.Helper["Progress"] == null) return false;
		if (vars.Helper["Progress"].Changed && vars.Helper["Progress"].Current == value) return true;
		return false;
	});

    vars.CheckN1Prelims3 = (Func<bool>)(() =>
	{
		if (vars.Helper["Progress"].Current == 34 && vars.Helper["MainArea"].Current == 146 && vars.Helper["SubArea"].Current == 2)
        {
            if (vars.Helper["EnemyNo1"].Current == 6 && vars.Helper["EnemyNo1HP"].Current == 0 ||
			    vars.Helper["EnemyNo2"].Current == 41 && vars.Helper["EnemyNo2HP"].Current == 0 ||
			    vars.Helper["EnemyNo3"].Current == 139 && vars.Helper["EnemyNo3HP"].Current == 0)
            {
                return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
            }
        }
        return false;
	});


    vars.CheckBattleReward = (Func<ushort, bool>)((value) =>
    {
        if (vars.Helper["BattleReward"].Changed && vars.Helper["BattleReward"].Current == value) return true;
        return false;
    });

    var xml = System.Xml.Linq.XDocument.Load(@"Components/MMBN.Settings.xml");
    foreach (var element in xml.Element("settings").Elements("setting"))
    {
        if (element.Attribute("id").Value == "BN3")
        {
            vars.GameSettings = element;
            break;
        }
    }

    vars.codes = new string[27];
    vars.codes[0] = "A";
    vars.codes[1] = "B";
    vars.codes[2] = "C";
    vars.codes[3] = "D";
    vars.codes[4] = "E";
    vars.codes[5] = "F";
    vars.codes[6] = "G";
    vars.codes[7] = "H";
    vars.codes[8] = "I";
    vars.codes[9] = "J";
    vars.codes[10] = "K";
    vars.codes[11] = "L";
    vars.codes[12] = "M";
    vars.codes[13] = "N";
    vars.codes[14] = "O";
    vars.codes[15] = "P";
    vars.codes[16] = "Q";
    vars.codes[17] = "R";
    vars.codes[18] = "S";
    vars.codes[19] = "T";
    vars.codes[20] = "U";
    vars.codes[21] = "V";
    vars.codes[22] = "W";
    vars.codes[23] = "X";
    vars.codes[24] = "Y";
    vars.codes[25] = "Z";
    vars.codes[26] = "*";


    vars.chips = new string[385];
    vars.chips[0] = "Empty";
    vars.chips[1] = "Cannon";
    vars.chips[2] = "HiCannon";
    vars.chips[3] = "M-Cannon";
    vars.chips[4] = "AirShot1";
    vars.chips[5] = "AirShot2";
    vars.chips[6] = "AirShot3";
    vars.chips[7] = "LavaCan1";
    vars.chips[8] = "LavaCan2";
    vars.chips[9] = "LavaCan3";
    vars.chips[10] = "ShotGun";
    vars.chips[11] = "V-Gun";
    vars.chips[12] = "SideGun";
    vars.chips[13] = "Spreader";
    vars.chips[14] = "Bubbler";
    vars.chips[15] = "Bub-V";
    vars.chips[16] = "BublSide";
    vars.chips[17] = "HeatShot";
    vars.chips[18] = "Heat-V";
    vars.chips[19] = "HeatSide";
    vars.chips[20] = "MiniBomb";
    vars.chips[21] = "SnglBomb";
    vars.chips[22] = "DublBomb";
    vars.chips[23] = "TrplBomb";
    vars.chips[24] = "CannBall";
    vars.chips[25] = "IceBall";
    vars.chips[26] = "LavaBall";
    vars.chips[27] = "BlkBomb1";
    vars.chips[28] = "BlkBomb2";
    vars.chips[29] = "BlkBomb3";
    vars.chips[30] = "Sword";
    vars.chips[31] = "WideSwrd";
    vars.chips[32] = "LongSwrd";
    vars.chips[33] = "FireSwrd";
    vars.chips[34] = "AquaSwrd";
    vars.chips[35] = "ElecSwrd";
    vars.chips[36] = "BambSwrd";
    vars.chips[37] = "CustSwrd";
    vars.chips[38] = "VarSwrd";
    vars.chips[39] = "StepSwrd";
    vars.chips[40] = "StepCros";
    vars.chips[41] = "Panic";
    vars.chips[42] = "AirSwrd";
    vars.chips[43] = "Slasher";
    vars.chips[44] = "ShockWav";
    vars.chips[45] = "SonicWav";
    vars.chips[46] = "DynaWave";
    vars.chips[47] = "GutPunch";
    vars.chips[48] = "GutStrgt";
    vars.chips[49] = "GutImpct";
    vars.chips[50] = "AirStrm1";
    vars.chips[51] = "AirStrm2";
    vars.chips[52] = "AirStrm3";
    vars.chips[53] = "DashAtk";
    vars.chips[54] = "Burner";
    vars.chips[55] = "Totem1";
    vars.chips[56] = "Totem2";
    vars.chips[57] = "Totem3";
    vars.chips[58] = "Ratton1";
    vars.chips[59] = "Ratton2";
    vars.chips[60] = "Ratton3";
    vars.chips[61] = "Wave";
    vars.chips[62] = "RedWave";
    vars.chips[63] = "MudWave";
    vars.chips[64] = "Hammer";
    vars.chips[65] = "Tornado";
    vars.chips[66] = "ZapRing1";
    vars.chips[67] = "ZapRing2";
    vars.chips[68] = "ZapRing3";
    vars.chips[69] = "Yo-Yo1";
    vars.chips[70] = "Yo-Yo2";
    vars.chips[71] = "Yo-Yo3";
    vars.chips[72] = "Spice1";
    vars.chips[73] = "Spice2";
    vars.chips[74] = "Spice3";
    vars.chips[75] = "Lance";
    vars.chips[76] = "Scuttlst";
    vars.chips[77] = "Momogra";
    vars.chips[78] = "Rope1";
    vars.chips[79] = "Rope2";
    vars.chips[80] = "Rope3";
    vars.chips[81] = "Magnum1";
    vars.chips[82] = "Magnum2";
    vars.chips[83] = "Magnum3";
    vars.chips[84] = "Boomer1";
    vars.chips[85] = "Boomer2";
    vars.chips[86] = "Boomer3";
    vars.chips[87] = "RndmMetr";
    vars.chips[88] = "HoleMetr";
    vars.chips[89] = "ShotMetr";
    vars.chips[90] = "IceWave1";
    vars.chips[91] = "IceWave2";
    vars.chips[92] = "IceWave3";
    vars.chips[93] = "Plasma1";
    vars.chips[94] = "Plasma2";
    vars.chips[95] = "Plasma3";
    vars.chips[96] = "Arrow1";
    vars.chips[97] = "Arrow2";
    vars.chips[98] = "Arrow3";
    vars.chips[99] = "TimeBomb";
    vars.chips[100] = "Mine";
    vars.chips[101] = "Sensor1";
    vars.chips[102] = "Sensor2";
    vars.chips[103] = "Sensor3";
    vars.chips[104] = "CrsShld1";
    vars.chips[105] = "CrsShld2";
    vars.chips[106] = "CrsShld3";
    vars.chips[107] = "Geyser";
    vars.chips[108] = "PoisMask";
    vars.chips[109] = "PoisFace";
    vars.chips[110] = "Shake1";
    vars.chips[111] = "Shake2";
    vars.chips[112] = "Shake3";
    vars.chips[113] = "BigWave";
    vars.chips[114] = "Volcano";
    vars.chips[115] = "Condor";
    vars.chips[116] = "Burning";
    vars.chips[117] = "FireRatn";
    vars.chips[118] = "Guard";
    vars.chips[119] = "PanlOut1";
    vars.chips[120] = "PanlOut3";
    vars.chips[121] = "Recov10";
    vars.chips[122] = "Recov30";
    vars.chips[123] = "Recov50";
    vars.chips[124] = "Recov80";
    vars.chips[125] = "Recov120";
    vars.chips[126] = "Recov150";
    vars.chips[127] = "Recov200";
    vars.chips[128] = "Recov300";
    vars.chips[129] = "PanlGrab";
    vars.chips[130] = "AreaGrab";
    vars.chips[131] = "Snake";
    vars.chips[132] = "Team1";
    vars.chips[133] = "MetaGel1";
    vars.chips[134] = "MetaGel2";
    vars.chips[135] = "MetaGel3";
    vars.chips[136] = "GrabBack";
    vars.chips[137] = "GrabRvng";
    vars.chips[138] = "Geddon1";
    vars.chips[139] = "Geddon2";
    vars.chips[140] = "Geddon3";
    vars.chips[141] = "RockCube";
    vars.chips[142] = "Prism";
    vars.chips[143] = "Wind";
    vars.chips[144] = "Fan";
    vars.chips[145] = "RockArm1";
    vars.chips[146] = "RockArm2";
    vars.chips[147] = "RockArm3";
    vars.chips[148] = "NoBeam1";
    vars.chips[149] = "NoBeam2";
    vars.chips[150] = "NoBeam3";
    vars.chips[151] = "Pawn";
    vars.chips[152] = "Knight";
    vars.chips[153] = "Rook";
    vars.chips[154] = "Needler1";
    vars.chips[155] = "Needler2";
    vars.chips[156] = "Needler3";
    vars.chips[157] = "SloGauge";
    vars.chips[158] = "FstGauge";
    vars.chips[159] = "Repair";
    vars.chips[160] = "Invis";
    vars.chips[161] = "Hole";
    vars.chips[162] = "Mole1";
    vars.chips[163] = "Mole2";
    vars.chips[164] = "Mole3";
    vars.chips[165] = "Shadow";
    vars.chips[166] = "Mettaur";
    vars.chips[167] = "Bunny";
    vars.chips[168] = "AirShoes";
    vars.chips[169] = "Team2";
    vars.chips[170] = "Fanfare";
    vars.chips[171] = "Discord";
    vars.chips[172] = "Timpani";
    vars.chips[173] = "Barrier";
    vars.chips[174] = "Barr100";
    vars.chips[175] = "Barr200";
    vars.chips[176] = "Aura";
    vars.chips[177] = "NrthWind";
    vars.chips[178] = "HolyPanl";
    vars.chips[179] = "LavaStge";
    vars.chips[180] = "IceStage";
    vars.chips[181] = "GrassStg";
    vars.chips[182] = "SandStge";
    vars.chips[183] = "MetlStge";
    vars.chips[184] = "Snctuary";
    vars.chips[185] = "Swordy";
    vars.chips[186] = "Spikey";
    vars.chips[187] = "Mushy";
    vars.chips[188] = "Jelly";
    vars.chips[189] = "KillrEye";
    vars.chips[190] = "AntiNavi";
    vars.chips[191] = "AntiDmg";
    vars.chips[192] = "AntiSwrd";
    vars.chips[193] = "AntiRecv";
    vars.chips[194] = "CopyDmg";
    vars.chips[195] = "Atk+10";
    vars.chips[196] = "Fire+30";
    vars.chips[197] = "Aqua+30";
    vars.chips[198] = "Elec+30";
    vars.chips[199] = "Wood+30";
    vars.chips[200] = "Navi+20";
    vars.chips[201] = "LifeAura";
    vars.chips[202] = "Muramasa";
    vars.chips[203] = "Guardian";
    vars.chips[204] = "Anubis";
    vars.chips[205] = "Atk+30";
    vars.chips[206] = "Navi+40";
    vars.chips[207] = "HeroSwrd";
    vars.chips[208] = "ZeusHamr";
    vars.chips[209] = "GodStone";
    vars.chips[210] = "OldWood";
    vars.chips[211] = "FullCust";
    vars.chips[212] = "Meteors";
    vars.chips[213] = "Poltrgst";
    vars.chips[214] = "Jealousy";
    vars.chips[215] = "StandOut";
    vars.chips[216] = "WatrLine";
    vars.chips[217] = "Ligtning";
    vars.chips[218] = "GaiaSwrd";
    vars.chips[219] = "Roll V1";
    vars.chips[220] = "Roll V2";
    vars.chips[221] = "Roll V3";
    vars.chips[222] = "GutsMan V1";
    vars.chips[223] = "GutsMan V2";
    vars.chips[224] = "GutsMan V3";
    vars.chips[225] = "GutsMan V4";
    vars.chips[226] = "GutsMan V5";
    vars.chips[227] = "ProtoMan V1";
    vars.chips[228] = "ProtoMan V2";
    vars.chips[229] = "ProtoMan V3";
    vars.chips[230] = "ProtoMan V4";
    vars.chips[231] = "Protoman V5";
    vars.chips[232] = "FlashMan V1";
    vars.chips[233] = "FlashMan V2";
    vars.chips[234] = "FlashMan V3";
    vars.chips[235] = "FlashMan V4";
    vars.chips[236] = "FlashMan V5";
    vars.chips[237] = "BeastMan V1";
    vars.chips[238] = "BeastMan V2";
    vars.chips[239] = "BeastMan V3";
    vars.chips[240] = "BeastMan V4";
    vars.chips[241] = "BeastMan V5";
    vars.chips[242] = "BubblMan V1";
    vars.chips[243] = "BubblMan V2";
    vars.chips[244] = "BubblMan V3";
    vars.chips[245] = "BubblMan V4";
    vars.chips[246] = "BubblMan V5";
    vars.chips[247] = "DesrtMan V1";
    vars.chips[248] = "DesrtMan V2";
    vars.chips[249] = "DesrtMan V3";
    vars.chips[250] = "DesrtMan V4";
    vars.chips[251] = "DesrtMan V5";
    vars.chips[252] = "PlantMan V1";
    vars.chips[253] = "PlantMan V2";
    vars.chips[254] = "PlantMan V3";
    vars.chips[255] = "PlantMan V4";
    vars.chips[256] = "PlantMan V5";
    vars.chips[257] = "FlamMan V1";
    vars.chips[258] = "FlamMan V2";
    vars.chips[259] = "FlamMan V3";
    vars.chips[260] = "FlamMan V4";
    vars.chips[261] = "FlamMan V5";
    vars.chips[262] = "DrillMan V1";
    vars.chips[263] = "DrillMan V2";
    vars.chips[264] = "DrillMan V3";
    vars.chips[265] = "DrillMan V4";
    vars.chips[266] = "DrillMan V5";
    vars.chips[267] = "MetalMan V1";
    vars.chips[268] = "MetalMan V2";
    vars.chips[269] = "MetalMan V3";
    vars.chips[270] = "MetalMan V4";
    vars.chips[271] = "MetalMan V5";
    vars.chips[272] = "Punk";
    vars.chips[273] = "Salamndr";
    vars.chips[274] = "Fountain";
    vars.chips[275] = "Bolt";
    vars.chips[276] = "GaiaBlad";
    vars.chips[277] = "KingMan V1";
    vars.chips[278] = "KingMan V2";
    vars.chips[279] = "KingMan V3";
    vars.chips[280] = "KingMan V4";
    vars.chips[281] = "KingMan V5";
    vars.chips[282] = "MistMan V1";
    vars.chips[283] = "MistMan V2";
    vars.chips[284] = "MistMan V3";
    vars.chips[285] = "MistMan V4";
    vars.chips[286] = "MistMan V5";
    vars.chips[287] = "BowlMan V1";
    vars.chips[288] = "BowlMan V2";
    vars.chips[289] = "BowlMan V3";
    vars.chips[290] = "BowlMan V4";
    vars.chips[291] = "BowlMan V5";
    vars.chips[292] = "DarkMan V1";
    vars.chips[293] = "DarkMan V2";
    vars.chips[294] = "DarkMan V3";
    vars.chips[295] = "DarkMan V4";
    vars.chips[296] = "DarkMan V5";
    vars.chips[297] = "JapanMan V1";
    vars.chips[298] = "JapanMan V2";
    vars.chips[299] = "JapanMan V3";
    vars.chips[300] = "JapanMan V4";
    vars.chips[301] = "JapanMan V5";
    vars.chips[302] = "DeltaRay";
    vars.chips[303] = "FoldrBak";
    vars.chips[304] = "NavRcycl";
    vars.chips[305] = "AlphArmSigma";
    vars.chips[306] = "Bass";
    vars.chips[307] = "Serenade";
    vars.chips[308] = "Balance";
    vars.chips[309] = "DarkAura";
    vars.chips[310] = "AlphArmOmega";
    vars.chips[311] = "Bass+";
    vars.chips[312] = "BassGS";
    vars.chips[320] = "Z-Canon1";
    vars.chips[321] = "Z-Canon2";
    vars.chips[322] = "Z-Canon3";
    vars.chips[323] = "Z-Punch";
    vars.chips[324] = "Z-Strght";
    vars.chips[325] = "Z-Impact";
    vars.chips[326] = "Z-Varibl";
    vars.chips[327] = "Z-Yoyo1";
    vars.chips[328] = "Z-Yoyo2";
    vars.chips[329] = "Z-Yoyo3";
    vars.chips[330] = "Z-Step1";
    vars.chips[331] = "Z-Step2";
    vars.chips[332] = "TimeBom+";
    vars.chips[333] = "H-Burst";
    vars.chips[334] = "BubSprd";
    vars.chips[335] = "HeatSprd";
    vars.chips[336] = "LifeSwrd";
    vars.chips[337] = "ElemSwrd";
    vars.chips[338] = "EvilCut";
    vars.chips[339] = "2xHero";
    vars.chips[340] = "HyperRat";
    vars.chips[341] = "EverCrse";
    vars.chips[342] = "GelRain";
    vars.chips[343] = "PoisPhar";
    vars.chips[344] = "BodyGrd";
    vars.chips[345] = "500Barr";
    vars.chips[346] = "BigHeart";
    vars.chips[347] = "GtsShoot";
    vars.chips[348] = "DeuxHero";
    vars.chips[349] = "MomQuake";
    vars.chips[350] = "PrixPowr";
    vars.chips[351] = "MstrStyl";
    vars.chips[384] = "Backup";

    ReadSettingsXML(vars.GameSettings.Elements("setting"), null);
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<byte>("GameLoadingFlag", 0x02001880);
        emu.Make<byte>("MainArea", 0x02001884);
        emu.Make<byte>("SubArea", 0x02001885);
        emu.Make<byte>("Progress", 0x02001886);
        emu.Make<byte>("BattleState", 0x0200F887);
        emu.Make<byte>("StartSound", 0x02006680);
        emu.Make<byte>("EnemyNo1", 0x02006D00);
        emu.Make<byte>("EnemyNo2", 0x02006D01);
        emu.Make<byte>("EnemyNo3", 0x02006D02);
        emu.Make<byte>("GameState", 0x020097F8);
        emu.Make<ushort>("BattleReward", 0x0200F332);
        emu.Make<short>("EnemyNo1HP", 0x02037368);
        emu.Make<short>("EnemyNo2HP", 0x0203743C);
        emu.Make<short>("EnemyNo3HP", 0x02037510);

        return true;
    });

    vars.SplitonExitBattle = false;
}

start
{
    return vars.Helper["StartSound"].Changed && vars.Helper["StartSound"].Current == 128;
}

update
{
     if (vars.Helper["EnemyNo1HP"].Changed)
    {
        print("Enemy #1 HP is: " + vars.Helper["EnemyNo1HP"].Current.ToString());
    }
    if (vars.Helper["EnemyNo2HP"].Changed)
    {
        print("Enemy #2 HP is: " + vars.Helper["EnemyNo2HP"].Current.ToString());
    }
    if (vars.Helper["EnemyNo3HP"].Changed)
    {
        print("Enemy #3 HP is: " + vars.Helper["EnemyNo3HP"].Current.ToString());
    }
    if (vars.Helper["StartSound"].Changed)
    {
        print("StartSound changed. Current value is: " + vars.Helper["StartSound"].Current.ToString());
    }
    if (vars.Helper["GameState"].Changed)
    {
        print("GameState changed. Current value is: " + vars.Helper["GameState"].Current.ToString());
    }
    if (vars.Helper["GameLoadingFlag"].Changed)
    {
        print("GameLoadingFlag changed. Current value is: " + vars.Helper["GameLoadingFlag"].Current.ToString());
    }
    if (vars.Helper["BattleReward"].Changed)
    {
        ushort battlereward = vars.Helper["BattleReward"].Current;
        if ((battlereward & 0x4000) != 0)
        {
            // It's Zenny
            print("BattleReward received: " + (battlereward & ~0x4000).ToString() + " Zenny");
        }
        else
        {
            // Cheeps
            int code = (vars.Helper["BattleReward"].Current & 0xfe00) >> 9;
            int chip = vars.Helper["BattleReward"].Current & 0x1ff;

            if (code != 0 && chip != 0)
            {
                if (code >=0 && code <= 32 && chip >=0 && chip <= 384)
                {
                    print("BattleReward received: " + vars.chips[chip].ToString() + " " + vars.codes[code].ToString());
                }
                else
                {
                    print("BattleReward changed to unknown value. BattleReward is: Code: " + ((vars.Helper["BattleReward"].Current & 0xfe00) >> 9).ToString() + ", Value: " + (vars.Helper["BattleReward"].Current & 0x1ff).ToString());
                }
            }
        }
    }
    if (vars.Helper["MainArea"].Changed)
    {
        print("MainArea changed. Current value is: " + vars.Helper["MainArea"].Current.ToString());
    }
    if (vars.Helper["SubArea"].Changed)
    {
        print("SubArea changed. Current value is: " + vars.Helper["SubArea"].Current.ToString());
    }
    if (vars.Helper["EnemyNo1"].Changed)
    {
        print("Enemy #1 is: " + vars.Helper["EnemyNo1"].Current.ToString());
    }
    if (vars.Helper["EnemyNo2"].Changed)
    {
        print("Enemy #2 is: " + vars.Helper["EnemyNo2"].Current.ToString());
    }
    if (vars.Helper["EnemyNo3"].Changed)
    {
        print("Enemy #3 is: " + vars.Helper["EnemyNo3"].Current.ToString());
    }
    if (vars.Helper["Progress"].Changed)
    {
        print("Progress changed. Current value is: " + vars.Helper["Progress"].Current.ToString());
    }
}

split
{
	foreach (var element in vars.GameSettings.Descendants("setting"))
	{
		if (settings[element.Attribute("id").Value])
		{
            if (element.Attribute("check") != null && element.Attribute("value") != null)
			{
				string check = element.Attribute("check").Value;

				switch(check)
				{
					case "BossDefeated":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.CheckBossDefeated(value)) 
							{
								print("Boss Defeated: " + element.Attribute("name").Value);
								vars.SplitonExitBattle = true;
							}
						}
						break;

					case "Progress":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.CheckProgress(value)) 
							{
								print("Progress Split: " + element.Attribute("name").Value);
								return true;
							}
						}
						break;

                    case "BattleRewardGet":
						{
							ushort value = UInt16.Parse(element.Attribute("value").Value);
							if (vars.CheckBattleReward(value))
							{
								print("Reward ID Split: " + element.Attribute("name").Value);
                                vars.SplitonExitBattle = true;
							}
						}
                        break;

					case "N1Prelims3":
						if (vars.CheckN1Prelims3())
						{
							print("N1 Prelims 3 Split");
							return true;
						}
						break;

                    // case "BLicenseExam":
					// 	{
					// 		byte value = Byte.Parse(element.Attribute("value").Value);
					// 		if (vars.CheckBossDefeated(value)) 
					// 		{
					// 			print("Boss Defeated: " + element.Attribute("name").Value);
					// 			return true;
					// 		}
					// 	}
					// 	break;
					
				}
				
			}
		}
	}
    if (vars.SplitonExitBattle && vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 4)
	{
        print("Exiting Battle: SPLITTING");
		vars.SplitonExitBattle = false;
		return true;
	}
}