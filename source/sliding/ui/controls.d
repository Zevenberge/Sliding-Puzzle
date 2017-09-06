module sliding.ui.controls;

import dsfml.graphics;

interface Control
{
	bool handle(Event event);
}

