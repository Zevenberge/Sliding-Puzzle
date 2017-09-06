module sliding.domain.avoid;

import sliding.domain.direction;
import sliding.domain.element;
import sliding.domain.exception;
import sliding.domain.neighbourhood;
import sliding.domain.position;
import sliding.domain.tile;

class Void : Element
{
	this()
	{
		super(Position(16));
		exceptionBehaviourHandler = new NoThrowBehaviourHandler;
	}

	ExceptionalBehaviourHandler exceptionBehaviourHandler;

	invariant
	{
		assert(exceptionBehaviourHandler !is null, "Behaviour handling should always be defined");
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

	void move(Direction direction)
	{
		auto neighbour = _neighbourhood.elements[direction];
		if(neighbour is null)
		{
			exceptionBehaviourHandler.onIllegalMove;
		}
		else
		{
			(cast(Tile)neighbour).swap(this, direction);
		}
	}

	void move(Position position, Neighbourhood neighbourhood, Tile swappedTile, Direction directionOfTile)
	{
		_position = position;
		neighbourhood.changeNeighbour(swappedTile, directionOfTile);
		_neighbourhood = neighbourhood;
		_neighbourhood.updateNeighbours(this);
	}
}