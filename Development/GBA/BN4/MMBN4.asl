state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<int>("RAMOffset", 0x02001550); // not sure if int or short, keep int for now
        emu.Make<byte>("GameLoadingFlag", 0x0200A7E0);
        emu.Make<byte>("MainArea", 0x02002134);
        emu.Make<byte>("SubArea", 0x02002135);
        emu.Make<byte>("Progress", 0x02002136);
        emu.Make<byte>("BattleState", 0x02004EE2);
        emu.Make<byte>("EnemyNo1", 0x02035870);
        emu.Make<byte>("EnemyNo2", 0x02035871);
        emu.Make<byte>("EnemyNo3", 0x02035872);
        emu.Make<byte>("GameState", 0x020097F8);
        emu.Make<ushort>("BattleReward", 0x0200F887);
        emu.Make<short>("EnemyNo1HP", 0x0203B27C);
        emu.Make<short>("EnemyNo2HP", 0x0203B354);
        emu.Make<short>("EnemyNo3HP", 0x0203B42C);       
        return true;
    });
}

update
{
    // could put RAMOffset here as a var instead of having it as a emu.Make
    // would look like this:
    var RAM_Offset = vars.Helper.ReadValue<uint>(0x02001550); 
}

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
	// 		vars.EnemyNo1Pointer = null;
	// 		vars.EnemyNo1HPPointer = null;
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
	// 		if (vars.EnemyNo1Pointer == null) vars.EnemyNo1Pointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x35870);
	// 		if (vars.EnemyNo2Pointer == null) vars.EnemyNo2Pointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x35871);
	// 		if (vars.EnemyNo3Pointer == null) vars.EnemyNo3Pointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x35872);
	// 		if (vars.EnemyNo1HPPointer == null) vars.EnemyNo1HPPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x3B27C);
	// 		if (vars.EnemyNo2HPPointer == null) vars.EnemyNo2HPPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x3B354);
	// 		if (vars.EnemyNo3HPPointer == null) vars.EnemyNo3HPPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x3B42C);
	// 		if (vars.ZennyPointer == null) vars.ZennyPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x21A4 + vars.Watchers["RAMOffset"].Current);
	// 		if (vars.BattleRewardPointer == null) vars.BattleRewardPointer = new DeepPointer("mgba.dll", vars.offset, 0x10, 0x28, 0x363D8);
	// 	}

	// 	if (vars.GameStatePointer != null) current.BN4GameState = vars.GameStatePointer.Deref<byte>(game);
	// 	if (vars.MainAreaPointer != null) current.BN4MainArea = vars.MainAreaPointer.Deref<byte>(game);
	// 	if (vars.SubAreaPointer != null) current.BN4SubArea = vars.SubAreaPointer.Deref<byte>(game);
	// 	if (vars.ProgressPointer != null) current.BN4Progress = vars.ProgressPointer.Deref<byte>(game);
	// 	if (vars.EnemyNo1Pointer != null) current.BN4EnemyNo1 = vars.EnemyNo1Pointer.Deref<byte>(game);
	// 	if (vars.EnemyNo2Pointer != null) current.BN4EnemyNo2 = vars.EnemyNo2Pointer.Deref<byte>(game);
	// 	if (vars.EnemyNo3Pointer != null) current.BN4EnemyNo3 = vars.EnemyNo3Pointer.Deref<byte>(game);
	// 	if (vars.EnemyNo1HPPointer != null) current.BN4EnemyNo1HP = vars.EnemyNo1HPPointer.Deref<short>(game);
	// 	if (vars.EnemyNo2HPPointer != null) current.BN4EnemyNo2HP = vars.EnemyNo2HPPointer.Deref<short>(game);
	// 	if (vars.EnemyNo3HPPointer != null) current.BN4EnemyNo3HP = vars.EnemyNo3HPPointer.Deref<short>(game);
	// 	if (vars.ZennyPointer != null) current.BN4Zenny = vars.ZennyPointer.Deref<int>(game);
	// 	if (vars.BattleRewardPointer != null) current.BN4BattleReward = vars.BattleRewardPointer.Deref<ushort>(game);
	// }

        // if (current.BN4GameState != old.BN4GameState) print("BN4 GameState Changed from " + old.BN4GameState + " to: " +  current.BN4GameState);		
    // if (current.BN4MainArea != old.BN4MainArea) print("BN4 MainArea Changed from " + old.BN4MainArea + " to: " +  current.BN4MainArea);
    // if (current.BN4SubArea != old.BN4SubArea) print("BN4 SubArea Changed from " + old.BN4SubArea + " to: " +  current.BN4SubArea);
    // if (current.BN4Progress != old.BN4Progress) print("BN4 Progress Changed from " + old.BN4Progress + " to: " +  current.BN4Progress);
    // if (current.BN4EnemyNo1 != old.BN4EnemyNo1) print("BN4 EnemyNo1 Changed from " + old.BN4EnemyNo1 + " to: " +  current.BN4EnemyNo1);
    // if (current.BN4EnemyNo2 != old.BN4EnemyNo2) print("BN4 EnemyNo2 Changed from " + old.BN4EnemyNo2 + " to: " +  current.BN4EnemyNo2);
    // if (current.BN4EnemyNo3 != old.BN4EnemyNo3) print("BN4 EnemyNo3 Changed from " + old.BN4EnemyNo3 + " to: " +  current.BN4EnemyNo3);
    // if (current.BN4EnemyNo1HP != old.BN4EnemyNo1HP) print("BN4 EnemyNo1HP Changed from " + old.BN4EnemyNo1HP + " to: " +  current.BN4EnemyNo1HP);
    // if (current.BN4EnemyNo2HP != old.BN4EnemyNo2HP) print("BN4 EnemyNo2HP Changed from " + old.BN4EnemyNo2HP + " to: " +  current.BN4EnemyNo2HP);
    // if (current.BN4EnemyNo3HP != old.BN4EnemyNo3HP) print("BN4 EnemyNo3HP Changed from " + old.BN4EnemyNo3HP + " to: " +  current.BN4EnemyNo3HP);
    // if (current.BN4Zenny != old.BN4Zenny) print("BN4 Zenny Changed from " + old.BN4Zenny + " to: " +  current.BN4Zenny);
    // if (current.BN4BattleReward != old.BN4BattleReward) print("BN4 BattleReward Changed from " + old.BN4BattleReward + " to: " +  current.BN4BattleReward);
