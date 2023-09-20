state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<byte>("GameLoadingFlag", 0x02000210);
        emu.Make<byte>("MainArea", 0x02000214);
        emu.Make<byte>("SubArea", 0x02000215);
        emu.Make<byte>("Progress", 0x02000216);
        emu.Make<byte>("Key_Hig_Memo", 0x02000304);
        emu.Make<byte>("Key_Lab_Memo", 0x02000305);
        emu.Make<byte>("Key_Pa_Memo", 0x02000306);
        emu.Make<byte>("Key_Yuri_Memo", 0x02000307);
        emu.Make<byte>("EnemyNo1", 0x02003774);
        emu.Make<byte>("EnemyNo2", 0x02003775);
        emu.Make<byte>("EnemyNo3", 0x02003776);
        emu.Make<short>("EnemyNo1HP", 0x02006790);
        emu.Make<short>("EnemyNo2HP", 0x02006850);
        emu.Make<short>("EnemyNo3HP", 0x02006910);
        emu.Make<byte>("GameState", 0x02006CB8);
        emu.Make<byte>("BattleState", 0x02003712);
        return true;
    });
}

update
{
}