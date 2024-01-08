/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

grav = 0.3;
acel_chao = 0.1;
acel_ar = 0.07;
acel = acel_chao;

// Velocidades
velh = 0;
velv = 0;

// Limites das velocidades
max_velh = 6;
max_velv = 8;


// Variaveis de controle
chao = false;

enum STATE
{
	PARADO, MOVENDO, DASH
}

estado = STATE.PARADO