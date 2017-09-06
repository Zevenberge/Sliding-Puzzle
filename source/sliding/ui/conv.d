module sliding.ui.conv;

import dsfml.system;
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