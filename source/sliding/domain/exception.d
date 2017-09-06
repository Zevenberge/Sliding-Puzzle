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

interface ExceptionalBehaviourHandler
{
	void onIllegalMove();
}

class NoThrowBehaviourHandler : ExceptionalBehaviourHandler
{
	void onIllegalMove()
	{
		// Do nothing.
	}
}

class ThrowingBehaviourHandler : ExceptionalBehaviourHandler
{
	void onIllegalMove()
	{
		throw new IllegalMoveException;
	}
}