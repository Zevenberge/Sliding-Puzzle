module sliding.ui.board;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.domain.randomizer;
import sliding.ui.anime;
import sliding.ui.config;
import sliding.ui.controls;
import sliding.ui.conv;
import sliding.ui.picture;
import sliding.ui.util;

class Board
{
	this(Void void_)
	{
		_void = void_;
		initializeBackground;
		_puzzles = getFilenamesFromFolder;
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

	private Void _void;
	private string[] _puzzles;
	private Picture _picture;
	private bool _isInitialised;

	void setUpPuzzle()
	{
		auto filename = _puzzles[0];
		_puzzles = _puzzles[1..$];
		shufflePuzzle;
		_picture = new Picture(_void, filename);
		_control = new KeyboardAndMouseControl(_void, _picture.pieces);
		_isInitialised = true;
	}

	private void shufflePuzzle()
	{
		auto randomizer = new Randomizer;
		randomizer.shuffle(_void);
	}

	private Control _control;
	bool handle(Event event)
	{
		return _isInitialised && _control.handle(event);
	}

	private Texture _bottomTexture;
	private Sprite _bottomBackground;
	private Texture _boardTexture;
	private Sprite _board;
	private RectangleShape _topBackground;
	void draw(RenderTarget target)
	{
		drawBackground(target);
		if(_isInitialised) _picture.draw(target);
	}

	private void drawBackground(RenderTarget target)
	{
		target.draw(_bottomBackground);
		target.draw(_board);
		target.draw(_topBackground);
	}

	bool isPuzzleSolved()
	{
		return _picture.isPuzzleSolved;
	}

	bool areAllPuzzlesSolved()
	{
		import std.array;
		return isPuzzleSolved && _puzzles.empty;
	}

	Animation startShowingSolution()
	{
		return _picture.startShowingSolution;
	}
}

private string[] getFilenamesFromFolder()
{
	return ["res/example.png"];
}