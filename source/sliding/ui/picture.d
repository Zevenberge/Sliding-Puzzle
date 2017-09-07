module sliding.ui.picture;

import dsfml.graphics;
import sliding.domain.tile;
import sliding.ui.config;
import sliding.ui.conv;
import sliding.ui.util;

class Picture
{
	this(string filename)
	{
		load(filename);
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

	Sprite getPiece(const Tile tile) const
	{
		auto config = Config();
		auto textureRect = _areaOfInterest.getRelativeRectangle(tile.correctPosition);
		auto sprite = new Sprite(_texture);
		sprite.textureRect = textureRect;
		sprite.setPixels(config.pieceSize);
		return sprite;
	}
}