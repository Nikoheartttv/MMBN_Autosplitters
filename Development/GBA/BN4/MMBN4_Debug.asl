state("LiveSplit") {}

startup
{

    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");

	vars.MMBN4ReadByte = (Func<string, uint, byte>)((offsetName, ramOffset) =>
	{
		if (vars.Offsets[offsetName] >= 0x02002130 && vars.Offsets[offsetName] <= 0x02009B10)
			return vars.Helper.ReadValue<byte>(vars.Offsets[offsetName] + ramOffset);
		else 
			return vars.Helper.ReadValue<byte>(vars.Offsets[offsetName]);
	});

	vars.MMBN4ReadUShort = (Func<string, uint, ushort>)((offsetName, ramOffset) =>
	{
		if (vars.Offsets[offsetName] >= 0x02002130 && vars.Offsets[offsetName] <= 0x02009B10)
			return vars.Helper.ReadValue<ushort>(vars.Offsets[offsetName] + ramOffset);
		else 
			return vars.Helper.ReadValue<ushort>(vars.Offsets[offsetName]);
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
        if (element.Attribute("id").Value == "BN4")
        {
            vars.GameSettings = element;
            break;
        }
    }

    ReadSettingsXML(vars.GameSettings.Elements("setting"), null);
}

init
{
	vars.SplitOnExitBattle = false;
	current.RAMOffset = 0;
	current.MainArea = 0;
	current.SubArea = 0;
	current.Progress = 0;
	current.BattleState = 0;
	current.EnemyNo1 = 0;
	current.EnemyNo2 = 0;
	current.EnemyNo3 = 0;
	current.GameState = 0;
	current.BattleReward = 0;
	current.EnemyNo1HP = 0;
	current.EnemyNo2HP = 0;
	current.EnemyNo3HP = 0;

	vars.Offsets = new Dictionary<string, uint>()
	{
        { "RAMOffset", 0x02001550 },
        { "MainArea", 0x02002134 },
        { "SubArea", 0x02002135 },
        { "Progress", 0x02002136 },
        { "BattleState", 0x02004EE2 },
        { "EnemyNo1", 0x02035870 },
        { "EnemyNo2", 0x02035871 },
        { "EnemyNo3", 0x02035872 },
        { "GameState", 0x0200A7E0 },
        { "BattleReward", 0x0200F887 },
        { "EnemyNo1HP", 0x0203B27C },
        { "EnemyNo2HP", 0x0203B354 },
        { "EnemyNo3HP", 0x0203B42C }
	};

    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        // emu.Make<int>("RAMOffset", 0x02001550); // not sure if int or short, keep int for now
        // emu.Make<byte>("MainArea", 0x02002134);
        // emu.Make<byte>("SubArea", 0x02002135);
        // emu.Make<byte>("Progress", 0x02002136);
        // emu.Make<byte>("BattleState", 0x02004EE2);
        // emu.Make<byte>("EnemyNo3", 0x02035870);
        // emu.Make<byte>("EnemyNo2", 0x02035871);
        // emu.Make<byte>("EnemyNo3", 0x02035872);
        // emu.Make<byte>("GameState", 0x0200A7E0);  //was 0x020097F8
        // emu.Make<ushort>("BattleReward", 0x0200F887);
        // emu.Make<short>("EnemyNo3HP", 0x0203B27C);
        // emu.Make<short>("EnemyNo2HP", 0x0203B354);
        // emu.Make<short>("EnemyNo3HP", 0x0203B42C);       
        return true;
    });
}

