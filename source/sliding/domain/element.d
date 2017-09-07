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

		private Element topLeftElement()
		{
			if(_neighbourhood.topNeighbour !is null)
			{
				return _neighbourhood.topNeighbour.topLeftElement;
			}
			if(_neighbourhood.leftNeighbour !is null)
			{
				return _neighbourhood.leftNeighbour.topLeftElement;
			}
			return this;
		}

		pure const Position position()
		{
			return _neighbourhood.position;
		}

		abstract bool isOnCorrectSpot();

		private Element[] row()
		{
			Element[] elementsToTheRight;
			if(neighbourhood.rightNeighbour !is null) elementsToTheRight = neighbourhood.rightNeighbour.row;
			return this ~ elementsToTheRight;
		}

		final Element[] allElements()
		{
			return topLeftElement.allElementsImpl;
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

	private Element[] allElementsImpl()
	{
		Element[] elementsInRowsBeneathThis;
		if(neighbourhood.bottomNeighbour !is null) elementsInRowsBeneathThis = neighbourhood.bottomNeighbour.allElementsImpl;
		return row ~ elementsInRowsBeneathThis;
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

unittest
{
	import sliding.domain.factory;
	import sliding.domain.tile;
	auto tile11 = new Tile(1);
	auto tile12 = new Tile(2);
	auto tile21 = new Tile(5);
	auto tile22 = new Tile(6);
	new Factory().connectElements([tile11, tile12, tile21, tile22]);
	assert(tile11.allElements.length == 4);
	assert(tile22.allElements.length == 4);
}