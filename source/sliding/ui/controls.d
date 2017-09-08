module sliding.ui.controls;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.domain.direction;
import sliding.domain.exception;
import sliding.ui.conv;
import sliding.ui.piece;

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
				_void.move(Direction.right);
				return true;
			case Up:
				_void.move(Direction.bottom);
				return true;
			case Right:
				_void.move(Direction.left);
				return true;
			case Down:
				_void.move(Direction.top);
				return true;
			default:
				return false;
		}
	}
}

class MouseControl : Control
{
	this(Piece[] allPieces)
	{
		_allPieces = allPieces;
	}

	private Piece[] _allPieces;
	bool handle(Event event)
	{
		if(event.type == Event.EventType.MouseButtonReleased)
		{
			return handleClick(event.mouseButton);
		}
		return false;
	}

	private bool handleClick(Event.MouseButtonEvent event)
	{
		auto coord = event.toVector2i;
		foreach(piece; _allPieces)
		{
			if(piece.contains(coord))
			{
				try
				{
					piece.move;
					return true;
				}
				catch(IllegalMoveException)
				{
					import std.experimental.logger;
					info("No touching there");
					piece.showError;
					return false;
				}
			}
		}
		return false;
	}
}

class KeyboardAndMouseControl : Control
{
	this(Void void_, Piece[] allPieces)
	{
		_keyboard = new KeyboardControl(void_);
		_mouse = new MouseControl(allPieces);
	}

	private KeyboardControl _keyboard;
	private MouseControl _mouse;

	bool handle(Event event)
	{
		return _keyboard.handle(event) || _mouse.handle(event);
	}
}