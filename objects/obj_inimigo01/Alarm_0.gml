/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Criando o tiro se o inimigo ja está na tela
if (y >= 0)
{
instance_create_layer(x - 3, y + sprite_height/3, "Instances", obj_tiro_inimigo01);
}


// Reiniciar o alarme
alarm[0] = room_speed * random_range(1, 3);
