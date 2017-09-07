module sliding.domain.neighbourhood;

import sliding.domain.direction;
import sliding.domain.element;
import sliding.domain.position;

class Neighbourhood
{
	this(Position position)
	in
	{
		assert(position.x > -1 && position.x < 4);
		assert(position.y > -1 && position.y < 4);
	}
	body
	{
		this.position = position;
		elements = [Direction.bottom : null,
					Direction.left : null,
					Direction.right : null,
					Direction.top : null];
	}

	Element[Direction] elements;
	const Position position;

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
			if(neighbour is null) continue;
			neighbour.neighbourhood.changeNeighbour(underlying, direction.opposite);
		}
	}
}

unittest
{
	import sliding.domain.avoid;
	auto element = new Void;
	auto neighbour = new Void;
	auto subject = element.neighbourhood;
	subject.elements[Direction.right] = neighbour;
	subject.updateNeighbours(element);
	assert(neighbour.neighbourhood.elements[Direction.left] is element);
}