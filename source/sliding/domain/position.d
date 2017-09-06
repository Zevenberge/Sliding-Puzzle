module sliding.domain.position;

struct Position
{
	this(int number)
	in
	{
		import std.conv;
		assert(number > 0 && number <= 16, 
			"Number could not be converted to a position: " ~ number.to!string);
	}
	body
	{
		auto x = (number - 1) % 4;
		auto y = (number -1) / 4;
		this(x, y);
	}

	private this(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	int x = -1; // 0..3
	int y = -1; // 0..3

	@property
	{
		Position left()
		{
			return Position(x - 1, y);
		}
		Position top()
		{
			return Position(x, y - 1);
		}
		Position right()
		{
			return Position(x + 1, y);
		}
		Position bottom()
		{
			return Position(x, y + 1);
		}
	}
}

unittest
{
	assert(Position(1) == Position(0,0));
	assert(Position(2) == Position(1,0));
	assert(Position(5) == Position(0,1));
	assert(Position(16) == Position(3,3));
}