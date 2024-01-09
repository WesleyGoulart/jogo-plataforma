/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Checando se estou no chão
chao = place_meeting(x, y + 1, obj_plat);
parede_dir = place_meeting(x + 1, y, obj_plat);
parede_esq = place_meeting(x - 1, y, obj_plat);

// Configurando o meu timer do pulo
if (chao)
{
	timer_pulo = limite_pulo;
	carga = 1;
}
else
{
	if (timer_pulo > 0) timer_pulo--;
}

if (parede_dir || parede_esq)
{
	if(parede_dir) ultima_parede = 0;
	else ultima_parede = 1;
	timer_parede = limite_parede;
}
else
{
	if (timer_parede > 0) timer_parede--;
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
		if (_dash && carga > 0)
		{
			// Decidindo a direção
			dir = point_direction(0, 0, (_right - _left), (_down - _up));

			
			estado = STATE.DASH;
			carga--;
		}
	
		break;
		
	case STATE.MOVENDO:
	
	
		// Abaixando
		if (chao && _down)
		{
			xscale = 1.5;
			yscale = 0.5;
		}
	
		// Aplicando a movimentação
		velh = lerp(velh, _avanco_h, acel);
		
		// Fazendo poeira
		if (abs(velh) > max_velh - 0.5 && chao)
		{
			var _chance = random(100);
			if (_chance > 90)
			{
				for (var _i = 0; _i < irandom_range(4, 10); _i++)
				{
				var _xx = random_range(x - sprite_width/2, x + sprite_width/2);
		
				instance_create_depth(_xx, y, depth - 1000, obj_vel);	
				}
			}
		}
	
		// Gravidade e parede
		if (!chao && (parede_dir || parede_esq || timer_parede))
		{
			// Não estou no chão, mas estou na parede
			if (velv > 0) // Estou na parede e estou caindo
			{
				velv = lerp(velv, deslize, acel);
				var _chance = random(100);
				if (_chance > 90)
				{
					for (var _i = 0; _i < irandom_range(4, 10); _i++)
					{
						var _onde = parede_dir - parede_esq;
						var _xx = x + _onde * sprite_width/2;
						var _yy = y + random_range(-sprite_height/2, 0);
		
						instance_create_depth(_xx, _yy, depth - 1000, obj_vel);	
					}
				}
			}
			else
			{
				// Estou subindo
				velv += grav;
			}
			
			// Pulando pelas paredes
			if (!ultima_parede && _jump) // Estou na parede e tentei pular
			{
				velv = -max_velv;
				velh = -max_velh;
				xscale = 0.5;
				yscale = 1.5;
				
				// Criando poeira
				for (var _i = 0; _i < irandom_range(4, 10); _i++)
				{
					var _onde = parede_dir - parede_esq;
					var _xx = x + sprite_width/2;
					var _yy = y + random_range(-sprite_height/2, 0);
		
					instance_create_depth(_xx, _yy, depth - 1000, obj_vel);	
				}
			}
			else if (ultima_parede && _jump)
			{
				velv = -max_velv;
				velh = max_velh;
				xscale = 0.5;
				yscale = 1.5;	
				
				// Criando poeira
				for (var _i = 0; _i < irandom_range(4, 10); _i++)
				{
					var _onde = parede_dir - parede_esq;
					var _xx = x - sprite_width/2;
					var _yy = y + random_range(-sprite_height/2, 0);
		
					instance_create_depth(_xx, _yy, depth - 1000, obj_vel);	
				}
			}
		}
		else if (!chao) // Não estou no chão, nem na parede
		{
			velv += grav;
		}
		
		
		// Pulando
		if (_jump && (chao || timer_pulo))
		{
			velv = -max_velv;
			
			// Alterando a escala
			xscale = 0.5;
			yscale = 1.5;
			
			
		// Criando a poeira
		for (var _i = 0; _i < irandom_range(4, 10); _i++)
		{
			var _xx = random_range(x - sprite_width, x + sprite_width);
		
			instance_create_depth(_xx, y, depth - 1000, obj_vel);
		}
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
				
				
				
				// Criando a poeira
				for (var _i = 0; _i < irandom_range(4, 10); _i++)
				{
					var _xx = random_range(x - sprite_width, x + sprite_width);
		
					instance_create_depth(_xx, y, depth - 1000, obj_vel);
				}
			}
			
			timer_queda--;
		}
		
		// Controlando a altura do pulo
		if(_jump_s && velv < 0) velv *= 0.7;
		
		
		// Dash
		if (_dash && carga > 0)
		{
			// Decidindo a direção
			dir = point_direction(0, 0, (_right - _left), (_down - _up));

			
			estado = STATE.DASH;
			carga--;
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
		
		
		// Criando o rastro
		var _rastro = instance_create_layer(x, y, layer, obj_player_vest);
		_rastro.xscale = xscale;
		_rastro.yscale = yscale;
		
		
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
		
		
		case STATE.MORTE:
		
			room_restart();
		
}


switch(carga)
{
	case 0:
	sat = lerp(sat, 50, 0.05);
	break;
	
	case 1:
	sat = lerp(sat, 255, 0.05);
	break;
}

// Definindo a cor dele
image_blend = make_color_hsv(20, sat, 255);


// Voltando para a escala original
xscale = lerp(xscale, 1, 0.15);
yscale = lerp(yscale, 1, 0.15);


