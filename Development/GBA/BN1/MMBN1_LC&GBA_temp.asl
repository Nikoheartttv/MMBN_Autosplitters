state("emuhawk") {}

state("MMBN_LC1", "30.10.23") 
{
	byte GameState : 0x29C9930, 0xB8, 0x0;
	byte MainArea : 0x29C9930, 0xB8, 0x4;
	byte SubArea : 0x29C9930, 0xB8, 0x5;
	byte Progress : 0x29C9930, 0xB8, 0x6;
	byte EnemyNo1 : 0x29C9930, 0x50, 0x0;
	byte EnemyNo2 : 0x29C9930, 0x50, 0x4;
	byte EnemyNo3 : 0x29C9930, 0x50, 0x8;
	short EnemyNo1HP : 0x29CE2A8, 0x20;
	short EnemyNo2HP : 0x29CE2A8, 0xE0;
	short EnemyNo3HP : 0x29CE2A8, 0x1A0;
	byte Key_Hig_Memo : 0x29C9930, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29C9930, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29C9930, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29C9930, 0xB8, 0xF7;
	byte NewGameStart : 0x29C9930, 0xB8, 0x18;
	byte PETDing : 0x29CE158, 0x634; 
}

state("MMBN_LC1", "13.10.23") 
{
	byte GameState : 0x29C9930, 0xB8, 0x0;
	byte MainArea : 0x29C9930, 0xB8, 0x4;
	byte SubArea : 0x29C9930, 0xB8, 0x5;
	byte Progress : 0x29C9930, 0xB8, 0x6;
	byte EnemyNo1 : 0x29C9930, 0x50, 0x0;
	byte EnemyNo2 : 0x29C9930, 0x50, 0x4;
	byte EnemyNo3 : 0x29C9930, 0x50, 0x8;
	short EnemyNo1HP : 0x29CE2A8, 0x20;
	short EnemyNo2HP : 0x29CE2A8, 0xE0;
	short EnemyNo3HP : 0x29CE2A8, 0x1A0;
	byte Key_Hig_Memo : 0x29C9930, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29C9930, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29C9930, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29C9930, 0xB8, 0xF7;
	byte NewGameStart : 0x29C9930, 0xB8, 0x18;
	byte PETDing : 0x29CE158, 0x634;
}

state("MMBN_LC1", "11.09.23") 
{
	byte GameState : 0x29F08F0, 0xB8, 0x0;
	byte MainArea : 0x29F08F0, 0xB8, 0x4;
	byte SubArea : 0x29F08F0, 0xB8, 0x5;
	byte Progress : 0x29F08F0, 0xB8, 0x6;
	byte EnemyNo1 : 0x29F08F0, 0x50, 0x0;
	byte EnemyNo2 : 0x29F08F0, 0x50, 0x4;
	byte EnemyNo3 : 0x29F08F0, 0x50, 0x8;
	short EnemyNo1HP : 0x29F5268, 0x20;
	short EnemyNo2HP : 0x29F5268, 0xE0;
	short EnemyNo3HP : 0x29F5268, 0x1A0;
	byte Key_Hig_Memo : 0x29F08F0, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29F08F0, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29F08F0, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29F08F0, 0xB8, 0xF7;
	byte NewGameStart : 0x29F08F0, 0xB8, 0x18;
	byte PETDing : 0x29F5118, 0x634;
}

state("MMBN_LC1", "04.07.23") 
{
	byte GameState : 0x29F3940, 0xB8, 0x0;
	byte MainArea : 0x29F3940, 0xB8, 0x4;
	byte SubArea : 0x29F3940, 0xB8, 0x5;
	byte Progress : 0x29F3940, 0xB8, 0x6;
	byte EnemyNo1 : 0x29F3940, 0x50, 0x0;
	byte EnemyNo2 : 0x29F3940, 0x50, 0x4;
	byte EnemyNo3 : 0x29F3940, 0x50, 0x8;
	short EnemyNo1HP : 0x29F82B8, 0x20;
	short EnemyNo2HP : 0x29F82B8, 0xE0;
	short EnemyNo3HP : 0x29F82B8, 0x1A0;
	byte Key_Hig_Memo : 0x29F3940, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29F3940, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29F3940, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29F3940, 0xB8, 0xF7;
	byte NewGameStart : 0x29F3940, 0xB8, 0x18;
	byte PETDing : 0x29F8168, 0x634;  

}

