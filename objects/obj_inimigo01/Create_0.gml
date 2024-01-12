/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


// vspeed = 8;

// pontos = 10

// Iniciando o alarme com tempo entre 1 e 3 segundos
alarm[0] = random_range(1, 3) + room_speed;

// Checando se eu estou colidindo com algum outro inimigo
// Se eu colidir com alguém eu me destruo
/* 
if (place_meeting(x, y, obj_inimigo01))
{
	// não executando o evento destroy
	instance_destroy(id, false);
}
*/

atirando = function()
{
	if (y > 0)
	{
		instance_create_layer(x - 3, y + sprite_height/3, "Instances", obj_tiro_inimigo01);
	}
}





