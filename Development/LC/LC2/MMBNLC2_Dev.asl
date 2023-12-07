state("MMBN_LC2") 
{
	// --- Main Menu of Battle Network Legacy Collection 2
	byte LC2_GameChoice : 0xABEF764; // BN4RS - 5/BM - 6,  BN5TM - 7/TC - 8, BN6CG - 9/CF - 10
	byte LC2_GameSelected : 0xABEFE68; // when Start hit, once audio selection sound occurs, goes from 1 to 0

  // --- Mega Man Battle Network 4
	// byte MMBN4_ENo1 : 0x3D3A828, 0x1F;
	// short MMBN4_ENo1HP : 0x3D3A828, 0x34;
	// byte MMBN4_ENo2 : 0x3D3A828, 0xF7;
	// short MMBN4_ENo2HP : 0x3D3A828, 0x10C;
	// byte MMBN4_ENo3 : 0x3D3A828, 0x1CF;
	// short MMBN4_ENo3HP : 0x3D3A828, 0x1E4;
	// byte MMBN4_StartCheck : 0x3D3B239, 0x22, 0x1A8, 0x101, 0x2, 0x579;
}

startup
{
	
}

init
{
	current.MainArea = 0;
	current.SubArea = 0;
	current.Progress = 0;
	current.StartCheck = 0;
	current.EnemyNo1 = 0;
	current.EnemyNo2 = 0;
	current.EnemyNo3 = 0;
	current.EnemyNo1HP = 0;
	current.EnemyNo2HP = 0;
	current.EnemyNo3HP = 0;
}

update
{
	int RAMOffset = game.ReadValue<int>((IntPtr)0x80207400);
	current.MainArea = game.ReadValue<byte>(((IntPtr)0x80207484 + RAMOffset));
	current.SubArea = game.ReadValue<byte>(((IntPtr)0x80207485 + RAMOffset));
	current.Progress = game.ReadValue<byte>(((IntPtr)0x80207486 + RAMOffset));
	current.StartCheck = game.ReadValue<byte>((IntPtr)0x80207579);
	current.EnemyNo1 = game.ReadValue<byte>((IntPtr)0x8020B5A7);
	current.EnemyNo1HP = game.ReadValue<ushort>((IntPtr)0x8020B5BC);
	current.EnemyNo2 = game.ReadValue<byte>((IntPtr)0x8020B67F);
	current.EnemyNo2HP = game.ReadValue<ushort>((IntPtr)0x8020B694);
	current.EnemyNo3 = game.ReadValue<byte>((IntPtr)0x8020B757);
	current.EnemyNo3HP = game.ReadValue<ushort>((IntPtr)0x8020B76C);

	if (current.MainArea != old.MainArea) print ("Main Area changed from " + old.MainArea.ToString() + " to " + current.MainArea.ToString());
	if (current.SubArea != old.SubArea) print ("Sub Area changed from " + old.SubArea.ToString() + " to " + current.SubArea.ToString());
	if (current.Progress != old.Progress) print ("Progress changed from " + old.Progress.ToString() + " to " + current.Progress.ToString());
	if (current.StartCheck != old.StartCheck) print ("StartCheck changed from " + old.StartCheck.ToString() + " to " + current.StartCheck.ToString());
	if (current.EnemyNo1 != old.EnemyNo1) print ("EnemyNo1 changed from " + old.EnemyNo1.ToString() + " to " + current.EnemyNo1.ToString());
	if (current.EnemyNo2 != old.EnemyNo2) print ("EnemyNo2 changed from " + old.EnemyNo2.ToString() + " to " + current.EnemyNo2.ToString());
	if (current.EnemyNo3 != old.EnemyNo3) print ("EnemyNo3 changed from " + old.EnemyNo3.ToString() + " to " + current.EnemyNo3.ToString());
	if (current.EnemyNo1HP != old.EnemyNo1HP) print ("EnemyNo1HP changed from " + old.EnemyNo1HP.ToString() + " to " + current.EnemyNo1HP.ToString());
	if (current.EnemyNo2HP != old.EnemyNo2HP) print ("EnemyNo2HP changed from " + old.EnemyNo2HP.ToString() + " to " + current.EnemyNo2HP.ToString());
	if (current.EnemyNo3HP != old.EnemyNo3HP) print ("EnemyNo3HP changed from " + old.EnemyNo3HP.ToString() + " to " + current.EnemyNo3HP.ToString());
	

	// print(game.MainModule.BaseAddress.ToString("X"));
	// print(current.RAMOffset.ToString());
	
	//  print(intValue.ToString());
	//  print("RAMOffset changd to " + current.RAMOffset.ToString());
}

