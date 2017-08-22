module sliding.domain.factory;

import std.algorithm.iteration : map, each;
import std.array : array;
import std.range : iota;
import sliding.domain.avoid;
import sliding.domain.element;
import sliding.domain.tile;

class Factory
{
	Element create()
	{
		auto elements = createUnconnectedElements;
		connectElements(elements);
		return elements[0];
	}

	private Element[] createUnconnectedElements()
	{
		Element[] elements = iota(1, 16).map!(n => cast(Element)new Tile(n)).array;
		elements ~= new Void;
		return elements;
	}

	private void connectElements(Element[] elements)
	{
		elements.each!(element => element.connectToNeighbours(elements));
	}
}