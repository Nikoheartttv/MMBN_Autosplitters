state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<byte>("GameLoadingFlag", 0x02001880);
        emu.Make<byte>("MainArea", 0x02001B84);
        emu.Make<byte>("SubArea", 0x02001B85);
        emu.Make<byte>("Progress", 0x02001886);
        emu.Make<byte>("BattleState", 0x0203CA70);
        emu.Make<short>("EnemyNo1", 0x020348D4);
        emu.Make<short>("EnemyNo2", 0x020348D6);
        emu.Make<short>("EnemyNo3", 0x020348D8);
        emu.Make<byte>("GameState", 0x02001B80);
        // emu.Make<ushort>("BattleReward", 0x0200F887);
        emu.Make<short>("EnemyNo1HP", 0x0203AAAC);
        emu.Make<short>("EnemyNo2HP", 0x0203AB84);
        emu.Make<short>("EnemyNo3HP", 0x0203AC5C);       
        return true;
    });
}

update
{
}