/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Checando se estou no chão
chao = place_meeting(x, y + 1, obj_plat);

// Configurando o meu timer do pulo
if (chao)
{
	timer_pulo = limite_pulo;
}
else
{
	if (timer_pulo > 0) timer_pulo--;
}

// Controles
var _left, _right, _up, _down, _jump, _jump_s, _avanco_h, _dash;
_left = keyboard_check(ord("A"));
_right = keyboard_check(ord("D"));
_up = keyboard_check(ord("W"));
_down = keyboard_check(ord("S"));
_jump = keyboard_check_pressed(ord("K"));
_jump_s = keyboard_check_released(ord("K"));
_dash = keyboard_check_pressed(ord("L"));


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
		// movendo
		if (abs(velh) > 0 || abs(velv) > 0 || _left || _right || _jump)
		{
			estado = STATE.MOVENDO;	
		}
		
		// Dash
		if (_dash)
		{
			estado = STATE.DASH;
		}
	
		break;
		
	case STATE.MOVENDO:
	
		// Aplicando a movimentação
		velh = lerp(velh, _avanco_h, acel);
		
	
		// Gravidade
		if (!chao) velv += grav;
		
		// Pulando
		if (_jump && (chao || timer_pulo))
		{
			velv = -max_velv;
			
			// Alterando a escala
			xscale = 0.5;
			yscale = 1.5;
		}
		
		// Buffer do pulo
		if (_jump) timer_queda = limite_buffer;
		
		if(timer_queda > 0) buffer_pulo = true;
		else buffer_pulo = false;
		
		if (buffer_pulo) // Eu posso pular
		{
			if (chao || timer_pulo) // As demais condições são verdadeiras também	
			{
				velv = -max_velv;
				
				// Alterando a escala
				xscale = 0.5;
				yscale = 1.5;
				
				timer_pulo = 0;
				timer_queda = 0;
			}
			
			timer_queda--;
		}
		
		// Controlando a altura do pulo
		if(_jump_s && velv < 0) velv *= 0.7;
		
		
		// Dash
		if (_dash)
		{
			// Decidindo a direção
			dir = point_direction(0, 0, (_right - _left), (_down - _up));

			
			estado = STATE.DASH;
		}
		
		// Limitando as velocidades
		velv = clamp(velv, -max_velv, max_velv);
		
	
		break;
		
	case STATE.DASH:
	
		dura--;
		
		velh = lengthdir_x(len, dir);
		velv = lengthdir_y(len, dir);
		
		// Deformando o player
		if (dir == 90 || dir == 270)
		{
			yscale = 1.5;
			xscale = 0.5;
		}
		else
		{
			yscale = 0.5;
			xscale = 1.5;
		}
		
		
		image_blend = c_red;
		
		// Saindo do estado
		if (dura <= 0)
		{
			estado = STATE.MOVENDO;
			dura = room_speed/4;
			image_blend = c_white;
			
			// Diminuindo a velocidade
			velh = (max_velh * sign(velh) * 0.5);
			velv = (max_velv * sign(velv) * 0.5);
		}
	
		break;
		
}

// Voltando para a escala original
xscale = lerp(xscale, 1, 0.15);
yscale = lerp(yscale, 1, 0.15);


