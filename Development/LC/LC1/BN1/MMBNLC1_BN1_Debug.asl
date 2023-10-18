state("MMBN_LC1") 
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