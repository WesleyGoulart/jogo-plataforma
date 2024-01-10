/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


// Checando se posso ir para a próxima room
if (room_next(room) != -1)
{
	room_goto_next();
}
else
{
	// Não tem outra room para ir
	game_restart();
}





