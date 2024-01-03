state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");


    vars.CheckBossDefeated = (Func<ushort, bool>)((bossId) =>
	{
        if (vars.Helper["GameState"].Current != 12) return false;
		if (vars.Helper["EnemyNo1"].Current == bossId && vars.Helper["EnemyNo1HP"].Changed && vars.Helper["EnemyNo1HP"].Current == 0 ||
			vars.Helper["EnemyNo2"].Current == bossId && vars.Helper["EnemyNo2HP"].Changed && vars.Helper["EnemyNo2HP"].Current == 0 ||
			vars.Helper["EnemyNo3"].Current == bossId && vars.Helper["EnemyNo3HP"].Changed && vars.Helper["EnemyNo3HP"].Current == 0)
		{
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

	vars.CheckMaxHP = (Func<ushort, bool>)((value) =>
	{
		if (vars.Helper == null || vars.Helper["MaxHP"] == null) return false;
		if (vars.Helper["MaxHP"].Old < value && vars.Helper["MaxHP"].Current >= value) return true;
		return false;
	});


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
        if (element.Attribute("id").Value == "BN5C")
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
		emu.Make<byte>("StartCheck", 0x2008230);
        emu.Make<byte>("GameLoadingFlag", 0x02000000);
        emu.Make<byte>("MainArea", 0x02002944);
        emu.Make<byte>("SubArea", 0x02002945);
        emu.Make<byte>("Progress", 0x02002946);
        // emu.Make<byte>("BattleState", 0x02004EE2);
        emu.Make<ushort>("EnemyNo1", 0x02034AE4);
        emu.Make<ushort>("EnemyNo2", 0x02034AE6);
        emu.Make<ushort>("EnemyNo3", 0x02034AE8);
        emu.Make<byte>("GameState", 0x02002940);
        // emu.Make<ushort>("BattleReward", 0x0200F887);
        emu.Make<ushort>("EnemyNo1HP", 0x0203B2FC);
        emu.Make<ushort>("EnemyNo2HP", 0x0203B3D4);
        emu.Make<ushort>("EnemyNo3HP", 0x0203B4AC);
		emu.Make<ushort>("MaxHP", 0x020052EA);
        return true;
    });

    vars.SplitOnExitBattle = false;
}

update
{
    if (vars.Helper["GameLoadingFlag"].Changed) print("GameLoadingFlag changed from " + vars.Helper["GameLoadingFlag"].Old + " to " + vars.Helper["GameLoadingFlag"].Current);
    if (vars.Helper["MainArea"].Changed) print("MainArea changed from " + vars.Helper["MainArea"].Old + " to " + vars.Helper["MainArea"].Current);
    if (vars.Helper["SubArea"].Changed) print("SubArea changed from " + vars.Helper["SubArea"].Old + " to " + vars.Helper["SubArea"].Current);
    if (vars.Helper["Progress"].Changed) print("Progress changed from " + vars.Helper["Progress"].Old + " to " + vars.Helper["Progress"].Current);
    if (vars.Helper["EnemyNo1"].Changed) print("EnemyNo1 changed from " + vars.Helper["EnemyNo1"].Old + " to " + vars.Helper["EnemyNo1"].Current);
    if (vars.Helper["EnemyNo2"].Changed) print("EnemyNo2 changed from " + vars.Helper["EnemyNo2"].Old + " to " + vars.Helper["EnemyNo2"].Current);
    if (vars.Helper["EnemyNo3"].Changed) print("EnemyNo3 changed from " + vars.Helper["EnemyNo3"].Old + " to " + vars.Helper["EnemyNo3"].Current);
    if (vars.Helper["GameState"].Changed) print("GameState changed from " + vars.Helper["GameState"].Old + " to " + vars.Helper["GameState"].Current);
    if (vars.Helper["EnemyNo1HP"].Changed) print("EnemyNo1HP changed from " + vars.Helper["EnemyNo1HP"].Old + " to " + vars.Helper["EnemyNo1HP"].Current);
    if (vars.Helper["EnemyNo2HP"].Changed) print("EnemyNo2HP changed from " + vars.Helper["EnemyNo2HP"].Old + " to " + vars.Helper["EnemyNo2HP"].Current);
    if (vars.Helper["EnemyNo3HP"].Changed) print("EnemyNo3HP changed from " + vars.Helper["EnemyNo3HP"].Old + " to " + vars.Helper["EnemyNo3HP"].Current);
	if (vars.Helper["StartCheck"].Changed) print("StartCheck changed from " + vars.Helper["StartCheck"].Old + " to " + vars.Helper["StartCheck"].Current);

}

start
{
	if (vars.Helper == null || vars.Helper["StartCheck"] == null) return false;
	return vars.Helper["StartCheck"].Old == 0 && (vars.Helper["StartCheck"].Current == 128 || vars.Helper["StartCheck"].Current == 192);
}

onStart
{
    vars.SplitOnExitBattle = false;
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
							ushort value = ushort.Parse(element.Attribute("value").Value);
							if (vars.CheckBossDefeated(value)) 
							{
								print("Boss Defeated: " + element.Attribute("name").Value);
								vars.SplitOnExitBattle = true;
							}
						}
						break;

					case "BossDefeatedImmediate":
						{
							ushort value = ushort.Parse(element.Attribute("value").Value);
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
					
					case "MaxHP":
						{
							ushort value = ushort.Parse(element.Attribute("value").Value);
							if (vars.CheckMaxHP(value))
							{
								print("MaxHP Split: " + element.Attribute("value").Value);
								return true;
							}
						}
						break;
				}
			}
		}
	}

	if (vars.SplitOnExitBattle && vars.Helper["GameState"].Old == 12 && vars.Helper["GameState"].Current != 12)
	{
        print("Splitting on exit battle");
		vars.SplitOnExitBattle = false;
		return true;
	}
}

onSplit
{
    print("===== SPLIT =====");
}