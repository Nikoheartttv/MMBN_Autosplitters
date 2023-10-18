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

    vars.DoghouseLeave = (Func<bool>)(() =>
	{
        if (vars.Helper == null || vars.Helper["MainArea"] == null || vars.Helper["SubArea"] == null) return false;
        
        if (vars.Helper["MainArea"].Old == 140 && vars.Helper["SubArea"].Old == 2 && 
                vars.Helper["MainArea"].Current == 0 && vars.Helper["SubArea"].Current == 0) return true;
                
        return false;
	});

    vars.CheckBossDeleted = (Func<byte, bool>)((bossId) =>
	{
        if (vars.Helper["GameState"].Current != 8) return false;
		if (vars.Helper["EnemyNo1"].Current == bossId && vars.Helper["EnemyNo1HP"].Old > 0 && vars.Helper["EnemyNo1HP"].Current == 0 ||
			vars.Helper["EnemyNo2"].Current == bossId && vars.Helper["EnemyNo2HP"].Old > 0 && vars.Helper["EnemyNo2HP"].Current == 0 ||
			vars.Helper["EnemyNo3"].Current == bossId && vars.Helper["EnemyNo3HP"].Old > 0 && vars.Helper["EnemyNo3HP"].Current == 0 )
		{
			return true;
		}

		return false;
	});

    vars.CheckBossDefeated = (Func<byte, bool>)((bossId) =>
	{
        if (vars.Helper["MainArea"].Current == 133) return false;
		if (vars.Helper["EnemyNo1"].Current == bossId && vars.Helper["EnemyNo1HP"].Current == 0 ||
			vars.Helper["EnemyNo2"].Current == bossId && vars.Helper["EnemyNo2HP"].Current == 0 ||
			vars.Helper["EnemyNo3"].Current == bossId && vars.Helper["EnemyNo3HP"].Current == 0)
		{
			return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
		}
		return false;
	});

    vars.CheckBossRush = (Func<byte, bool>)((bossId) => 
    {
        if (vars.Helper["MainArea"].Current != 133) return false;
		if (vars.Helper["EnemyNo1"].Current == bossId && vars.Helper["EnemyNo1HP"].Current == 0)
		{
			return vars.Helper["GameState"].Old == 8 && vars.Helper["GameState"].Current == 4;
		}
		return false;
    });

    vars.CheckInCoffeeMachine = (Action)(() =>
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
		if (vars.Helper["MainArea"].Current != 2 || vars.Helper["SubArea"].Current != 4) return false;
        if (vars.Helper["FinalDing"].Old == 0 && vars.Helper["FinalDing"].Current == 128)
        {
            return true;
        }

		return false;
	});


    // End function definitions

    var xml = System.Xml.Linq.XDocument.Load(@"Components/MMBN.Settings.xml");
    foreach (var element in xml.Element("settings").Elements("setting"))
    {
        if (element.Attribute("id").Value == "BN2")
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
        emu.Make<byte>("GameLoadingFlag", 0x02000DC0);
        emu.Make<byte>("StartSound", 0x020048F8);
        emu.Make<byte>("MainArea", 0x02000DC4);
        emu.Make<byte>("SubArea", 0x02000DC5);
        emu.Make<byte>("Progress", 0x02000DC6);
        emu.Make<byte>("KeyItem_HeatData", 0x02000EA4);
        emu.Make<byte>("BattleState", 0x02004EE2);
        emu.Make<byte>("EnemyNo1", 0x02004F3C);
        emu.Make<byte>("EnemyNo2", 0x02004F3D);
        emu.Make<byte>("EnemyNo3", 0x02004F3E);
        emu.Make<byte>("GameState", 0x02009078);
        emu.Make<short>("EnemyNo1HP", 0x02008B54);
        emu.Make<short>("EnemyNo2HP", 0x02008C14);
        emu.Make<short>("EnemyNo3HP", 0x02008CD4);    
        emu.Make<ushort>("BattleReward", 0x0200EFFE); 
        emu.Make<byte>("FinalDing", 0x2003F28);  
        return true;
    });

    vars.HasBeeninCoffeeMachine = false;
}

start
{
    // return old.GameLoadingFlag == 4 && current.GameState == 8;
    return vars.Helper["StartSound"].Changed && vars.Helper["StartSound"].Current == 128;
}

onStart
{
    vars.HasBeeninCoffeeMachine = false;
}

update
{
    vars.CheckInCoffeeMachine();
    if (vars.Helper["GameState"].Changed)
    {
        print("GameState changed. Current area is: " + vars.Helper["GameState"].Current.ToString());
    }
    if (vars.Helper["GameLoadingFlag"].Changed)
    {
        print("GameLoadingFlag changed. Current area is: " + vars.Helper["GameLoadingFlag"].Current.ToString());
    }
    if (vars.Helper["StartSound"].Changed)
    {
        print("StartSound changed. StartSound is: " + vars.Helper["StartSound"].Current.ToString());
    }
     if (vars.Helper["BattleReward"].Changed)
    {
        print("BattleReward changed. BattleReward is: " + vars.Helper["BattleReward"].Current.ToString());
    }
    if (vars.Helper["MainArea"].Changed)
    {
        print("MainArea changed. Current area is: " + vars.Helper["MainArea"].Current.ToString());
    }
    if (vars.Helper["SubArea"].Changed)
    {
        print("SubArea changed. Current area is: " + vars.Helper["SubArea"].Current.ToString());
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
					case "BossDeleted":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.CheckBossDeleted(value)) 
							{
								print("Boss Delted: " + element.Attribute("name").Value);
								return true;
							}
						}
						break;

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

					case "BossRush":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.CheckBossRush(value)) 
							{
								print("Boss Rush Defeated: " + element.Attribute("name").Value);
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

    // if (vars.CheckCompleted()) return true;
    if (vars.DoghouseLeave())
    {
        print("Doghouse Split");
        return true;
    }

    if (vars.CheckBLicense())
    {
        print("BLicense Split");
        return true;
    }

    if (vars.CheckALicensePrelims())
    {
        print("ALicensePrelims Split");
        return true;
    }
    if (vars.CheckALicense())
    {
        print("ALicense Split");
        return true;
    }

    if (vars.CheckCompleted()) return true;

    return (vars.Helper["KeyItem_HeatData"].Old == 0 && vars.Helper["KeyItem_HeatData"].Current == 1); 

 }