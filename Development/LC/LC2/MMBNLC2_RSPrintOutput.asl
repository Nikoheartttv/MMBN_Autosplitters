state("MMBN_LC2"){}

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
    current.GameState = 0;
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
    current.GameState = game.ReadValue<ushort>((IntPtr)0x80217C78);


	if (current.MainArea != old.MainArea) print ("Main Area changed to " + current.MainArea.ToString());
	if (current.SubArea != old.SubArea) print ("Sub Area changed to " + current.SubArea.ToString());
	if (current.Progress != old.Progress) print ("Progress changed to " + current.Progress.ToString());
	if (current.EnemyNo1 != old.EnemyNo1) print ("EnemyNo1 changed to " + current.EnemyNo1.ToString());
	if (current.EnemyNo2 != old.EnemyNo2) print ("EnemyNo2 changed to " + current.EnemyNo2.ToString());
	if (current.EnemyNo3 != old.EnemyNo3) print ("EnemyNo3 changed to " + current.EnemyNo3.ToString());
	if (current.EnemyNo1HP != old.EnemyNo1HP) print ("EnemyNo1HP changed to " + current.EnemyNo1HP.ToString());
	if (current.EnemyNo2HP != old.EnemyNo2HP) print ("EnemyNo2HP changed to " + current.EnemyNo2HP.ToString());
	if (current.EnemyNo3HP != old.EnemyNo3HP) print ("EnemyNo3HP changed to " + current.EnemyNo3HP.ToString());
	if (current.GameState != old.GameState) print ("GameState changed to " + current.GameState.ToString());

}

start
{
	return old.StartCheck == 0 && current.StartCheck == 255;
}
