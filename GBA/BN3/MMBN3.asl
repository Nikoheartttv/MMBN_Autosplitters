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
        emu.Make<byte>("MainArea", 0x02001884);
        emu.Make<byte>("SubArea", 0x02001885);
        emu.Make<byte>("Progress", 0x02001886);
        emu.Make<byte>("BattleState", 0x02004EE2);
        emu.Make<byte>("EnemyNo1", 0x02006D00);
        emu.Make<byte>("EnemyNo2", 0x02006D01);
        emu.Make<byte>("EnemyNo3", 0x02006D02);
        emu.Make<byte>("GameState", 0x020097F8);
        emu.Make<ushort>("BattleReward", 0x0200F887);
        emu.Make<short>("EnemyNo1HP", 0x02037368);
        emu.Make<short>("EnemyNo2HP", 0x0203743C);
        emu.Make<short>("EnemyNo3HP", 0x02037510);       
        return true;
    });
}

update
{
}