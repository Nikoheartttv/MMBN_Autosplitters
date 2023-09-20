state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<byte>("GameLoadingFlag", 0x02000DC0);
        emu.Make<byte>("MainArea", 0x02000DC4);
        emu.Make<byte>("SubArea", 0x02000DC5);
        emu.Make<byte>("Progress", 0x02000DC6);
        emu.Make<byte>("BattleState", 0x02004EE2);
        emu.Make<byte>("EnemyNo1", 0x02004F3C);
        emu.Make<byte>("EnemyNo2", 0x02004F3D);
        emu.Make<byte>("EnemyNo3", 0x02004F3F);
        emu.Make<byte>("GameState", 0x02006910);
        emu.Make<short>("EnemyNo1HP", 0x02008B54);
        emu.Make<short>("EnemyNo2HP", 0x02008C14);
        emu.Make<short>("EnemyNo3HP", 0x02008CD4);       
        return true;
    });
}

update
{
}