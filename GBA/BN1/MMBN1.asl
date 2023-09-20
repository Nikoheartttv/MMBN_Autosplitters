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
		if (vars.Helper["EnemyNo1"].Current == bossId ||
			vars.Helper["EnemyNo2"].Current == bossId ||
			vars.Helper["EnemyNo3"].Current == bossId) {
			if (vars.Helper["BattleState"].Changed && vars.Helper["BattleState"].Current == 0x41) return true;
		}

		return false;
	});

	vars.CheckBattleReward = (Func<ushort, bool>)((battleReward) =>
	{
		if (vars.Helper["BattleReward"].Changed && vars.Helper["BattleReward"].Current == battleReward) return true;

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
        emu.Make<byte>("GameLoadingFlag", 0x02000210);
        emu.Make<byte>("MainArea", 0x02000214);
        emu.Make<byte>("SubArea", 0x02000215);
        emu.Make<byte>("Progress", 0x02000216);
        emu.Make<byte>("Key_Hig_Memo", 0x02000304);
        emu.Make<byte>("Key_Lab_Memo", 0x02000305);
        emu.Make<byte>("Key_Pa_Memo", 0x02000306);
        emu.Make<byte>("Key_Yuri_Memo", 0x02000307);
        emu.Make<byte>("EnemyNo1", 0x02003774);
        emu.Make<byte>("EnemyNo2", 0x02003775);
        emu.Make<byte>("EnemyNo3", 0x02003776);
        emu.Make<short>("EnemyNo1HP", 0x02006790);
        emu.Make<short>("EnemyNo2HP", 0x02006850);
        emu.Make<short>("EnemyNo3HP", 0x02006910);
        emu.Make<byte>("GameState", 0x02006CB8);
        emu.Make<byte>("BattleState", 0x02003712);
        return true;
    });

    vars.SplitonExitBattle = false;
}

start
{
    return (old.GameState == 0 && current.GameState != 0);
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
        print("MainArea changed. Current area is: " + vars.Helper["MainArea"].Current.ToString());
    }
}

// split
// {
//     if (vars.SplitonExitBattle && vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 4)
// 	{
// 		vars.SplitonExitBattle = false;
// 		print("--- SPLIT");
// 		return true;
// 	}

//     // if current.Key_Hig_Memo == 1 && current.Key_Lab_Memo == 1 && current.Key_Pa_Memo == 1 && current.Key_Yuri_Memo == 1
// }

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
                // ushort rewardid = Byte.Parse(element.Attribute("rewardid").Value); < assuming same entry as enemyid

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

					case "BattleRewardGet":
						{
							ushort value = UInt16.Parse(element.Attribute("value").Value);
							if (vars.CheckBattleReward(value))
							{
								print("Reward ID: " + element.Attribute("name").Value);
								vars.SplitonExitBattle = true;
							}
						}
                        break;

					case "MiniBossDefeated":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.CheckBossDefeated(value)) 
							{
								print("Optional Boss Defeated: " + element.Attribute("name").Value);
								vars.SplitonExitBattle = true;
							}
						}
						break;

					case "OptionalBossDefeated":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (vars.CheckBossDefeated(value)) 
							{
								print("Optional Boss Defeated: " + element.Attribute("name").Value);
								vars.SplitonExitBattle = true;
							}
						}
						break;
				}
			}
		}
	}

	if (vars.SplitonExitBattle && vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 0x4)
	{
		vars.SplitonExitBattle = false;
		print("Boss Defeated: Splitting");
		return true;
	}
}