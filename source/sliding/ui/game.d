module sliding.ui.game;

import std.experimental.logger;
import dsfml.graphics;
import sliding.domain.factory;
import sliding.domain.randomizer;
import sliding.ui.board;
import sliding.ui.config;

void run()
{
	auto config = Config();
	trace("Creating window.");
	auto window = new RenderWindow(VideoMode(config.screenSize.x, config.screenSize.y), "Sliding");
	window.setFramerateLimit(60);
	
	trace("Creating board");
	auto board = initialiseBoard;
	trace("Starting application loop");
	try
	{
	windowLoop: while(window.isOpen)
		{
			Event event;
			while(window.pollEvent(event))
			{
				if(event.type == Event.EventType.Closed)
				{
					info("Exiting application");
					window.close;
					break windowLoop;
				}
				else
				{
					board.handle(event);
				}
			}
			board.draw(window);
			window.display;
		}
	}
	catch(Exception e)
	{
		error("Application exception");
		writeThrowable(e);
		throw e;
	}
	catch(Error e)
	{
		critical("Application error");
		writeThrowable(e);
		throw e;
	}
}

private Board initialiseBoard()
{
	auto factory = new Factory;
	auto firstElement = factory.create;
	trace("Created the elements");
	auto void_ = firstElement.void_;
	trace("Retreived the void");
	auto randomizer = new Randomizer;
	randomizer.shuffle(void_);
	trace("Shuffled the puzzle");
	return new Board(void_);
}

private void writeThrowable(Throwable t)
{
	while(t !is null)
	{
		error(t.msg, "\n", t.file, " at ", t.line	);
		error("Stacktrace: \n", t.info);
		t = t.next;
	}
}

