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

    vars.CheckToraJobsCompleted = (Func<bool>)(() =>
    {
        if (vars.Helper["Progress"].Current == 66 && vars.Helper["MainArea"].Current == 2 && vars.Helper["SubArea"].Current == 1)
        {
            if (vars.Helper["ToraJobs"].Old == 0 && vars.Helper["ToraJobs"].Current == 1)
            {
                return true;
            }
        }
        return false;
    });

    vars.CheckFiresStarted = (Func<bool>)(() =>
    {
        if (vars.HasSplitForFiresStarted) return false;
        if (vars.Helper["Progress"].Current == 85 && vars.Helper["MainArea"].Current == 0 && vars.Helper["SubArea"].Current == 3
            && vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 12)
        {
            return true;
        }
        return false;
    });

    vars.CheckRank10Fight = (Func<bool>)(() =>
    {
        if (vars.Helper["GameState"].Current != 8) return false;
        if (vars.Helper["Progress"].Current == 98 && vars.Helper["MainArea"].Current == 147 && vars.Helper["SubArea"].Current == 3 &&
            vars.Helper["EnemyNo1"].Current == 86 && vars.Helper["EnemyNo1HP"].Changed && vars.Helper["EnemyNo1HP"].Current == 0 && 
            vars.Helper["EnemyNo2"].Current == 123 && vars.Helper["EnemyNo2HP"].Changed && vars.Helper["EnemyNo2HP"].Current == 0)
        {
            return true;
        }
        return false;
    });

	vars.CheckCompleted = (Func<bool>)(() =>
	{
		if (vars.Helper["Progress"].Current != 122 || vars.Helper["MainArea"].Current != 131 || vars.Helper["SubArea"].Current != 4) return false;
        if (vars.Helper["FinalScene"].Old == 0 && vars.Helper["FinalScene"].Current == 1)
        {
            return true;
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
        emu.Make<byte>("Rank10", 0x20019DB);
        emu.Make<byte>("ToraJobs", 0x200218F);
        emu.Make<byte>("FinalScene", 0x02004560);
        emu.Make<byte>("StartSound", 0x02006680);
        emu.Make<byte>("EnemyNo1", 0x02006D00);
        emu.Make<byte>("EnemyNo2", 0x02006D01);
        emu.Make<byte>("EnemyNo3", 0x02006D02);
        emu.Make<byte>("GameState", 0x020097F8);
        emu.Make<ushort>("BattleReward", 0x0200F332);
        emu.Make<byte>("BattleState", 0x0200F887);
        emu.Make<short>("EnemyNo1HP", 0x02037368);
        emu.Make<short>("EnemyNo2HP", 0x0203743C);
        emu.Make<short>("EnemyNo3HP", 0x02037510);

        return true;
    });

    vars.SplitonExitBattle = false;
    vars.HasSplitForFiresStarted = false;
}

start
{
    return vars.Helper["StartSound"].Changed && vars.Helper["StartSound"].Current == 128;
}

onStart
{
    vars.SplitonExitBattle = false;
    vars.HasSplitForFiresStarted = false;
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
                    
                    case "ToraJobs":
                        if (vars.CheckToraJobsCompleted())
                        {
                            print("Tora Jobs Completed");
                            return true;
                        }
                        break;

                    case "FiresStarted":
                        if (vars.CheckFiresStarted())
                        {
                            print("Fires Started Split");
                            vars.HasSplitForFiresStarted = true;
                            return true;
                        }
                        break;

                    case "Rank10":
                        if (vars.CheckRank10Fight())
                        {
                            print("Rank 10 Fight Won");
                            vars.SplitonExitBattle = true;
                        }
                        break;					
				}
				
			}
		}
	}

    if (vars.CheckCompleted())
    {
        print("Game Completed!");
        return true;
    }
    if (vars.SplitonExitBattle && vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 4)
	{
        print("Exiting Battle: SPLITTING");
		vars.SplitonExitBattle = false;
		return true;
	}
}