start
{
	return old.StartCheck == 0 && current.StartCheck == 255;
}



// startup
// {

    

// 	vars.MMBN4ReadByte = (Func<string, uint, byte>)((offsetName, ramOffset) =>
// 	{
// 		if (vars.Offsets[offsetName] >= 0x02002130 && vars.Offsets[offsetName] <= 0x02009B10)
// 			return vars.Helper.ReadValue<byte>(vars.Offsets[offsetName] + ramOffset);
// 		else 
// 			return vars.Helper.ReadValue<byte>(vars.Offsets[offsetName]);
// 	});

// 	vars.MMBN4ReadUShort = (Func<string, uint, ushort>)((offsetName, ramOffset) =>
// 	{
// 		if (vars.Offsets[offsetName] >= 0x02002130 && vars.Offsets[offsetName] <= 0x02009B10)
// 			return vars.Helper.ReadValue<ushort>(vars.Offsets[offsetName] + ramOffset);
// 		else 
// 			return vars.Helper.ReadValue<ushort>(vars.Offsets[offsetName]);
// 	});

//     Action<IEnumerable<System.Xml.Linq.XElement>, string> ReadSettingsXML = null;
//     ReadSettingsXML = (elements, parentid) =>
// 	{
// 		foreach (var element in elements) 
// 		{
// 			settings.Add(element.Attribute("id").Value, element.Attribute("defaultValue") != null && element.Attribute("defaultValue").Value == "true", element.Attribute("name").Value, parentid);
// 			ReadSettingsXML(element.Elements("setting"), element.Attribute("id").Value);
// 		}
// 	};

//     var xml = System.Xml.Linq.XDocument.Load(@"Components/MMBN.Settings.xml");
//     foreach (var element in xml.Element("settings").Elements("setting"))
//     {
//         if (element.Attribute("id").Value == "BN4")
//         {
//             vars.GameSettings = element;
//             break;
//         }
//     }

//     ReadSettingsXML(vars.GameSettings.Elements("setting"), null);

// 	vars.ProgressReached = new List<byte>();
// }

// init
// {
// 	vars.pontaDefeated = false;
// 	vars.SplitOnExitBattle = false;
// 	current.RAMOffset = 0;
// 	current.StartCheck = 0;
// 	current.MainArea = 0;
// 	current.SubArea = 0;
// 	current.Progress = 0;
// 	current.BattleState = 0;
// 	current.EnemyNo1 = 0;
// 	current.EnemyNo2 = 0;
// 	current.EnemyNo3 = 0;
// 	current.GameState = 0;
// 	current.BattleReward = 0;
// 	current.EnemyNo1HP = 0;
// 	current.EnemyNo2HP = 0;
// 	current.EnemyNo3HP = 0;
// 	current.DuoCheck = 0;

// 	vars.Offsets = new Dictionary<string, uint>()
// 	{
// 		{ "StartCheck", 0x0200A81B },
//         { "RAMOffset", 0x02001550 },
//         { "MainArea", 0x02002134 },
//         { "SubArea", 0x02002135 },
//         { "Progress", 0x02002136 },
//         { "BattleState", 0x02004EE2 },
//         { "EnemyNo1", 0x02035870 },
//         { "EnemyNo2", 0x02035871 },
//         { "EnemyNo3", 0x02035872 },
//         { "GameState", 0x0200A7E0 },
//         { "BattleReward", 0x0200F887 },
//         { "EnemyNo1HP", 0x0203B27C },
//         { "EnemyNo2HP", 0x0203B354 },
//         { "EnemyNo3HP", 0x0203B42C },
// 		{ "DuoCheck", 0x2007BB3 }
// 		// { "EaglePoints", 0x020021BC }
// 	};

