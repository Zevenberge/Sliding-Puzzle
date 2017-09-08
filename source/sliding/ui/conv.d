module sliding.ui.conv;

import std.conv;
import dsfml.graphics;
import sliding.domain.position;
import sliding.ui.config;

Vector2f toPixels(const Position position)
{
	auto config = Config();
	auto topLeft = Vector2f(
		(config.screenSize.x - config.puzzleSize)/2f,
		(config.screenSize.y - config.puzzleSize)/2f
		);
	auto shift = config.pieceSize + config.breathingSpace;
	return topLeft + 
		Vector2f(shift * position.x, 
			shift * position.y);
}

FloatRect toFloatRect(const Vector2i size)
{
	return FloatRect(0, 0, size.x, size.y);
}

Vector2f toVector2f(const Vector2i orig)
{
	return Vector2f(orig.x, orig.y);
}

Vector2i toVector2i(const Vector2u orig)
{
	return Vector2i(orig.x.to!int, orig.y.to!int);
}

Vector2i toVector2i(const Event.MouseButtonEvent event)
{
	return Vector2i(event.x, event.y);
}