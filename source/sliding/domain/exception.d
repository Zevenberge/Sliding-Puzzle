module sliding.domain.exception;

abstract class SlidingException : Exception
{
	this(string msg)
	{
		super(msg);
	}
}

class IllegalMoveException : SlidingException
{
	this()
	{
		super("Illegal move :(");
	}
}