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
			if(neighbourhood.rightNeighbour !is null)
			{
				auto possibleVoid = neighbourhood.rightNeighbour.void_;
				if(possibleVoid !is null) return possibleVoid;
			}
			if(neighbourhood.bottomNeighbour !is null)
			{
				return neighbourhood.bottomNeighbour.void_;
			}
			return null;
		}
	}

	void swap(Void void_)
	{
		auto oldNeighbours = neighbourhood;
		_neighbourhood = void_.neighbourhood;
		auto oldPosition = position;
		_position = void_.position;
		void_.move(oldPosition, oldNeighbours);
	}
}