module sliding.domain.avoid;

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

	void moveLeftNeighbour()
	{
		move(neighbourhood.leftNeighbour);
	}

	void moveTopNeighbour()
	{
		move(neighbourhood.topNeighbour);
	}

	void moveRightNeighbour()
	{
		move(neighbourhood.rightNeighbour);
	}

	void moveBottomNeighbour()
	{
		move(neighbourhood.bottomNeighbour);
	}

	private void move(Element neighbour)
	{
		if(neighbour is null)
		{
			throw new IllegalMoveException();
		}
		(cast(Tile)neighbour).swap(this);
	}

	void move(Position position, Neighbourhood neighbourhood)
	{
		_position = position;
		_neighbourhood = neighbourhood;
	}
}