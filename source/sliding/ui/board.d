module sliding.ui.board;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.ui.controls;
import sliding.ui.piece;

class Board
{
	this()
	{
		_control = new KeyboardControl(new Void);
	}

	private Control _control;
	private Piece[] _pieces;

	bool handle(Event event)
	{
		return _control.handle(event);
	}

	void draw(RenderTarget target)
	{
		drawBackground(target);
		drawPieces(target);
	}

	private void drawBackground(RenderTarget target)
	{

	}

	private void drawPieces(RenderTarget target)
	{
		import std.algorithm.iteration;
		_pieces.each!(p => p.draw(target));
	}
}