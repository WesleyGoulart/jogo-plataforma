/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Checando se estou no chão
chao = place_meeting(x, y + 1, obj_plat)

// Controles
var _left, _right, _jump, _avanco_h;
_left = keyboard_check(ord("A"));
_right = keyboard_check(ord("D"));
_jump = keyboard_check(ord("K"));

// Configurando informações da movimentação
_avanco_h = (_right - _left) * max_velh;
// valor da aceleração
if (chao) acel = acel_chao
else acel = acel_ar


// STATE MACHINE
switch(estado)
{
	case STATE.PARADO:
	
		velh = 0;
		velv = 0;
		
		// Posso mudar minha velocidade
		// Pulando
		if (_jump && chao)
		{
			velv = -max_velv;
		}
		
		// Aplicando gravidade também
		if (!chao) velv += grav;
		
		// Saindo do estado
		
		if (abs(velh) > 0 || abs(velv) > 0 || _left || _right || _jump)
		{
			estado = STATE.MOVENDO;	
		}
	
		break;
		
	case STATE.MOVENDO:
	
		// Aplicando a movimentação
		velh = lerp(velh, _avanco_h, acel);
		
	
		// Gravidade
		if (!chao) velv += grav;
		
		// Pulando
		if (chao && _jump) velv = -max_velv;
	
		break;
		
	case STATE.DASH:
	
		break;
		
}


// Limitando as velocidades
velv = clamp(velv, -max_velv, max_velv);