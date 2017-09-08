module sliding.ui.picture;

import dsfml.graphics;
import sliding.domain.avoid;
import sliding.domain.exception;
import sliding.domain.tile;
import sliding.ui.config;
import sliding.ui.conv;
import sliding.ui.piece;
import sliding.ui.util;

class Picture
{
	this(Void void_, string filename)
	{
		import std.algorithm;
		import std.array;
		void_.exceptionBehaviourHandler = new ThrowingBehaviourHandler;
		load(filename);
		_pieces = void_.allElements
					.map!(e => cast(Tile)e)
					.filter!(t => t !is null)
					.map!(t => new Piece(t, this))
					.array;
		determineAreaOfInterest;
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

	private Texture _texture;
	private IntRect _areaOfInterest;
	private Piece[] _pieces;

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
	}
}