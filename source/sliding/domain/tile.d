module sliding.domain.tile;

import sliding.domain.avoid;
import sliding.domain.element;
import sliding.domain.position;

class Tile : Element
{
	this(int tileNumber)
	{
		this(Position(tileNumber));
	}

	this(Position positionOfTile)
	{
		correctPosition = positionOfTile;
		super(positionOfTile);
	}

	private const Position correctPosition;

	@property
	{
		override bool isOnCorrectSpot() 
		{
			return correctPosition == position;
		}

		override Void void_() 
		{
			if(rightNeighbour !is null)
			{
				auto possibleVoid = rightNeighbour.void_;
				if(possibleVoid !is null) return possibleVoid;
			}
			if(bottomNeighbour !is null)
			{
				return bottomNeighbour.void_;
			}
			return null;
		}
	}
}