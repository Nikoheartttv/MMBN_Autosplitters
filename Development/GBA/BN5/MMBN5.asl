state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<byte>("GameLoadingFlag", 0x02000000);
        emu.Make<byte>("MainArea", 0x02002944);
        emu.Make<byte>("SubArea", 0x02002945);
        emu.Make<byte>("Progress", 0x02002946);
        // emu.Make<byte>("BattleState", 0x02004EE2);
        emu.Make<byte>("EnemyNo1", 0x02004AE4);
        emu.Make<byte>("EnemyNo2", 0x02004AE6);
        emu.Make<byte>("EnemyNo3", 0x02004AE8);
        emu.Make<byte>("GameState", 0x02002940);
        // emu.Make<ushort>("BattleReward", 0x0200F887);
        emu.Make<short>("EnemyNo1HP", 0x0200B2FC);
        emu.Make<short>("EnemyNo2HP", 0x0200B3D4);
        emu.Make<short>("EnemyNo3HP", 0x0200B4AC);       
        return true;
    });
}

update
{
}