state("MMBN_LC1", "14.04.23") 
{
	byte GameState : 0x29EE840, 0xB8, 0x0;
	byte MainArea : 0x29EE840, 0xB8, 0x4;
	byte SubArea : 0x29EE840, 0xB8, 0x5;
	byte Progress : 0x29EE840, 0xB8, 0x6;
	byte EnemyNo1 : 0x29EE840, 0x50, 0x0;
	byte EnemyNo2 : 0x29EE840, 0x50, 0x4;
	byte EnemyNo3 : 0x29EE840, 0x50, 0x8;
	short EnemyNo1HP : 0x29F21F8, 0x20;
	short EnemyNo2HP : 0x29F21F8, 0xE0;
	short EnemyNo3HP : 0x29F21F8, 0x1A0;
	byte Key_Hig_Memo : 0x29EE840, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29EE840, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29EE840, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29EE840, 0xB8, 0xF7;
	byte NewGameStart : 0x29EE840, 0xB8, 0x18;
	byte PETDing : 0x29F3068, 0x634;  
}

state("MMBN_LC1", "Unknown Version") 
{
	byte GameState : 0x29C9930, 0xB8, 0x0;
	byte MainArea : 0x29C9930, 0xB8, 0x4;
	byte SubArea : 0x29C9930, 0xB8, 0x5;
	byte Progress : 0x29C9930, 0xB8, 0x6;
	byte EnemyNo1 : 0x29C9930, 0x50, 0x0;
	byte EnemyNo2 : 0x29C9930, 0x50, 0x4;
	byte EnemyNo3 : 0x29C9930, 0x50, 0x8;
	short EnemyNo1HP : 0x29CE2A8, 0x20;
	short EnemyNo2HP : 0x29CE2A8, 0xE0;
	short EnemyNo3HP : 0x29CE2A8, 0x1A0;
	byte Key_Hig_Memo : 0x29C9930, 0xB8, 0xF4;
	byte Key_Lab_Memo : 0x29C9930, 0xB8, 0xF5;
	byte Key_Yuri_Memo : 0x29C9930, 0xB8, 0xF6;
	byte Key_Pa_Memo : 0x29C9930, 0xB8, 0xF7;
	byte NewGameStart : 0x29C9930, 0xB8, 0x18;
	byte PETDing : 0x29CE158, 0x634; 
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

    var type = Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).GetType("GBA");
	vars.Helper = Activator.CreateInstance(type, args: false);
}

