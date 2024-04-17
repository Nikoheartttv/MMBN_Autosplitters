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
	vars.SplitOnExitBattle = false;
}

start
{
	return vars.Helper["StartSound"].Changed && vars.Helper["StartSound"].Current == 128;
}

onStart
{
	vars.HasBeeninCoffeeMachine = false;
	vars.SplitOnExitBattle = false;
}

update
{
	if (!vars.HasBeeninCoffeeMachine)
	{
		if (vars.Helper["MainArea"].Current == 140 && vars.Helper["SubArea"].Current == 5) vars.HasBeeninCoffeeMachine = true;
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
							if ((vars.Helper["EnemyNo1"].Current == value && vars.Helper["EnemyNo1HP"].Current == 0 && vars.Helper["EnemyNo1HP"].Old != 0) ||
								(vars.Helper["EnemyNo2"].Current == value && vars.Helper["EnemyNo2HP"].Current == 0 && vars.Helper["EnemyNo2HP"].Old != 0) ||
								(vars.Helper["EnemyNo3"].Current == value && vars.Helper["EnemyNo3HP"].Current == 0 && vars.Helper["EnemyNo3HP"].Old != 0))
								{
									print("Boss Defeated: " + element.Attribute("name").Value);
									vars.SplitOnExitBattle = true;
								}
							}
						break;

					case "BossRush":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.Helper["EnemyNo1"].Current == value && vars.Helper["EnemyNo1HP"].Current == 0 && vars.Helper["EnemyNo1HP"].Old > 0)
							{
								print("Boss Rush Defeated: " + element.Attribute("name").Value);
								vars.SplitOnExitBattle = true;
							}
						}
						break;

					case "Progress":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.Helper["Progress"].Changed && vars.Helper["Progress"].Current == value) 
							{
								print("Progress Split: " + element.Attribute("name").Value);
								return true;
							}
						}
						break;
					
					case "Doghouse":
						{
							if (vars.Helper["MainArea"].Old == 140 && vars.Helper["SubArea"].Old == 2 && 
								vars.Helper["MainArea"].Current == 0 && vars.Helper["SubArea"].Current == 0)
								{
									print("Doghouse Split");
									return true;
								}
						}
						break;
					
					case "BLicense":
						{
							if (vars.Helper["Progress"].Current == 9 && vars.Helper["MainArea"].Current == 144 && vars.Helper["SubArea"].Current == 4)
							{
								if ((vars.Helper["EnemyNo1"].Current == 29 && vars.Helper["EnemyNo1HP"].Current == 0 && vars.Helper["EnemyNo1HP"].Old > 0) ||
									(vars.Helper["EnemyNo2"].Current == 29 && vars.Helper["EnemyNo2HP"].Current == 0 && vars.Helper["EnemyNo2HP"].Old > 0) ||
									(vars.Helper["EnemyNo3"].Current == 7 && vars.Helper["EnemyNo3HP"].Current == 0 && vars.Helper["EnemyNo3HP"].Old > 0))
								{
									print("BLicense Split");
									vars.SplitOnExitBattle = true;
								}
							}
						}
						break;

					case "ALicensePrelims":
						{
							if (vars.HasBeeninCoffeeMachine && vars.Helper["Progress"].Current == 18 &&
								vars.Helper["MainArea"].Old == 145 && vars.Helper["SubArea"].Old == 3 &&
								vars.Helper["MainArea"].Current == 1 && vars.Helper["SubArea"].Current == 2)
								{
									print("ALicensePrelims Split");
									return true;
								} 
						}
						break;

					case "ALicense":
						{
							if (vars.Helper["Progress"].Current == 19 && vars.Helper["MainArea"].Current == 144 && vars.Helper["SubArea"].Current == 4)
							{
								if ((vars.Helper["EnemyNo1"].Current == 69 && vars.Helper["EnemyNo1HP"].Current == 0 && vars.Helper["EnemyNo1HP"].Old > 0) ||
									(vars.Helper["EnemyNo2"].Current == 38 && vars.Helper["EnemyNo2HP"].Current == 0 && vars.Helper["EnemyNo2HP"].Old > 0) ||
									(vars.Helper["EnemyNo3"].Current == 24 && vars.Helper["EnemyNo3HP"].Current == 0 && vars.Helper["EnemyNo3HP"].Old > 0))
								{
									print("ALicense Split");
									vars.SplitOnExitBattle = true;
								}
							}
							return false;
						}
						break;

					case "HeatData":
						{
							if (vars.Helper["KeyItem_HeatData"].Old == 0 && vars.Helper["KeyItem_HeatData"].Current == 1)
							{
								print("Heat Data Split");
								return true;
							}
						}
						break;
				}
			}
		}
	}

	// Split on Exit Battle
	if (vars.SplitOnExitBattle && vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 4)
	{
		print("Exiting Battle: SPLITTING");
		vars.SplitOnExitBattle = false;
		return true;
	}

	// Final Split on Ding
	if (vars.Helper["Progress"].Current == 72 && vars.Helper["MainArea"].Current == 2 && vars.Helper["SubArea"].Current == 4)
	{
		return vars.Helper["FinalDing"].Old == 0 && vars.Helper["FinalDing"].Current == 128;
	}
}