update
{
	var RAMOffset = vars.Helper.ReadValue<uint>(vars.Offsets["RAMOffset"]);

	current.MainArea = vars.MMBN4ReadByte("MainArea", RAMOffset);
	current.SubArea = vars.MMBN4ReadByte("SubArea", RAMOffset);
	current.Progress = vars.MMBN4ReadByte("Progress", RAMOffset);
	current.BattleState = vars.MMBN4ReadByte("BattleState", RAMOffset);
	current.EnemyNo1 = vars.MMBN4ReadByte("EnemyNo1", RAMOffset);
	current.EnemyNo2 = vars.MMBN4ReadByte("EnemyNo2", RAMOffset);
	current.EnemyNo3 = vars.MMBN4ReadByte("EnemyNo3", RAMOffset);
	current.GameState = vars.MMBN4ReadByte("GameState", RAMOffset);
	current.BattleReward = vars.MMBN4ReadUShort("BattleReward", RAMOffset);
	current.EnemyNo1HP = vars.MMBN4ReadUShort("EnemyNo1HP", RAMOffset);
	current.EnemyNo2HP = vars.MMBN4ReadUShort("EnemyNo2HP", RAMOffset);
	current.EnemyNo3HP = vars.MMBN4ReadUShort("EnemyNo3HP", RAMOffset);

	if (current.MainArea != old.MainArea) print ("MainArea changed from " + old.MainArea.ToString() + " to " + current.MainArea.ToString());
	if (current.SubArea != old.SubArea) print ("SubArea changed from " + old.SubArea.ToString() + " to " + current.SubArea.ToString());
	if (current.Progress != old.Progress) print ("Progress changed from " + old.Progress.ToString() + " to " + current.Progress.ToString());
	if (current.BattleState != old.BattleState) print ("BattleState changed from " + old.BattleState.ToString() + " to " + current.BattleState.ToString());
	if (current.EnemyNo1 != old.EnemyNo1) print ("EnemyNo1 changed from " + old.EnemyNo1.ToString() + " to " + current.EnemyNo1.ToString());
	if (current.EnemyNo2 != old.EnemyNo2) print ("EnemyNo2 changed from " + old.EnemyNo2.ToString() + " to " + current.EnemyNo2.ToString());
	if (current.EnemyNo3 != old.EnemyNo3) print ("EnemyNo3 changed from " + old.EnemyNo3.ToString() + " to " + current.EnemyNo3.ToString());
	if (current.GameState != old.GameState) print ("GameState changed from " + old.GameState.ToString() + " to " + current.GameState.ToString());
	// if (current.BattleReward != old.BattleReward) print ("BattleReward changed from " + old.BattleReward.ToString() + " to " + current.BattleReward.ToString());
	if (current.EnemyNo1HP != old.EnemyNo1HP) print ("EnemyNo1HP changed from " + old.EnemyNo1HP.ToString() + " to " + current.EnemyNo1HP.ToString());
	if (current.EnemyNo2HP != old.EnemyNo2HP) print ("EnemyNo2HP changed from " + old.EnemyNo2HP.ToString() + " to " + current.EnemyNo2HP.ToString());
	if (current.EnemyNo3HP != old.EnemyNo3HP) print ("EnemyNo3HP changed from " + old.EnemyNo3HP.ToString() + " to " + current.EnemyNo3HP.ToString());
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
							if ((current.EnemyNo1 == value && old.EnemyNo1HP != 0 && current.EnemyNo1HP == 0) ||
								(current.EnemyNo2 == value && old.EnemyNo2HP != 0 && current.EnemyNo2HP == 0) ||
								(current.EnemyNo3 == value && old.EnemyNo3HP != 0 && current.EnemyNo3HP == 0))
							{
								print("Boss Defeated! ID: " + value.ToString());
								vars.SplitOnExitBattle = true;
							}
							break;
						}
					
					case "Progress":
						{
							byte value = Byte.Parse(element.Attribute("value").Value);
							if (current.Progress == value && current.Progress != old.Progress) 
							{
								print("SPLITTING");
								return true;
							}
							break;
						}
				
				}
			}
		}
	}

	if (vars.SplitOnExitBattle && old.GameState == 8 && current.GameState != 8)
	{
		print("SPLITTING");
		vars.SplitOnExitBattle = false;
		return true;
	}
}













































































    // could put RAMOffset here as a var instead of having it as a emu.Make
    // would look like this:
    // var RAM_Offset = vars.Helper.ReadValue<uint>(0x02001550);
	// var MainArea = vars.Helper.ReadValue<uint>(0x02001550); 

	
	// print(vars.Offsets["RAMOffset"].ToString("X"));

