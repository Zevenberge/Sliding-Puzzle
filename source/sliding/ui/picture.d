module sliding.ui.picture;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.domain.exception;
import sliding.domain.tile;
import sliding.ui.anime;
import sliding.ui.config;
import sliding.ui.conv;
import sliding.ui.piece;
import sliding.ui.util;

class Picture
{
	this(Void void_, string filename)
	{
		void_.exceptionBehaviourHandler = new ThrowingBehaviourHandler;
		_void = void_;
		load(filename);
		determineAreaOfInterest;
		hideSolution;
		gatherAllPieces(void_);
	}

	private void load(string filename)
	{
		_texture = .load(filename);
	}

	private void determineAreaOfInterest()
	{
		auto size = _texture.getSize;
		_areaOfInterest = IntRect(Vector2i(), size.toVector2i).biggestCenteredSquare;
	}

	private void hideSolution()
	{
		auto config = Config();
		_solution = new Sprite(_texture);
		_solution.textureRect = _areaOfInterest;
		_solution.setPixels(config.puzzleSize);
		_solution.center(config.screenSize.toFloatRect);
		_solution.color = Color(255,255,255,0);
	}

	private void gatherAllPieces(Void void_)
	{
		import std.algorithm;
		import std.array;
		_pieces = void_.allElements
					.map!(e => cast(Tile)e)
					.filter!(t => t !is null)
					.map!(t => new Piece(t, this))
					.array;
	}

	private Texture _texture;
	private IntRect _areaOfInterest;
	private Sprite _solution;
	private Piece[] _pieces;
	private Void _void;

	Sprite getPiece(const Tile tile) const
	{
		auto config = Config();
		auto textureRect = _areaOfInterest.getRelativeRectangle(tile.correctPosition);
		auto sprite = new Sprite(_texture);
		sprite.textureRect = textureRect;
		sprite.setPixels(config.pieceSize);
		return sprite;
	}

	void draw(RenderTarget target)
	{
		import std.algorithm.iteration;
		_pieces.each!(p => p.draw(target));
		target.draw(_solution);
	}

	bool isPuzzleSolved()
	{
		return _void.isSolved;
	}

	Animation startShowingSolution()
	{
		return _solution.appear(Config().animationDuration);
	}
}