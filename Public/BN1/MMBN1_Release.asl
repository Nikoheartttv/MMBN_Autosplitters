state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");

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

        if (vars.Helper["Key_Hig_Memo"].Current == 1 && vars.Helper["Key_Lab_Memo"].Current == 1 &&
            vars.Helper["Key_Pa_Memo"].Current == 1 && vars.Helper["Key_Yuri_Memo"].Current == 1 &&
			vars.Helper["MainArea"].Current == 2 && vars.Helper["SubArea"].Current == 5 &&
			vars.Helper["GameState"].Changed && vars.Helper["GameState"].Current == 12)
		{
			return true;
		}
        
        return false;
    });

	vars.CheckCompleted = (Func<bool>)(() =>
	{
		if (vars.Helper == null || vars.Helper["FinalScene"] == null || vars.Helper["FinalDing"] == null) return false;
        if (vars.Helper["FinalScene"].Current == 64 && vars.Helper["FinalDing"].Changed && vars.Helper["FinalDing"].Current == 128)
        {
            return true;
        }

		return false;
	});

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
        emu.Make<byte>("Key_Hig_Memo", 0x02000304);
        emu.Make<byte>("Key_Lab_Memo", 0x02000305);
        emu.Make<byte>("Key_Pa_Memo", 0x02000306);
        emu.Make<byte>("Key_Yuri_Memo", 0x02000307);
		emu.Make<byte>("FinalDing", 0x020030A8);
		emu.Make<byte>("BattleState", 0x02003712);
        emu.Make<byte>("EnemyNo1", 0x02003774);
        emu.Make<byte>("EnemyNo2", 0x02003775);
        emu.Make<byte>("EnemyNo3", 0x02003776);
        emu.Make<short>("EnemyNo1HP", 0x02006790);
        emu.Make<short>("EnemyNo2HP", 0x02006850);
        emu.Make<short>("EnemyNo3HP", 0x02006910);
        emu.Make<byte>("GameState", 0x02006CB8);
        emu.Make<byte>("StartSound", 0x02003148);
		
        return true;
    });

	vars.MemosSplitDone = false;
}

start
{
    return vars.Helper["StartSound"].Old == 0 && vars.Helper["StartSound"].Current == 128;
}

onStart
{
	vars.MemosSplitDone = false;
}

update
{
    if (vars.Helper["StartSound"].Changed)
    {
        print("StartSound changed. StartSound is: " + vars.Helper["StartSound"].Current.ToString());
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
					
				}
				
			}
		}
	}

    if (vars.CheckCompleted()) return true;
}