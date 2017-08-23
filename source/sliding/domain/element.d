module sliding.domain.element;

import sliding.domain.neighbourhood;
import sliding.domain.position;
import sliding.domain.avoid;

class Element
{
	this(Position initialPosition)
	{
		_position = initialPosition;
	}

	protected
	{
		Neighbourhood _neighbourhood;
		Position _position;
	}

	@property
	{
		Neighbourhood neighbourhood()
		{
			return _neighbourhood;
		}

		Position position()
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

		private final Element[] allElements()
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
	{
		Element*[Position] vacantNeighbours = [
				position.left : &neighbourhood.leftNeighbour,
				position.top : &neighbourhood.topNeighbour,
				position.right : &neighbourhood.rightNeighbour,
				position.bottom : &neighbourhood.bottomNeighbour];

		foreach(element; allElements)
		{
			auto vacancy = element.position in vacantNeighbours;
			if(vacancy !is null)
			{
				*vacancy = &element;
			}
		}
	}
}