// if (vars.Watchers == null)
// 		{
// 			print("Reloading Watchers");
// 			var xml = System.Xml.Linq.XDocument.Load(@"Components/MMBN_GBA.Watchers.xml");
// 			foreach (var Xgame in xml.Element("watchers").Elements("game"))
// 			{
// 				foreach (var name in Xgame.Elements("name"))
// 				{
// 					if (name.Value == vars.game)
// 					{
// 						print("Watchers found for " + name.Value);
// 						vars.Watchers = new MemoryWatcherList();
// 						foreach (var watcher in Xgame.Elements("watcher"))
// 						{
// 							if (watcher.Attributes("name") == null) continue;

// 							Type watchertype;
// 							var watchername = watcher.Attribute("name").Value;

// 							List<int> offsets = new List<int>();
// 							foreach (var offset in watcher.Elements("offset"))
// 							{
// 								offsets.Add(Convert.ToInt32(offset.Attribute("value").Value, 16));
// 							}

// 							switch (watcher.Attribute("type").Value)
// 							{
// 								case "byte":
// 									vars.Watchers.Add(new MemoryWatcher<byte>(new DeepPointer("mgba.dll", vars.offset, offsets.ToArray())) { Name = watchername });
// 									break;
// 								case "ushort":
// 									vars.Watchers.Add(new MemoryWatcher<ushort>(new DeepPointer("mgba.dll", vars.offset, offsets.ToArray())) { Name = watchername });
// 									break;
// 								case "short":
// 									vars.Watchers.Add(new MemoryWatcher<short>(new DeepPointer("mgba.dll", vars.offset, offsets.ToArray())) { Name = watchername });
// 									break;
// 								case "int":
// 									vars.Watchers.Add(new MemoryWatcher<int>(new DeepPointer("mgba.dll", vars.offset, offsets.ToArray())) { Name = watchername });
// 									break;
// 								case "uint":
// 									vars.Watchers.Add(new MemoryWatcher<uint>(new DeepPointer("mgba.dll", vars.offset, offsets.ToArray())) { Name = watchername });
// 									break;
// 							}
// 						}
// 					}
// 				}
// 			}
// 		}

	// if (vars.IsBN4())
	// {
	// 	if (vars.WatcherExists(vars.Watchers, "RAMOffset") && vars.Watchers["RAMOffset"].Changed)
	// 	{
	// 		vars.GameStatePointer = null;
	// 		vars.MainAreaPointer = null;
	// 		vars.SubAreaPointer = null;
	// 		vars.ProgressPointer = null;
	// 		vars.EnemyNo3Pointer = null;
	// 		vars.EnemyNo3HPPointer = null;
	// 		vars.EnemyNo2HPPointer = null;
	// 		vars.EnemyNo3HPPointer = null;
	// 		vars.ZennyPointer = null;
	// 		vars.BattleRewardPointer = null;
	// 	}

	// 	if (vars.WatcherExists(vars.Watchers, "RAMOffset"))
	// 	{
	// 		if (vars.GameStatePointer == null) vars.GameStatePointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0xA7E0);
	// 		if (vars.MainAreaPointer == null) vars.MainAreaPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x2134 + vars.Watchers["RAMOffset"].Current);
	// 		if (vars.SubAreaPointer == null) vars.SubAreaPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x2135 + vars.Watchers["RAMOffset"].Current);
	// 		if (vars.ProgressPointer == null) vars.ProgressPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x2136 + vars.Watchers["RAMOffset"].Current);
	// 		if (vars.EnemyNo3Pointer == null) vars.EnemyNo3Pointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x35870);
	// 		if (vars.EnemyNo2Pointer == null) vars.EnemyNo2Pointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x35871);
	// 		if (vars.EnemyNo3Pointer == null) vars.EnemyNo3Pointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x35872);
	// 		if (vars.EnemyNo3HPPointer == null) vars.EnemyNo3HPPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x3B27C);
	// 		if (vars.EnemyNo2HPPointer == null) vars.EnemyNo2HPPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x3B354);
	// 		if (vars.EnemyNo3HPPointer == null) vars.EnemyNo3HPPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x3B42C);
	// 		if (vars.ZennyPointer == null) vars.ZennyPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x21A4 + vars.Watchers["RAMOffset"].Current);
	// 		if (vars.BattleRewardPointer == null) vars.BattleRewardPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x363D8);
	// 	}

	// 	if (vars.GameStatePointer != null) current.BN4GameState = vars.GameStatePointer.Deref<byte>(game);
	// 	if (vars.MainAreaPointer != null) current.BN4MainArea = vars.MainAreaPointer.Deref<byte>(game);
	// 	if (vars.SubAreaPointer != null) current.BN4SubArea = vars.SubAreaPointer.Deref<byte>(game);
	// 	if (vars.ProgressPointer != null) current.BN4Progress = vars.ProgressPointer.Deref<byte>(game);
	// 	if (vars.EnemyNo3Pointer != null) current.BN4EnemyNo3 = vars.EnemyNo3Pointer.Deref<byte>(game);
	// 	if (vars.EnemyNo2Pointer != null) current.BN4EnemyNo2 = vars.EnemyNo2Pointer.Deref<byte>(game);
	// 	if (vars.EnemyNo3Pointer != null) current.BN4EnemyNo3 = vars.EnemyNo3Pointer.Deref<byte>(game);
	// 	if (vars.EnemyNo3HPPointer != null) current.BN4EnemyNo3HP = vars.EnemyNo3HPPointer.Deref<short>(game);
	// 	if (vars.EnemyNo2HPPointer != null) current.BN4EnemyNo2HP = vars.EnemyNo2HPPointer.Deref<short>(game);
	// 	if (vars.EnemyNo3HPPointer != null) current.BN4EnemyNo3HP = vars.EnemyNo3HPPointer.Deref<short>(game);
	// 	if (vars.ZennyPointer != null) current.BN4Zenny = vars.ZennyPointer.Deref<int>(game);
	// 	if (vars.BattleRewardPointer != null) current.BN4BattleReward = vars.BattleRewardPointer.Deref<ushort>(game);
	// }

        // if (current.BN4GameState != old.BN4GameState) print("BN4 GameState Changed from " + old.BN4GameState + " to: " +  current.BN4GameState);		
    // if (current.BN4MainArea != old.BN4MainArea) print("BN4 MainArea Changed from " + old.BN4MainArea + " to: " +  current.BN4MainArea);
    // if (current.BN4SubArea != old.BN4SubArea) print("BN4 SubArea Changed from " + old.BN4SubArea + " to: " +  current.BN4SubArea);
    // if (current.BN4Progress != old.BN4Progress) print("BN4 Progress Changed from " + old.BN4Progress + " to: " +  current.BN4Progress);
    // if (current.BN4EnemyNo3 != old.BN4EnemyNo3) print("BN4 EnemyNo3 Changed from " + old.BN4EnemyNo3 + " to: " +  current.BN4EnemyNo3);
    // if (current.BN4EnemyNo2 != old.BN4EnemyNo2) print("BN4 EnemyNo2 Changed from " + old.BN4EnemyNo2 + " to: " +  current.BN4EnemyNo2);
    // if (current.BN4EnemyNo3 != old.BN4EnemyNo3) print("BN4 EnemyNo3 Changed from " + old.BN4EnemyNo3 + " to: " +  current.BN4EnemyNo3);
    // if (current.BN4EnemyNo3HP != old.BN4EnemyNo3HP) print("BN4 EnemyNo3HP Changed from " + old.BN4EnemyNo3HP + " to: " +  current.BN4EnemyNo3HP);
    // if (current.BN4EnemyNo2HP != old.BN4EnemyNo2HP) print("BN4 EnemyNo2HP Changed from " + old.BN4EnemyNo2HP + " to: " +  current.BN4EnemyNo2HP);
    // if (current.BN4EnemyNo3HP != old.BN4EnemyNo3HP) print("BN4 EnemyNo3HP Changed from " + old.BN4EnemyNo3HP + " to: " +  current.BN4EnemyNo3HP);
    // if (current.BN4Zenny != old.BN4Zenny) print("BN4 Zenny Changed from " + old.BN4Zenny + " to: " +  current.BN4Zenny);
    // if (current.BN4BattleReward != old.BN4BattleReward) print("BN4 BattleReward Changed from " + old.BN4BattleReward + " to: " +  current.BN4BattleReward);
