module sliding.ui.piece;

import dsfml.graphics;
import sliding.domain.position;
import sliding.domain.tile;
import sliding.ui.anime;
import sliding.ui.config;
import sliding.ui.conv;
import sliding.ui.picture;

class Piece
{
	this(Tile tile, const Picture picture)
	{
		_tile = tile;
		_picture = picture.getPiece(tile);
	}

	private Tile _tile;
	private Sprite _picture;
	private Position _position;

	void draw(RenderTarget target)
	{
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

	bool contains(Vector2i coord)
	{
		return _picture.getGlobalBounds.contains(coord);
	}

	void move()
	{
		_tile.move();
	}

	void showError()
	{
		_picture.glowRed(Config().animationDuration);
	}
}