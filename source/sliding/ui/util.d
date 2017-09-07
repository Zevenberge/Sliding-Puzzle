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
	// Assume squared.
	auto config = Config();
	auto conversionRate = bounds.width / config.puzzleSize;
	auto stepSize = conversionRate * (config.pieceSize + config.breathingSpace);
	auto convertedSize = conversionRate * config.pieceSize;
	return IntRect(bounds.left + stepSize * position.x,
		bounds.top + stepSize * position.y,
		convertedSize, convertedSize);
}