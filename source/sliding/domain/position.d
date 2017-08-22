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
		auto y = number / 4;
		this(x, y);
	}

	private this(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	const int x; // 0..3
	const int y; // 0..3

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