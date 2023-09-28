state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");

    // Function Definitions
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
		if (vars.Helper["EnemyNo1"].Current == bossId && vars.Helper["EnemyNo1HP"].Current == 0 ||
			vars.Helper["EnemyNo2"].Current == bossId && vars.Helper["EnemyNo2HP"].Current == 0 ||
			vars.Helper["EnemyNo3"].Current == bossId && vars.Helper["EnemyNo3HP"].Current == 0)
		{
			return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
		}
		return false;
	});

    vars.CheckProgress = (Func<byte, bool>)((value) =>
	{
		if (vars.Helper == null || vars.Helper["Progress"] == null) return false;
		if (vars.Helper["Progress"].Changed && vars.Helper["Progress"].Current == value) return true;
		return false;
	});

	vars.CheckMemos = (Func<bool>)(() =>
    {
		if (vars.MemosSplitDone) return false;
        if (vars.Helper == null ||
            vars.Helper["Key_Hig_Memo"] == null ||
            vars.Helper["Key_Lab_Memo"] == null ||
            vars.Helper["Key_Pa_Memo"] == null ||
            vars.Helper["Key_Yuri_Memo"] == null) return false;

        if (vars.Helper["Key_Hig_Memo"].Current && vars.Helper["Key_Lab_Memo"].Current &&
            vars.Helper["Key_Pa_Memo"].Current && vars.Helper["Key_Yuri_Memo"].Current &&
			vars.Helper["MainArea"].Current == 2 && vars.Helper["SubArea"].Current == 5 &&
			vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 12)
		{
			return true;
		}
        
        return false;
    });

	// this doesn't current work, but works as normal splitting function
	vars.CheckCompleted = (Func<bool>)(() =>
	{
		if (vars.Helper == null || vars.Helper["FinalScene"] == null || vars.Helper["FinalDing"] == null) return false;
        if (vars.Helper["FinalScene"].Current == 64 && vars.Helper["FinalDing"].Changed && vars.Helper["FinalDing"].Current == 128)
        {
            return true;
        }

		return false;
	});

    // End function definitions

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
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<byte>("FinalScene", 0x0200001F);
		emu.Make<byte>("GameLoadingFlag", 0x02000210);
        emu.Make<byte>("MainArea", 0x02000214);
        emu.Make<byte>("SubArea", 0x02000215);
        emu.Make<byte>("Progress", 0x02000216);
        emu.Make<bool>("Key_Hig_Memo", 0x02000304);
        emu.Make<bool>("Key_Lab_Memo", 0x02000305);
        emu.Make<bool>("Key_Pa_Memo", 0x02000306);
        emu.Make<bool>("Key_Yuri_Memo", 0x02000307);
		emu.Make<byte>("FinalDing", 0x020030A8);
		emu.Make<byte>("BattleState", 0x02003712);
        emu.Make<byte>("EnemyNo1", 0x02003774);
        emu.Make<byte>("EnemyNo2", 0x02003775);
        emu.Make<byte>("EnemyNo3", 0x02003776);
        emu.Make<short>("EnemyNo1HP", 0x02006790);
        emu.Make<short>("EnemyNo2HP", 0x02006850);
        emu.Make<short>("EnemyNo3HP", 0x02006910);
        emu.Make<byte>("GameState", 0x02006CB8);
		
        return true;
    });

	vars.MemosSplitDone = false;
}

start
{
    return (old.GameState == 0 && current.GameState != 0);
}

onStart
{
	vars.MemosSplitDone = false;
}

