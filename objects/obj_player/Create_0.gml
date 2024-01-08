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
len = 10; 


// Bônus para o pulo
limite_pulo = 6;
timer_pulo = limite_pulo;

limite_buffer = 6;
timer_queda = 0;
buffer_pulo = false;


// Variaveis de controle
chao = false;
yscale = 1;
xscale = 1;
dura = room_speed/4;
dir = 0;


// State Machine
enum STATE
{
	PARADO, MOVENDO, DASH
}

estado = STATE.PARADO