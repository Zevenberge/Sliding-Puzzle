module sliding.ui.controls;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.domain.direction;

interface Control
{
	bool handle(Event event);
}

class KeyboardControl : Control
{
	this(Void void_)
	{
		_void = void_;
	}

	private Void _void;

	bool handle(Event event)
	{
		if(event.type == Event.EventType.KeyPressed)
		{
			return handleKey(event.key.code);
		}
		return false;
	}

	private bool handleKey(Keyboard.Key key)
	{
		switch(key) with (Keyboard.Key)
		{
			case Left:
				_void.move(Direction.left);
				return true;
			case Up:
				_void.move(Direction.top);
				return true;
			case Right:
				_void.move(Direction.right);
				return true;
			case Down:
				_void.move(Direction.bottom);
				return true;
			default:
				return false;
		}
	}
}
