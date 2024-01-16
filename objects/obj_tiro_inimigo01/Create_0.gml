/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Cheacando se o player existe no jogo

_posicao = obj_inimigo01;

image_angle = direction + 90;


vspeed = 6;

image_xscale = 2;
image_yscale = 2;

//alarm[0] = 2;

_cores = choose(c_white);

if (obj_player.x)
{
	direction = point_direction(x, y, obj_player.x, obj_player.y);
}


/*

if (instance_exists(obj_player))
{
	direction = point_direction(x, y, obj_player.x, obj_player.y);
}

*/
