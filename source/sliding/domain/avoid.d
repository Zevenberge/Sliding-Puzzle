module sliding.domain.avoid;

import sliding.domain.element;
import sliding.domain.position;

class Void : Element
{
	this()
	{
		super(Position(16));
	}

	@property
	{
		override bool isOnCorrectSpot() 
		{
			return true;
		}

		override Void void_() 
		{
			return this;
		}
	}
}