module sliding.domain.direction;

enum Direction {left, top, right, bottom}

Direction opposite(const Direction direction)
{
	final switch(direction) with(Direction)
	{
		case left:
			return right;
		case top:
			return bottom;
		case right:
			return left;
		case bottom:
			return top;
	}
}