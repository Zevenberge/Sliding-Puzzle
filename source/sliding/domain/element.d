module sliding.domain.element;

import sliding.domain.direction;
import sliding.domain.neighbourhood;
import sliding.domain.position;
import sliding.domain.avoid;

class Element
{
	this(Position initialPosition)
	{
		_position = initialPosition;
		_neighbourhood = new Neighbourhood;
	}

	invariant
	{
		assert(_position.x > -1 && _position.x < 4);
		assert(_position.y > -1 && _position.y < 4);
	}

	protected
	{
		Neighbourhood _neighbourhood;
		Position _position;
	}

	@property
	{
		pure Neighbourhood neighbourhood()
		{
			return _neighbourhood;
		}

		pure const Position position()
		{
			return _position;
		}

		abstract bool isOnCorrectSpot();

		private final Element[] row()
		{
			Element[] elementsToTheRight;
			if(neighbourhood.rightNeighbour !is null) elementsToTheRight = neighbourhood.rightNeighbour.row;
			return this ~ elementsToTheRight;
		}

		final Element[] allElements()
		{
			Element[] elementsInRowsBeneathThis;
			if(neighbourhood.bottomNeighbour !is null) elementsInRowsBeneathThis = neighbourhood.bottomNeighbour.allElements;
			return row ~ elementsInRowsBeneathThis;
		}

		final bool isSolved()
		{
			import std.algorithm.searching : all;
			return allElements.all!(element => element.isOnCorrectSpot);
		}

		abstract Void void_();	
	}

	void connectToNeighbours(Element[] allElements)
	out
	{
		import std.algorithm;
		import std.array;
		import std.format;
		int amountOfNeighbours = 2;
		if(position.x == 1 || position.x == 2) amountOfNeighbours++;
		if(position.y == 1 || position.y == 2) amountOfNeighbours++;
		auto countedNeighbours = neighbourhood.elements.values.filter!(e => e !is null).array.length;
		assert(countedNeighbours == amountOfNeighbours, 
			"Expected %s neighbours, but got %s".format(amountOfNeighbours, countedNeighbours));
	}
	body
	{
		Direction[Position] vacantNeighbours = [
				position.left : Direction.left,
				position.top : Direction.top,
				position.right : Direction.right,
				position.bottom : Direction.bottom];

		foreach(element; allElements)
		{
			auto vacantDirection = element.position in vacantNeighbours;
			if(vacantDirection !is null)
			{
				neighbourhood.elements[*vacantDirection] = element;
			}
		}
	}
}