//     vars.Helper.Load = (Func<dynamic, bool>)(emu =>
//     {
//         // emu.Make<int>("RAMOffset", 0x02001550); // not sure if int or short, keep int for now
//         // emu.Make<byte>("MainArea", 0x02002134);
//         // emu.Make<byte>("SubArea", 0x02002135);
//         // emu.Make<byte>("Progress", 0x02002136);
//         // emu.Make<byte>("BattleState", 0x02004EE2);
//         // emu.Make<byte>("EnemyNo3", 0x02035870);
//         // emu.Make<byte>("EnemyNo2", 0x02035871);
//         // emu.Make<byte>("EnemyNo3", 0x02035872);
//         // emu.Make<byte>("GameState", 0x0200A7E0);  //was 0x020097F8
//         // emu.Make<ushort>("BattleReward", 0x0200F887);
//         // emu.Make<short>("EnemyNo3HP", 0x0203B27C);
//         // emu.Make<short>("EnemyNo2HP", 0x0203B354);
//         // emu.Make<short>("EnemyNo3HP", 0x0203B42C);       
//         return true;
//     });
// }

// update
// {
// 	var RAMOffset = vars.Helper.ReadValue<uint>(vars.Offsets["RAMOffset"]);

// 	current.StartCheck = vars.MMBN4ReadByte("StartCheck", RAMOffset);
// 	current.MainArea = vars.MMBN4ReadByte("MainArea", RAMOffset);
// 	current.SubArea = vars.MMBN4ReadByte("SubArea", RAMOffset);
// 	current.Progress = vars.MMBN4ReadByte("Progress", RAMOffset);
// 	current.BattleState = vars.MMBN4ReadByte("BattleState", RAMOffset);
// 	current.EnemyNo1 = vars.MMBN4ReadByte("EnemyNo1", RAMOffset);
// 	current.EnemyNo2 = vars.MMBN4ReadByte("EnemyNo2", RAMOffset);
// 	current.EnemyNo3 = vars.MMBN4ReadByte("EnemyNo3", RAMOffset);
// 	current.GameState = vars.MMBN4ReadByte("GameState", RAMOffset);
// 	current.BattleReward = vars.MMBN4ReadUShort("BattleReward", RAMOffset);
// 	current.EnemyNo1HP = vars.MMBN4ReadUShort("EnemyNo1HP", RAMOffset);
// 	current.EnemyNo2HP = vars.MMBN4ReadUShort("EnemyNo2HP", RAMOffset);
// 	current.EnemyNo3HP = vars.MMBN4ReadUShort("EnemyNo3HP", RAMOffset);
// 	current.DuoCheck = vars.MMBN4ReadByte("DuoCheck", RAMOffset);

// 	if (current.MainArea != old.MainArea) print ("MainArea changed from " + old.MainArea.ToString() + " to " + current.MainArea.ToString());
// 	if (current.SubArea != old.SubArea) print ("SubArea changed from " + old.SubArea.ToString() + " to " + current.SubArea.ToString());
// 	if (current.Progress != old.Progress)
// 	{
// 		print ("PROGRESS changed from " + old.Progress.ToString() + " to " + current.Progress.ToString());
// 		if (current.Progress == 64)
// 		{
// 			print("HOLY SHIT!");
// 			print("HOLY SHIT!");
// 			print("HOLY SHIT!");
// 			print("HOLY SHIT!");
// 			print("HOLY SHIT!");
// 		}
// 	}
// 	if (current.BattleState != old.BattleState) print ("BattleState changed from " + old.BattleState.ToString() + " to " + current.BattleState.ToString());
// 	if (current.EnemyNo1 != old.EnemyNo1) print ("EnemyNo1 changed from " + old.EnemyNo1.ToString() + " to " + current.EnemyNo1.ToString());
// 	if (current.EnemyNo2 != old.EnemyNo2) print ("EnemyNo2 changed from " + old.EnemyNo2.ToString() + " to " + current.EnemyNo2.ToString());
// 	if (current.EnemyNo3 != old.EnemyNo3) print ("EnemyNo3 changed from " + old.EnemyNo3.ToString() + " to " + current.EnemyNo3.ToString());
// 	if (current.GameState != old.GameState) print ("GameState changed from " + old.GameState.ToString() + " to " + current.GameState.ToString());
// 	// if (current.BattleReward != old.BattleReward) print ("BattleReward changed from " + old.BattleReward.ToString() + " to " + current.BattleReward.ToString());
// 	// if (current.EnemyNo1HP != old.EnemyNo1HP) print ("EnemyNo1HP changed from " + old.EnemyNo1HP.ToString() + " to " + current.EnemyNo1HP.ToString());
// 	// if (current.EnemyNo2HP != old.EnemyNo2HP) print ("EnemyNo2HP changed from " + old.EnemyNo2HP.ToString() + " to " + current.EnemyNo2HP.ToString());
// 	// if (current.EnemyNo3HP != old.EnemyNo3HP) print ("EnemyNo3HP changed from " + old.EnemyNo3HP.ToString() + " to " + current.EnemyNo3HP.ToString());
// 	if (current.StartCheck != old.StartCheck) print ("StartCheck changed from " + old.StartCheck.ToString() + " to " + current.StartCheck.ToString());
// }

