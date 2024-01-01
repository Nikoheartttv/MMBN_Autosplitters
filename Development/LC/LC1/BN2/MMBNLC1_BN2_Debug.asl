state("MMBN_LC1", "30.10.23") 
{
	// --- Main Menu of Legacy Collection
	byte LC1_GameChoice : 0x9875A74; // BN1 = 0, BN2 = 2, BN3W = 3, BN3B = 4
	byte LC1_GameSelected : 0x2803B70; // when chosen, value turns 0

	byte GameState : 0x29C9930, 0xB8, 0x0; // 28 on ng/continue select - 0 is hit when selecting "Return to Title Screen"
	byte MainArea : 0x29C9930, 0xB8, 0x4;
	byte SubArea : 0x29C9930, 0xB8, 0x5;
	byte Progress : 0x29C9930, 0xB8, 0x6;
	// int KeyItems : 0x29EE840, 0xB8, 0xC0;
	byte EnemyNo1 : 0x29C9930, 0x50, 0x0;
	byte EnemyNo2 : 0x29C9930, 0x50, 0x4;
	byte EnemyNo3 : 0x29C9930, 0x50, 0x8;
	short EnemyNo1HP : 0x29CE2A8, 0x20;
	short EnemyNo2HP : 0x29CE2A8, 0xE0;
	short EnemyNo3HP : 0x229CE2A8, 0x1A0;
	byte Key_Hig_Memo : 0x29C9930, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29C9930, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29C9930, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29C9930, 0xB8, 0xF7;
	byte NewGameStart : 0x29CA9EA; 
	// short MMBN1_FinalSplit : 0x29F21F8, 0x4;
	// GameLoadingFlag / BattleState / StartSound / FinalScene / FinalDing
}

state("MMBN_LC1", "Unknown Version") 
{
	byte GameState : 0x29EE840, 0xB8, 0x0; // 28 on ng/continue select - 0 is hit when selecting "Return to Title Screen"
	byte MainArea : 0x29EE840, 0xB8, 0x4;
	byte SubArea : 0x29EE840, 0xB8, 0x5;
	byte Progress : 0x29EE840, 0xB8, 0x6;
	// int KeyItems : 0x29EE840, 0xB8, 0xC0;
	byte EnemyNo1 : 0x29EE840, 0x50, 0x0;
	byte EnemyNo2 : 0x29EE840, 0x50, 0x4;
	byte EnemyNo3 : 0x29EE840, 0x50, 0x8;
	short EnemyNo1HP : 0x29F21F8, 0x60;
	short EnemyNo2HP : 0x29F21F8, 0x110;
	short EnemyNo3HP : 0x29F21F8, 0x1C0;
	byte Key_Hig_Memo : 0x29EE840, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29EE840, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29EE840, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29EE840, 0xB8, 0xF7;
	// byte StartSound : 
	// short MMBN1_FinalSplit : 0x29F21F8, 0x4;
	// GameLoadingFlag / BattleState / StartSound / FinalScene / FinalDing
}

