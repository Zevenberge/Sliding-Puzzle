module sliding.ui.state;

import std.experimental.logger;
import dsfml.graphics;
import sliding.domain.factory;
import sliding.domain.randomizer;
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
		auto board = initialiseBoard("res/example.png");
		_state = new Initializing(board);
		become!Playing;
	}

	private this(Board board)
	{
		super(board);
	}

	override bool handle(Event event)
	{
		return false;
	}
}

private Board initialiseBoard(string filename)
{
	auto factory = new Factory;
	auto firstElement = factory.create;
	trace("Created the elements");
	auto void_ = firstElement.void_;
	trace("Retreived the void");
	auto randomizer = new Randomizer;
	randomizer.shuffle(void_);
	trace("Shuffled the puzzle");
	return new Board(void_, filename);
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
	}

	override bool handle(Event event)
	{
		return _board.handle(event);
	}
}

