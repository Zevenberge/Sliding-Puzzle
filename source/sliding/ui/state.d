module sliding.ui.state;

import std.experimental.logger;
import dsfml.graphics;
import sliding.domain.factory;
import sliding.ui.anime;
import sliding.ui.board;

State state()
{
	return _state;
}

private State _state;

class State
{
	private this(Board board)
	{
		_board = board;
	}
	protected Board _board;

	abstract bool handle(Event event);

	abstract void yield();

	void draw(RenderTarget target)
	{
		_board.draw(target);
	}
}

void become(TStateChange:StateChange)()
{
	info("Becoming ", TStateChange.stringof);
	TStateChange.changeState();
}

interface StateChange
{
}

class Initializing : State, StateChange
{
	private static void changeState()
	{
		trace("Creating board");
		auto board = initialiseBoard();
		_state = new Initializing(board);
	}

	private this(Board board)
	{
		super(board);
	}

	override bool handle(Event event)
	{
		return false;
	}

	override void yield()
	{
		become!Playing;
	}
}

private Board initialiseBoard()
{
	auto factory = new Factory;
	auto firstElement = factory.create;
	trace("Created the elements");
	auto void_ = firstElement.void_;
	trace("Retreived the void");
	return new Board(void_);
}

class Playing : State, StateChange
{
	private static void changeState()
	{
		_state = new Playing(_state._board);
	}

	private this(Board board)
	{
		super(board);
		board.setUpPuzzle;
	}

	override bool handle(Event event)
	{
		return _board.handle(event);
	}

	override void yield()
	{
		if(_board.isPuzzleSolved)
		{
			become!Solved;
		}
	}
}

class Solved : State, StateChange
{
	private static void changeState()
	{
		_state = new Solved(_state._board);
	}

	private this(Board board)
	{
		super(board);
		initiateSolutionAnimation;
	}

	private void initiateSolutionAnimation()
	{
		_animation = _board.startShowingSolution;
	}

	private Animation _animation;

	override bool handle(Event event)
	{
		return false;
	}

	override void yield() 
	{
		if(_animation.done)
		{
			if(_board.areAllPuzzlesSolved)
			{
				become!AllSolved;
			}
			else
			{
				become!Playing;
			}
		}
	}
}

class AllSolved : State, StateChange
{
	private static void changeState()
	{
		_state = new AllSolved(_state._board);
	}

	private this(Board board)
	{
		super(board);
	}

	override bool handle(Event event)
	{
		return false;
	}

	override void yield() 
	{
		// Do nothing.
	}
}