// Get Player Input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(vk_space) || keyboard_check(ord("W"));

// Calculate horizontal movement
var move = key_right - key_left;
horSpeed = move * walkSpeed;

// Calculate vertical movement
verSpeed += gravityForce;

// Calculate Jump
if (place_meeting(x,y+1,oWall) && key_jump) 
{
	verSpeed = -9;
}

// Horizontal Collision
if (place_meeting(x+horSpeed, y, oWall))
{
	while (!place_meeting(x+sign(horSpeed), y, oWall))
	{
		x += sign(horSpeed);
	}
	horSpeed = 0;
}

// Vertical Collision
if (place_meeting(x, y + verSpeed, oWall))
{
	while (!place_meeting(x, y + sign(verSpeed), oWall))
	{
		y += sign(verSpeed);
	}
	verSpeed = 0;
}

// --- COLISIONES DOWN WALL ---

colisionDesdeArribaDownWall = place_meeting(x, y + (verSpeed * sign(verSpeed)), oDownWall)
colisionDesdeAbajoDownWall = place_meeting(x, y + (verSpeed * sign(verSpeed) * (-1)), oDownWall)

if (colisionDesdeArribaDownWall && colisionActualDownWall != "Abajo")
{
	show_debug_message("Colision Arriba")
	
	colisionActualDownWall = "Arriba"
}


if (colisionDesdeAbajoDownWall && colisionActualDownWall != "Arriba")
{
	show_debug_message("Colision Abajo")
	
	colisionActualDownWall = "Abajo"
	
	while (!place_meeting(x, y + verSpeed, oDownWall))
	{
		y += verSpeed;
	}
	verSpeed = 0;
}

if (!colisionDesdeAbajoDownWall && !colisionDesdeArribaDownWall)
{
	show_debug_message("Reseteando Colision");
	colisionActualDownWall = ""
}

// --- COLISIONES UP WALL ---

colisionDesdeArribaUpWall = place_meeting(x, y + (verSpeed * sign(verSpeed)), oUpWall)
colisionDesdeAbajoUpWall = place_meeting(x, y + (verSpeed * sign(verSpeed) * (-1)), oUpWall)

if (colisionDesdeArribaUpWall && colisionActualUpWall != "Abajo")
{
	show_debug_message("Colision Arriba")
	
	colisionActualUpWall = "Arriba"
	
	while (!place_meeting(x, y + sign(verSpeed), oUpWall))
	{
		y += sign(verSpeed);
	}
	verSpeed = 0;
}

if (colisionDesdeAbajoUpWall && colisionActualUpWall != "Arriba")
{
	show_debug_message("Colision Abajo")
	
	colisionActualUpWall = "Abajo"
}

if (!colisionDesdeAbajoUpWall && !colisionDesdeArribaUpWall)
{
	show_debug_message("Reseteando Colision");
	colisionActualUpWall = ""
}

// Move in X direction
x += horSpeed;
// Move in Y direction
y += verSpeed;