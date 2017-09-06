module sliding.domain.element;

import sliding.domain.direction;
import sliding.domain.neighbourhood;
import sliding.domain.position;
import sliding.domain.avoid;

class Element
{
	this(Position initialPosition)
	{
		_neighbourhood = new Neighbourhood(initialPosition);
	}



	protected
	{
		Neighbourhood _neighbourhood;
	}

	@property
	{
		pure Neighbourhood neighbourhood()
		{
			return _neighbourhood;
		}

		pure const Position position()
		{
			return _neighbourhood.position;
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
unittest
{
	import std.algorithm;
	import sliding.domain.tile;
	auto tile1 = new Tile(1);
	tile1.connectToNeighbours([tile1]);
	assert(tile1.neighbourhood.elements.values.all!(e => e is null));
}

unittest
{
	import std.algorithm;
	import sliding.domain.tile;
	auto tile1 = new Tile(1);
	auto tile15 = new Tile(15);
	tile1.connectToNeighbours([tile1, tile15]);
	assert(tile1.neighbourhood.elements.values.all!(e => e is null));
}

unittest
{
	import sliding.domain.tile;
	auto tile1 = new Tile(1);
	auto tile2 = new Tile(2);
	tile1.connectToNeighbours([tile1, tile2]);
	assert(tile1.neighbourhood.rightNeighbour is tile2);
}
unittest
{
	import sliding.domain.tile;
	auto tile1 = new Tile(1);
	auto tile5 = new Tile(5);
	tile1.connectToNeighbours([tile1, tile5]);
	assert(tile1.neighbourhood.bottomNeighbour is tile5);
}