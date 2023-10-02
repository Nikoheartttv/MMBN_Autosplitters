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

    // vars.LeavingDoghouse

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
        emu.Make<byte>("BattleState", 0x02004EE2);
        emu.Make<byte>("EnemyNo1", 0x02004F3C);
        emu.Make<byte>("EnemyNo2", 0x02004F3D);
        emu.Make<byte>("EnemyNo3", 0x02004F3F);
        emu.Make<byte>("GameState", 0x02006910);
        emu.Make<short>("EnemyNo1HP", 0x02008B54);
        emu.Make<short>("EnemyNo2HP", 0x02008C14);
        emu.Make<short>("EnemyNo3HP", 0x02008CD4);    
        emu.Make<ushort>("BattleReward", 0x0200EFFE);   
        return true;
    });
}

start
{
    // return old.GameLoadingFlag == 4 && current.GameState == 8;
    return old.StartSound == 0 && current.StartSound == 16;
}

update
{
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
}