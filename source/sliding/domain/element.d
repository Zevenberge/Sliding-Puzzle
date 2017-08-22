module sliding.domain.element;

import sliding.domain.position;
import sliding.domain.avoid;

class Element
{
	this(Position initialPosition)
	{
		position = initialPosition;
	}

	protected
	{
		Element leftNeighbour;
		Element topNeighbour;
		Element rightNeighbour;
		Element bottomNeighbour;
		Position position;
	}

	@property
	{
		abstract bool isOnCorrectSpot();

		private final Element[] row()
		{
			Element[] elementsToTheRight;
			if(rightNeighbour !is null) elementsToTheRight = rightNeighbour.row;
			return this ~ elementsToTheRight;
		}

		private final Element[] allElements()
		{
			Element[] elementsInRowsBeneathThis;
			if(bottomNeighbour !is null) elementsInRowsBeneathThis = bottomNeighbour.allElements;
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
				position.left : &leftNeighbour,
				position.top : &topNeighbour,
				position.right : &rightNeighbour,
				position.bottom : &bottomNeighbour];

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