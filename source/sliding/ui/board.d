module sliding.ui.board;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.domain.exception;
import sliding.domain.tile;
import sliding.ui.config;
import sliding.ui.controls;
import sliding.ui.conv;
import sliding.ui.picture;
import sliding.ui.piece;

class Board
{
	this(Void void_, string filename)
	{
		import std.algorithm;
		import std.array;
		void_.exceptionBehaviourHandler = new ThrowingBehaviourHandler;
		_picture = new Picture(filename);
		_pieces = void_.allElements
					.map!(e => cast(Tile)e)
					.filter!(t => t !is null)
					.map!(t => new Piece(t, _picture))
					.array;
		_control = new KeyboardControl(void_);
		initializeBackground;
	}

	private void initializeBackground()
	{
		auto config = Config();
		_bottomBackground = new RectangleShape(config.screenSize.toVector2f);
		_bottomBackground.fillColor = Color.Blue;
		_topBackground = new RectangleShape(config.screenSize.toVector2f - Vector2f(50,50));
		_topBackground.fillColor = Color.Green;
	}

	private RectangleShape _bottomBackground;
	private RectangleShape _topBackground;
	private Control _control;
	private Piece[] _pieces;
	private Picture _picture;

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
		target.draw(_bottomBackground);
		target.draw(_topBackground);
	}

	private void drawPieces(RenderTarget target)
	{
		import std.algorithm.iteration;
		_pieces.each!(p => p.draw(target));
	}
}