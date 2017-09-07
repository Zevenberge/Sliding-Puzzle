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
import sliding.ui.util;

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
		import std.experimental.logger;
		auto config = Config();
		_bottomBackground = new RectangleShape(config.screenSize.toVector2f);
		_bottomBackground.fillColor = Color.Blue;
		_boardTexture = "res/board.png".load;
		_board = _boardTexture.createSprite(config.boardSize);
		auto screenSize = FloatRect(Vector2f(0,0), config.screenSize.toVector2f);
		_board.center(screenSize);
		auto topBackgroundSize = config.puzzleSize + 2*config.breathingSpace;
		_topBackground = new RectangleShape(Vector2f(topBackgroundSize, topBackgroundSize));
		_topBackground.center(screenSize);
		_topBackground.fillColor = Color(70,45,24,180);
	}

	private RectangleShape _bottomBackground;
	private Texture _boardTexture;
	private Sprite _board;
	private RectangleShape _topBackground;
	private Control _control;
	private Piece[] _pieces;
	private Picture _picture;

	// TODO : Verplaats deze zooi naar Picture, aangezien dat de klasse is die blijkbaar daarvoor verantwoordelijk is.
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
		target.draw(_board);
		target.draw(_topBackground);
	}

	private void drawPieces(RenderTarget target)
	{
		import std.algorithm.iteration;
		_pieces.each!(p => p.draw(target));
	}
}