update
{
    // if (vars.Helper["BattleState"].Changed)
    // {
    //     print("BattleState changed. Current area is: " + vars.Helper["BattleState"].Current.ToString());
    // }
    if (vars.Helper["GameState"].Changed)
    {
        print("GameState changed. Current area is: " + vars.Helper["GameState"].Current.ToString());
    }
    if (vars.Helper["GameLoadingFlag"].Changed)
    {
        print("GameLoadingFlag changed. Current area is: " + vars.Helper["GameLoadingFlag"].Current.ToString());
    }
    // if (vars.Helper["EnemyNo1"].Changed)
    // {
    //     print("EnemyNo1 changed. Current EnemyNo1 is: " + vars.Helper["EnemyNo1"].Current.ToString());
    // }
    // if (vars.Helper["EnemyNo2"].Changed)
    // {
    //     print("EnemyNo2 changed. Current EnemyNo2 is: " + vars.Helper["EnemyNo2"].Current.ToString());
    // }
    // if (vars.Helper["EnemyNo3"].Changed)
    // {
    //     print("EnemyNo3 changed. Current EnemyNo3 is: " + vars.Helper["EnemyNo3"].Current.ToString());
    // }
    if (vars.Helper["MainArea"].Changed)
    {
        print("MainArea changed. Current area is: " + vars.Helper["MainArea"].Current.ToString());
    }
    if (vars.Helper["SubArea"].Changed)
    {
        print("SubArea changed. Current area is: " + vars.Helper["SubArea"].Current.ToString());
    }
	if (vars.Helper["Progress"].Changed)
    {
        print("Progress changed. Current area is: " + vars.Helper["Progress"].Current.ToString());
    }
	if (vars.Helper["FinalDing"].Changed)
    {
        print("FinalDing changed. Current value is: " + vars.Helper["FinalDing"].Current.ToString());
    }
	if (vars.Helper["FinalScene"].Changed)
    {
        print("FinalScene changed. Current value is: " + vars.Helper["FinalScene"].Current.ToString());
    }

    if (vars.Helper["Key_Hig_Memo"].Changed && vars.Helper["Key_Hig_Memo"].Current) print("Hig Memo Get");
    if (vars.Helper["Key_Lab_Memo"].Changed && vars.Helper["Key_Lab_Memo"].Current) print("Lab Memo Get");
    if (vars.Helper["Key_Pa_Memo"].Changed && vars.Helper["Key_Pa_Memo"].Current) print("Pa Memo Get");
    if (vars.Helper["Key_Yuri_Memo"].Changed && vars.Helper["Key_Yuri_Memo"].Current) print("Yuri Memo Get");
}

split
{
	foreach (var element in vars.GameSettings.Descendants("setting"))
	{
		if (settings[element.Attribute("id").Value])
		{
			// 09.09.23 Addition - rewardid additions may work but CheckBattleReward needs to be fixed first
            // if (element.Attribute("check") != null && element.Attribute("enemyid") != null && element.Attribute("rewardid") != null) < potential line to use
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
								return true;
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

                    case "Memos":
                        {
                            if (vars.CheckMemos())
                            {
                                print("Memos Split");
								vars.MemosSplitDone = true;
                                return true;
                            }
                        }
                        break;
					
					// case "Completed":
                    //     {
					// 		if (vars.Helper["FinalDing"].Changed && vars.Helper["FinalDing"].Current == 128)
					// 		{
					// 			return true;
					// 		}
                    //         // if (vars.CheckCompleted())
                    //         // {
                    //         //     print("--- GAME COMPLETED ---");
                    //         //     return true;
                    //         // }
                    //     }
                    //     break;

					// make below function blah blah blah
					// case "Ending": < also check progress as well of GameState
                    //     {
                    //         if (vars.Helper["GameState"].Changed && vars.Helper["GameState"] == 40)
					// 		return true;
                    //     }
                    // 	break;

					// case "BattleRewardGet":
					// 	{
					// 		ushort value = UInt16.Parse(element.Attribute("value").Value);
					// 		if (vars.CheckBattleReward(value))
					// 		{
					// 			print("Reward ID: " + element.Attribute("name").Value);
					// 			return true;
					// 		}
					// 	}
                    //     break;
				}
				
			}
		}
	}

    if (vars.CheckCompleted()) return true;
}