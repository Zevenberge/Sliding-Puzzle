module sliding.ui.piece;

import dsfml.graphics;
import sliding.domain.position;
import sliding.domain.tile;
import sliding.ui.config;
import sliding.ui.conv;

class Piece
{
	this(const Tile tile)
	{
		_tile = tile;
		initializePicture;
	}

	private void initializePicture()
	{
		auto config = Config();
		_picture = new RectangleShape(Vector2f(config.pieceSize, config.pieceSize));
		_picture.fillColor = Color.Red;
	}

	private const Tile _tile;
	private RectangleShape _picture;
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
}