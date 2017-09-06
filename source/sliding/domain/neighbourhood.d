module sliding.domain.neighbourhood;

import sliding.domain.direction;
import sliding.domain.element;

class Neighbourhood
{
	this()
	{
		elements = [Direction.bottom : null,
					Direction.left : null,
					Direction.right : null,
					Direction.top : null];
	}

	Element[Direction] elements;

	@property:

	Element rightNeighbour()
	{
		return elements[Direction.right];
	}
	Element bottomNeighbour()
	{
		return elements[Direction.bottom];
	}

	void changeNeighbour(Element neighbour, Direction position)
	{
		elements[position] = neighbour;
	}

	void updateNeighbours(Element underlying)
	{
		foreach(direction, neighbour; elements)
		{
			if(neighbour is null) continue;
			neighbour.neighbourhood.changeNeighbour(underlying, direction.opposite);
		}
	}

}