init
{
    if (game.ProcessName.ToLower() == "mmbn_lc1")
    {
		Thread.Sleep(5000);
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
            case "55A5CE1A3AF28B7BAA2C4D1DDB87B9A5": //13.10.23
                version = "13.10.23";
                break;
            case "293F473EE2E8A7499B3826639AC0482C": //11.09.23
                version = "11.09.23";
                break;
            case "A48B0B0E1A231308B9AEA65E96AC6CC5": //04.07.23
                version = "04.07.23";
                break;
            case "1D32F6697F3EDE544F3C8D3CC5269A5F": //14.04.23 (Initial Release)
                version = "14.04.23";
                break;
            default:
                version = "Unknown Version";
                MessageBox.Show(timer.Form,
                    "Mega Man Battle Network Legacy Collection Vol.1 Autosplitter Error:\n\n"
                    + "This autosplitter does not support this game version.\n"
                    + "Please contact Nikoheart (@nikoheart on Discord)\n"
                    + "with the following MD5Hash string and mention the game has recently updated.\n\n"
                    + "MD5Hash: " + MD5Hash + "\n\n"
                    + "Defaulting to the most recent known memory addesses...",
                    "Mega Man Battle Network Legacy Collection Vol.1 Autosplitter Error",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
                break;
        }
    }

	if (game.ProcessName.ToLower() == "emuhawk")
	{
		vars.Helper.Load = (Func<dynamic, bool>)(emu =>
        {
            emu.Make<byte>("PETDing", 0x0200001F);
            emu.Make<byte>("MainArea", 0x02000214);
            emu.Make<byte>("SubArea", 0x02000215);
            emu.Make<byte>("Progress", 0x02000216);
            emu.Make<byte>("Key_Hig_Memo", 0x02000304);
            emu.Make<byte>("Key_Lab_Memo", 0x02000305);
            emu.Make<byte>("Key_Pa_Memo", 0x02000306);
            emu.Make<byte>("Key_Yuri_Memo", 0x02000307);
            emu.Make<byte>("FinalDing", 0x020030A8);
            emu.Make<byte>("EnemyNo1", 0x02003774);
            emu.Make<byte>("EnemyNo2", 0x02003775);
            emu.Make<byte>("EnemyNo3", 0x02003776);
            emu.Make<short>("EnemyNo1HP", 0x02006790);
            emu.Make<short>("EnemyNo2HP", 0x02006850);
            emu.Make<short>("EnemyNo3HP", 0x02006910);
            emu.Make<byte>("GameState", 0x02006CB8);
            emu.Make<byte>("NewGameStart", 0x02003148);

            return true;
        });
	}

	vars.MemosSplitDone = false;
	vars.SplitOnExitBattle = false;
}

start
{
    if (vars.isEmu) 
    {
    	return old.NewGameStart != current.NewGameStart && current.NewGameStart == 128;
    }
    else
    {
    	return old.NewGameStart == 13 && current.NewGameStart == 255;
    }
}

onStart
{
    print("--- STARTING ---");
	vars.MemosSplitDone = false;
	vars.SplitOnExitBattle = false;
}

