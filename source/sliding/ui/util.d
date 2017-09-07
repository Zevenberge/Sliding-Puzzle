module sliding.ui.util;

import std.algorithm.comparison : min;
import dsfml.graphics;
import sliding.domain.position;
import sliding.ui.config;

IntRect biggestCenteredSquare(IntRect bounds)
{
	auto size = min(bounds.width, bounds.height);
	return IntRect(bounds.left + (bounds.width - size)/2,
		bounds.top + (bounds.height - size)/2,
		size, size);
}

unittest
{
	assert(IntRect(0,0,100,100).biggestCenteredSquare == IntRect(0, 0, 100, 100));
	assert(IntRect(0,0,100,200).biggestCenteredSquare == IntRect(0, 50, 100, 100));
	assert(IntRect(0,0,200,100).biggestCenteredSquare == IntRect(50, 0, 100, 100));
	assert(IntRect(1000,2000,200,100).biggestCenteredSquare == IntRect(1050, 2000, 100, 100));
}

IntRect getRelativeRectangle(IntRect bounds, Position position)
{
	import std.conv;
	// Assume squared.
	auto config = Config();
	auto conversionRate = bounds.width.to!float / config.puzzleSize;
	auto stepSize = conversionRate * (config.pieceSize + config.breathingSpace);
	auto convertedSize = (conversionRate * config.pieceSize).to!int;
	return IntRect((bounds.left + stepSize * position.x).to!int,
		(bounds.top + stepSize * position.y).to!int,
		convertedSize, convertedSize);
}

void setPixels(Sprite sprite, float size)
{
	FloatRect spriteSize = sprite.getGlobalBounds();
	Vector2f scale0 = sprite.scale;
	float adjustment = size/spriteSize.width;
	sprite.scale = scale0 * adjustment;
}

Texture load(string filename)
{
	import sliding.ui.exception;
	auto texture = new Texture;
	if(!texture.loadFromFile(filename))
	{
		throw new LoadFromFileFailedException(filename);
	}
	return texture;
}

Sprite createSprite(const Texture texture, float finalSpriteSize)
{
	auto sprite = new Sprite(texture);
	sprite.setPixels(finalSpriteSize);
	return sprite;
}

void center(T)(T transformable, const FloatRect rect) 
{
	auto size = transformable.getGlobalBounds;
	auto x = rect.left + (rect.width - size.width)/2.;
	auto y = rect.top + (rect.height - size.height)/2.;
	transformable.position = Vector2f(x,y);
}