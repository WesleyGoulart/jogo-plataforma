/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Checando se eu acabei de cair no chão
var _temp = place_meeting(x, y + 1, obj_parede_nao_escalavel);

if (_temp && !chao) // Acabei de tocar no chão
{
	xscale = 1.6;
	yscale = 0.5;
	
	// Criando a poeira
	for (var _i = 0; _i < irandom_range(4, 10); _i++)
	{
		var _xx = random_range(x - sprite_width, x + sprite_width);
		
		instance_create_depth(_xx, y, depth - 1000, obj_vel);
	}
}









