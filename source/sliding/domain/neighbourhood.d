module sliding.domain.neighbourhood;

import sliding.domain.direction;
import sliding.domain.element;

class Neighbourhood
{
	Element[Direction] elements;

	@property:
	Element leftNeighbour()
	{
		return elements[Direction.left];
	}
	Element topNeighbour()
	{
		return elements[Direction.top];
	}
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
			neighbour.neighbourhood.changeNeighbour(underlying, direction.opposite);
		}
	}

}