startup
{
	if (timer.CurrentTimingMethod == TimingMethod.GameTime)
	{
		var timingMessage = MessageBox.Show (
			"This game uses Real Time (RTA) as the main timing method.\n"+
			"LiveSplit is currently set to show Time without Loads (Game Time).\n"+
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

    // vars.CheckBossDeleted = (Func<byte, bool>)((bossId) =>
	// {
    //     if (current.GameState != 8) return false;
	// 	if (current.EnemyNo1 == bossId && old.EnemyNo1HP > 0 && current.EnemyNo1HP == 0 ||
	// 		current.EnemyNo2 == bossId && old.EnemyNo2HP > 0 && current.EnemyNo2HP == 0 ||
	// 		current.EnemyNo3 == bossId && old.EnemyNo3HP > 0 && current.EnemyNo3HP == 0 )
	// 	{
	// 		return true;
	// 	}

	// 	return false;
	// });

	// vars.CheckBossDefeated = (Func<byte, bool>)((bossId) =>
	// {
	// 	if (current.EnemyNo1 == bossId && current.EnemyNo1HP == 0 ||
	// 		current.EnemyNo2 == bossId && current.EnemyNo2HP == 0 ||
	// 		current.EnemyNo3 == bossId && current.EnemyNo3HP == 0)
	// 	{
	// 		return old.GameState == 8 && current.GameState == 4;
	// 	}
	// 	return false;
	// });

    // vars.CheckProgress = (Func<byte, bool>)((value) =>
	// {
	// 	if (old.Progress != current.Progress && current.Progress == value) return true;
	// 	return false;
	// });

	// vars.CheckMemos = (Func<bool>)(() =>
    // {
	// 	if (vars.MemosSplitDone) return false;
    //     if (current.Key_Hig_Memo == 1 && current.Key_Lab_Memo == 1 &&
    //         current.Key_Pa_Memo == 1 && current.Key_Yuri_Memo == 1 &&
	// 		current.MainArea == 2 && current.SubArea == 5 &&
	// 		old.GameState != current.GameState && current.GameState == 12)
	// 	{
	// 		return true;
	// 	}
        
    //     return false;
    // });

	// vars.CheckCompleted = (Func<bool>)(() =>
	// {
    //     if (current.FinalScene == 64 && old.FinalDing != current.FinalDing && current.FinalDing == 128)
    //     {
    //         return true;
    //     }

	// 	return false;
	// });

    var xml = System.Xml.Linq.XDocument.Load(@"Components/MMBN.Settings.xml");
    foreach (var element in xml.Element("settings").Elements("setting"))
    {
        if (element.Attribute("id").Value == "BN1")
        {
            vars.GameSettings = element;
            break;
        }
    }

	ReadSettingsXML(vars.GameSettings.Elements("setting"), null);
}

init
{
	byte[] exeMD5HashBytes = new byte[0];
    using (var md5 = System.Security.Cryptography.MD5.Create())
    {
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
        {
            exeMD5HashBytes = md5.ComputeHash(s);
        }
    }
    
    var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    vars.MD5Hash = MD5Hash;
    print("MD5: " + MD5Hash);

	switch(MD5Hash)
	{
		case "74423E3FB22472E5798855ED22691A1B": //30.10.23
			version = "30.10.23";
			break;
		default:
			version = "Unknown Version";
			break;
	}
	
	// current.GameState = 0;
	// current.MainArea = 0;
	// current.SubArea = 0;
	// current.Progress = 0;
	// current.EnemyNo1 = 0;
	// current.EnemyNo2 = 0;
	// current.EnemyNo3 = 0;
	// current.EnemyNo1HP = 0;
	// current.EnemyNo2HP = 0;
	// current.EnemyNo3HP = 0;
	// current.Key_Hig_Memo = 0;
	// current.Key_Lab_Memo = 0;
	// current.Key_Yuri_Memo = 0;
	// current.Key_Pa_Memo = 0;

	vars.HasBeeninCoffeeMachine = false;
	vars.SplitOnExitBattle = false;
}

start
{
    return old.NewGameStart != current.NewGameStart && current.NewGameStart == 128;
}

onStart
{
	vars.HasBeeninCoffeeMachine = false;
	vars.SplitOnExitBattle = false;
}

update
{
	//vars.CheckHasBeenInCoffeeMachine(); ??
    if (old.NewGameStart != current.NewGameStart && current.NewGameStart == 128)
    {
        print("New Game Started changed");
    }

    if (old.Key_Hig_Memo != current.Key_Hig_Memo) print("Hig Memo Get");
	if (old.Key_Lab_Memo != current.Key_Lab_Memo) print("Lab Memo Get");
	if (old.Key_Pa_Memo != current.Key_Pa_Memo) print("Pa Memo Get");
	if (old.Key_Yuri_Memo != current.Key_Yuri_Memo) print("Yuri Memo Get");

	if (old.MainArea != current.MainArea) print("MainArea changed from " + old.MainArea.ToString() + " to " + current.MainArea.ToString());
    if (old.SubArea != current.SubArea) print("SubArea changed from " + old.SubArea.ToString() + " to " + current.SubArea.ToString());
    if (old.Progress != current.Progress) print("Progress changed from " + old.Progress.ToString() + " to " + current.Progress.ToString());
    if (old.EnemyNo1 != current.EnemyNo1) print("EnemyNo1 changed from " + old.EnemyNo1.ToString() + " to " + current.EnemyNo1.ToString());
    if (old.EnemyNo2 != current.EnemyNo2) print("EnemyNo2 changed from " + old.EnemyNo2.ToString() + " to " + current.EnemyNo2.ToString());
    if (old.EnemyNo3 != current.EnemyNo3) print("EnemyNo3 changed from " + old.EnemyNo3.ToString() + " to " + current.EnemyNo3.ToString());
    if (old.GameState != current.GameState) print("GameState changed from " + old.GameState.ToString() + " to " + current.GameState.ToString());
    if (old.EnemyNo1HP != current.EnemyNo1HP) print("EnemyNo1HP changed from " + old.EnemyNo1HP.ToString() + " to " + current.EnemyNo1HP.ToString());
    if (old.EnemyNo2HP != current.EnemyNo2HP) print("EnemyNo2HP changed from " + old.EnemyNo2HP.ToString() + " to " + current.EnemyNo2HP.ToString());
    if (old.EnemyNo3HP != current.EnemyNo3HP) print("EnemyNo3HP changed from " + old.EnemyNo3HP.ToString() + " to " + current.EnemyNo3HP.ToString());
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
							if ((current.EnemyNo1 == value && current.EnemyNo1HP == 0 && old.EnemyNo1HP != 0) ||
								(current.EnemyNo2 == value && current.EnemyNo2HP == 0 && old.EnemyNo2HP != 0) ||
								(current.EnemyNo3 == value && current.EnemyNo3HP == 0 && old.EnemyNo3HP != 0))
							{
								print("Boss Defeated: " + element.Attribute("name").Value);
								vars.SplitOnExitBattle = true;
							}
						}
						break;

					case "BossRush":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (current.MainArea == 133) {
								if (current.EnemyNo1 == value && current.EnemyNo1HP == 0 && old.EnemyNo1HP != 0)
								{
									print("Boss Rush Defeated: " + element.Attribute("name").Value);
									vars.SplitOnExitBattle = true;
								} 
							}
						}
						break;

					case "Progress":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (old.Progress != current.Progress && current.Progress == value)
							{
								print("Progress Split: " + element.Attribute("name").Value);
								return true;
							}
						}
						break;

					case "Doghouse":
						if (old.MainArea == 140 && old.SubArea == 2 && current.MainArea == 0 && current.SubArea == 0)
						{
							print("Doghouse Split");
							return true;
						}
						break;
					
				}
				
			}
		}
	}

	if (vars.SplitOnExitBattle && old.GameState == 12 && current.GameState != 12)
	{
        print("Splitting on exit battle");
		vars.SplitOnExitBattle = false;
		return true;
	}

    // if (vars.CheckCompleted()) return true;
}








    vars.CheckHasBeenInCoffeeMachine = (Action)(() =>
    {
        if (!vars.HasBeeninCoffeeMachine)
        {
            if (vars.Helper["MainArea"].Current == 140 && vars.Helper["SubArea"].Current == 5) vars.HasBeeninCoffeeMachine = true;
        }
    });

    vars.CheckBLicense = (Func<bool>)(() =>
	{
		if (vars.Helper["Progress"].Current == 9 && vars.Helper["MainArea"].Current == 144 && vars.Helper["SubArea"].Current == 4)
        {
            if (vars.Helper["EnemyNo1"].Current == 29 && vars.Helper["EnemyNo1HP"].Current == 0 ||
			    vars.Helper["EnemyNo2"].Current == 29 && vars.Helper["EnemyNo2HP"].Current == 0 ||
			    vars.Helper["EnemyNo3"].Current == 7 && vars.Helper["EnemyNo3HP"].Current == 0)
            {
                return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
            }
        }
        return false;
	});

    vars.CheckALicensePrelims = (Func<bool>)(() =>
    {
        if (vars.HasBeeninCoffeeMachine && vars.Helper["Progress"].Current == 18 &&
            vars.Helper["MainArea"].Old == 145 && vars.Helper["SubArea"].Old == 3 &&
            vars.Helper["MainArea"].Current == 1 && vars.Helper["SubArea"].Current == 2)
            {
                return true;
            } 
        return false;
    });

    vars.CheckALicense = (Func<bool>)(() =>
	{
		if (vars.Helper["Progress"].Current == 19 && vars.Helper["MainArea"].Current == 144 && vars.Helper["SubArea"].Current == 4)
        {
            if (vars.Helper["EnemyNo1"].Current == 69 && vars.Helper["EnemyNo1HP"].Current == 0 ||
			    vars.Helper["EnemyNo2"].Current == 38 && vars.Helper["EnemyNo2HP"].Current == 0 ||
			    vars.Helper["EnemyNo3"].Current == 24 && vars.Helper["EnemyNo3HP"].Current == 0)
            {
                return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
            }
        }
        return false;
	});

    vars.CheckProgress = (Func<byte, bool>)((value) =>
	{
		if (vars.Helper == null || vars.Helper["Progress"] == null) return false;
		if (vars.Helper["Progress"].Changed && vars.Helper["Progress"].Current == value) return true;
		return false;
	});

	vars.CheckCompleted = (Func<bool>)(() =>
	{
		if (vars.Helper["Progress"].Current != 72 || vars.Helper["MainArea"].Current != 2 || vars.Helper["SubArea"].Current != 4) return false;
        if (vars.Helper["FinalDing"].Old == 0 && vars.Helper["FinalDing"].Current == 128)
        {
            return true;
        }

		return false;
	});

	vars.CheckHeatData = (Func<bool>)(() =>
	{
		if (vars.Helper["KeyItem_HeatData"].Old == 0 && vars.Helper["KeyItem_HeatData"].Current == 1) return true;
		return false;
	});
	

					
				
					case "BLicense":
						if (vars.CheckBLicense())
						{
							print("BLicense Split");
							return true;
						}
						break;


					if (current.Progress == 9 && current.MainArea == 144 && current.SubArea"].Current == 4)
					{
						if (vars.Helper["EnemyNo1"].Current == 29 && vars.Helper["EnemyNo1HP"].Current == 0 ||
							vars.Helper["EnemyNo2"].Current == 29 && vars.Helper["EnemyNo2HP"].Current == 0 ||
							vars.Helper["EnemyNo3"].Current == 7 && vars.Helper["EnemyNo3HP"].Current == 0)
						{
							return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
						}
					}
					return false;

					case "ALicensePrelims":
						if (vars.CheckALicensePrelims())
						{
							print("ALicensePrelims Split");
							return true;
						}
						break;

					case "ALicense":
						if (vars.CheckALicense())
						{
							print("ALicense Split");
							return true;
						}
						break;

					case "HeatData":
						if (vars.CheckHeatData())
						{
							print("Heat Data Split");
							return true;
						}
						break;
				}
				
			}
		}
	}

	if (vars.SplitOnExitBattle && old.GameState == 12 && current.GameState != 12)
	{
        print("Splitting on exit battle");
		vars.SplitOnExitBattle = false;
		return true;
	}

    if (vars.CheckCompleted()) return true;
}