update
{
	vars.isEmu = vars.Helper.Update();

    if (vars.isEmu)
    {
        current.PETDing = vars.Helper["PETDing"].Current;
        current.MainArea = vars.Helper["MainArea"].Current;
        current.SubArea = vars.Helper["SubArea"].Current;
        current.Progress = vars.Helper["Progress"].Current;
        current.Key_Hig_Memo = vars.Helper["Key_Hig_Memo"].Current;
        current.Key_Lab_Memo = vars.Helper["Key_Lab_Memo"].Current;
        current.Key_Pa_Memo = vars.Helper["Key_Pa_Memo"].Current;
        current.Key_Yuri_Memo = vars.Helper["Key_Yuri_Memo"].Current;
        current.FinalDing = vars.Helper["FinalDing"].Current;
        current.EnemyNo1 = vars.Helper["EnemyNo1"].Current;
        current.EnemyNo2 = vars.Helper["EnemyNo2"].Current;
        current.EnemyNo3 = vars.Helper["EnemyNo3"].Current;
        current.EnemyNo1HP = vars.Helper["EnemyNo1HP"].Current;
        current.EnemyNo2HP = vars.Helper["EnemyNo2HP"].Current;
        current.EnemyNo3HP = vars.Helper["EnemyNo3HP"].Current;
        current.GameState = vars.Helper["GameState"].Current;
        current.NewGameStart = vars.Helper["NewGameStart"].Current;
    }

    if (old.PETDing != current.PETDing) print("PETDing changed from " + old.PETDing.ToString() + " to " + current.PETDing.ToString());
    if (old.MainArea != current.MainArea) print("MainArea changed from " + old.MainArea.ToString() + " to " + current.MainArea.ToString());
    if (old.SubArea != current.SubArea) print("SubArea changed from " + old.SubArea.ToString() + " to " + current.SubArea.ToString());
    if (old.Progress != current.Progress) print("Progress changed from " + old.Progress.ToString() + " to " + current.Progress.ToString());
    if (old.Key_Hig_Memo != current.Key_Hig_Memo) print("Key_Hig_Memo changed from " + old.Key_Hig_Memo.ToString() + " to " + current.Key_Hig_Memo.ToString());
    if (old.Key_Lab_Memo != current.Key_Lab_Memo) print("Key_Lab_Memo changed from " + old.Key_Lab_Memo.ToString() + " to " + current.Key_Lab_Memo.ToString());
    if (old.Key_Pa_Memo != current.Key_Pa_Memo) print("Key_Pa_Memo changed from " + old.Key_Pa_Memo.ToString() + " to " + current.Key_Pa_Memo.ToString());
    if (old.Key_Yuri_Memo != current.Key_Yuri_Memo) print("Key_Yuri_Memo changed from " + old.Key_Yuri_Memo.ToString() + " to " + current.Key_Yuri_Memo.ToString());
    if (old.EnemyNo1 != current.EnemyNo1) print("EnemyNo1 changed from " + old.EnemyNo1.ToString() + " to " + current.EnemyNo1.ToString());
    if (old.EnemyNo2 != current.EnemyNo2) print("EnemyNo2 changed from " + old.EnemyNo2.ToString() + " to " + current.EnemyNo2.ToString());
    if (old.EnemyNo3 != current.EnemyNo3) print("EnemyNo3 changed from " + old.EnemyNo3.ToString() + " to " + current.EnemyNo3.ToString());
    if (old.EnemyNo1HP != current.EnemyNo1HP) print("EnemyNo1HP changed from " + old.EnemyNo1HP.ToString() + " to " + current.EnemyNo1HP.ToString());
    if (old.EnemyNo2HP != current.EnemyNo2HP) print("EnemyNo2HP changed from " + old.EnemyNo2HP.ToString() + " to " + current.EnemyNo2HP.ToString());
    if (old.EnemyNo3HP != current.EnemyNo3HP) print("EnemyNo3HP changed from " + old.EnemyNo3HP.ToString() + " to " + current.EnemyNo3HP.ToString());
    if (old.GameState != current.GameState) print("GameState changed from " + old.GameState.ToString() + " to " + current.GameState.ToString());
    if (old.NewGameStart != current.NewGameStart) print("NewGameStart changed from " + old.NewGameStart.ToString() + " to " + current.NewGameStart.ToString());
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

					case "Progress":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (old.Progress != value && current.Progress == value)
							{
								print("Progress Split: " + element.Attribute("name").Value);
								return true;
							}
						}
						break;

					case "Memos":
						{
							if (!vars.MemosSplitDone)
							{
								if (current.Key_Hig_Memo == 1 && current.Key_Lab_Memo == 1 &&
									current.Key_Pa_Memo == 1 && current.Key_Yuri_Memo == 1 &&
									current.MainArea == 2 && current.SubArea == 5 &&
									old.GameState != 12 && current.GameState == 12)
								{
									print("Memos Split");
									vars.MemosSplitDone = true;
									return true;
								}
							}
						}
						break;
				}
			}
		}
	}

	// Split on Exit Battle
	if (vars.SplitOnExitBattle && old.GameState != 4 && current.GameState == 4)
	{
		print("Exiting Battle: SPLITTING");
		vars.SplitOnExitBattle = false;
		return true;
	}


    if (vars.isEmu) 
    {
        if (current.PETDing == 64 && old.FinalDing != current.FinalDing && current.FinalDing == 128)
        {
            print("Final Ding Split");
            return true;
        }
    }
    else
    {
        if (current.Progress == 84 && current.MainArea == 1 && current.SubArea == 0 && old.PETDing != current.PETDing && current.PETDing == 176)
        {
            print("Final Ding Split");
            return true;
        }
    }
}

shutdown
{
	vars.Helper.Dispose();
}
