module sliding.ui.piece;

import dsfml.graphics;
import sliding.domain.position;
import sliding.domain.tile;
import sliding.ui.config;
import sliding.ui.conv;
import sliding.ui.picture;

class Piece
{
	this(const Tile tile, const Picture picture)
	{
		_tile = tile;
		_picture = picture.getPiece(tile);
	}

	private const Tile _tile;
	private Sprite _picture;
	private Position _position;

	void draw(RenderTarget target)
	{
		import std.experimental.logger;
		updatePosition;
		target.draw(_picture);
	}

	private void updatePosition()
	{
		if(_position != _tile.position)
		{
			_position = _tile.position;
			_picture.position = _position.toPixels;
		}
	}
}