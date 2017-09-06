module sliding.domain.randomizer;

import std.conv;
import std.random;
import sliding.domain.avoid;
import sliding.domain.direction;
import sliding.domain.exception;

class Randomizer
{
	private int _amountOfMoves = 1000;
	void shuffle(Void void_)
	{
		auto previousHandler = void_.exceptionBehaviourHandler;
		void_.exceptionBehaviourHandler = new NoThrowBehaviourHandler;
		foreach(_; 0  .. _amountOfMoves)
		{
			void_.move(uniform!Direction);
		}
		void_.exceptionBehaviourHandler = previousHandler;
	}
}