﻿module sliding.ui.config;

import dsfml.system;

struct Config
{
	int pieceSize = 100;
	int breathingSpace = 5;
	Vector2i screenSize = Vector2f(500,500);

	int puzzleSize() @property pure const
	{
		return 4*pieceSize + 3*breathingSpace;
	}
}
