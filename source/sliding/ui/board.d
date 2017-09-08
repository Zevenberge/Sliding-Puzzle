module sliding.ui.board;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.ui.config;
import sliding.ui.controls;
import sliding.ui.conv;
import sliding.ui.picture;
import sliding.ui.util;

class Board
{
	this(Void void_, string filename)
	{
		_picture = new Picture(void_, filename);
		_control = new KeyboardControl(void_);
		initializeBackground;
	}

	private void initializeBackground()
	{
		auto config = Config();
		_bottomTexture = "res/board-bg.png".load;
		_bottomBackground = _bottomTexture.createSprite(config.screenSize.x);
		_bottomBackground.color = Color(150,150,150,255);
		_boardTexture = "res/board.png".load;
		_board = _boardTexture.createSprite(config.boardSize);
		auto screenSize = FloatRect(Vector2f(0,0), config.screenSize.toVector2f);
		_board.center(screenSize);
		auto topBackgroundSize = config.puzzleSize + 2*config.breathingSpace;
		_topBackground = new RectangleShape(Vector2f(topBackgroundSize, topBackgroundSize));
		_topBackground.center(screenSize);
		_topBackground.fillColor = Color(70,45,24,180);
	}

	private Texture _bottomTexture;
	private Sprite _bottomBackground;
	private Texture _boardTexture;
	private Sprite _board;
	private RectangleShape _topBackground;
	private Control _control;
	private Picture _picture;

	bool handle(Event event)
	{
		return _control.handle(event);
	}

	void draw(RenderTarget target)
	{
		drawBackground(target);
		_picture.draw(target);
	}

	private void drawBackground(RenderTarget target)
	{
		target.draw(_bottomBackground);
		target.draw(_board);
		target.draw(_topBackground);
	}
}