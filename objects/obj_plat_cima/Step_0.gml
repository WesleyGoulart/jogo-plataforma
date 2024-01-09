/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (instance_exists(obj_player))
{
	if (obj_player.y > y) // Estou mais alto que o player
		sprite_index = -1;
	else
		sprite_index = spr_plat_cima;
}






