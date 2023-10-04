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