// start
// {
// 	if (old.StartCheck == 0 && current.StartCheck == 2) return true;
// }

// onStart
// {
// 	vars.pontaDefeated = false;
// }

// split
// {
// 	foreach (var element in vars.GameSettings.Descendants("setting"))
// 	{
// 		if (settings[element.Attribute("id").Value])
// 		{
//             if (element.Attribute("check") != null && element.Attribute("value") != null)
// 			{
// 				string check = element.Attribute("check").Value;

// 				switch(check)
// 				{
// 					case "BossDefeated":
// 						{
// 							byte value = Byte.Parse(element.Attribute("value").Value);
// 							if ((current.EnemyNo1 == value && old.EnemyNo1HP != 0 && current.EnemyNo1HP == 0) ||
// 								(current.EnemyNo2 == value && old.EnemyNo2HP != 0 && current.EnemyNo2HP == 0) ||
// 								(current.EnemyNo3 == value && old.EnemyNo3HP != 0 && current.EnemyNo3HP == 0))
// 							{
// 								print("Boss Defeated! ID: " + value.ToString());
// 								if (value == 200)
// 								{
// 									if (!vars.pontaDefeated) vars.SplitOnExitBattle = true;
// 									vars.pontaDefeated = true;
// 								}
// 								else 
// 								{
// 									vars.SplitOnExitBattle = true;
// 								}
// 							}
// 							break;
// 						}
					
// 					case "Progress":
// 						{
// 							byte value = Byte.Parse(element.Attribute("value").Value);
// 							if (current.Progress == value && current.Progress != old.Progress) 
// 							{
// 								if (!vars.ProgressReached.Contains(current.Progress))
// 								{
// 									vars.ProgressReached.Add(current.Progress);
// 									print("SPLITTING");
// 									return true;
// 								}
// 							}
// 							break;
// 						}

// 					case "FixPark":
// 						{
// 							if (current.MainArea == 146 && current.SubArea == 2
// 								&& (current.EnemyNo1 == 31 && current.EnemyNo2 == 31 && current.EnemyNo3 == 31) &&
// 								(old.EnemyNo1HP != 0 || old.EnemyNo2HP != 0 || old.EnemyNo3HP != 0) &&
// 								(current.EnemyNo1HP == 0 && current.EnemyNo2HP == 0 && current.EnemyNo3HP == 0))
// 								{
// 									print("We Fixed the Park!");
// 									vars.SplitOnExitBattle = true;
// 								}
// 						}
// 						break;
					
// 					case "FixTheNet":
// 						{
// 							if ((current.EnemyNo1 == 104 && current.EnemyNo2 == 20 && current.EnemyNo3 == 196) &&
// 								(old.EnemyNo1HP != 0 || old.EnemyNo2HP != 0 || old.EnemyNo3HP != 0) &&
// 								(current.EnemyNo1HP == 0 && current.EnemyNo2HP == 0 && current.EnemyNo3HP == 0))
// 							{
// 								print("We Fixed the Net!");
// 								vars.SplitOnExitBattle = true;
// 							}
// 							break;
// 						}
					
// 					case "Duo":
// 						{
// 							if (current.MainArea == 130 && current.SubArea == 4
// 							&& current.EnemyNo1 == 224 && old.DuoCheck == 0 && current.DuoCheck == 3) return true;
// 						}
// 						break;

				
// 				}
// 			}
// 		}
// 	}

// 	if (vars.SplitOnExitBattle && old.GameState == 8 && current.GameState != 8)
// 	{
// 		print("SPLITTING");
// 		vars.SplitOnExitBattle = false;
// 		return true;
// 	}
// }











































































