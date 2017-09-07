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
		auto neighbour = _neighbourhood.elements[direction.opposite];
		if(neighbour is null)
		{
			exceptionBehaviourHandler.onIllegalMove;
		}
		else
		{
			(cast(Tile)neighbour).swap(this, direction);
		}
	}

	void move(Neighbourhood neighbourhood, Tile swappedTile, Direction directionOfTile)
	{
		_neighbourhood = neighbourhood;
		_neighbourhood.elements[directionOfTile] = swappedTile;
		_neighbourhood.updateNeighbours(this);
	}
}
unittest
{
	auto void_ = new Void;
	auto tile = new Tile(15);
	void_.connectToNeighbours([tile]);
	tile.connectToNeighbours([void_]);
	void_.move(Direction.right);
	assert(void_.position == Position(15));
	assert(tile.position == Position(16));
}
unittest
{
	auto void_ = new Void;
	auto tile = new Tile(15);
	void_.connectToNeighbours([tile]);
	tile.connectToNeighbours([void_]);
	void_.move(Direction.right);
	assert(void_.neighbourhood.elements[Direction.right] is tile);
	assert(tile.neighbourhood.elements[Direction.left] is void_);
}