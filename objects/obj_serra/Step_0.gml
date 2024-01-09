/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Rodando 
image_angle += rot;

switch(estado)
{
	case "avanca":
	
		// Descobrindo a direção do limite
		var _limite_x = lengthdir_x(limite, dir);
		var _limite_y = lengthdir_y(limite, dir);
		
		// Movendo
		x += lengthdir_x(vel, dir);
		y += lengthdir_y(vel, dir);
		
		// Trocando de estado
		if (_limite_x > 0) // Tenho que ir para a direita
		{
			if (x >= xstart + _limite_x) estado = "recua";
		}
		else if (_limite_x < 0) // Tenho que ir para a esquerda
		{
			if (x <= xstart + _limite_x) estado = "recua";
		}
		if (_limite_y > 0) // Tenho que ir para a direita
		{
			if (y >= ystart + _limite_y) estado = "recua";
		}
		else if (_limite_y < 0) // Tenho que ir para a esquerda
		{
			if (y <= ystart + _limite_y) estado = "recua";
		}
	
	
		break;
		
	case "recua":
	
		// Movendo
		x -= lengthdir_x(vel, dir);
		y -= lengthdir_y(vel, dir);
		
		// Mudando de estado
		if (x == xstart && y == ystart) estado = "avanca";
	
		break;
		
	case "parado":
	
		break;
		
	default:
		show_message("Voce digitou o nome do estado errado");
		
		break;
}






