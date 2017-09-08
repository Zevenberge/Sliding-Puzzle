module sliding.ui.game;

import std.experimental.logger;
import dsfml.graphics;
import sliding.domain.exception;
import sliding.ui.config;
import sliding.ui.state;

void run()
{
	auto config = Config();
	trace("Creating window.");
	auto window = new RenderWindow(VideoMode(config.screenSize.x, config.screenSize.y), "Sliding");
	window.setFramerateLimit(60);
	become!Initializing;
	info("Starting application loop");
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
					try
					{
						state.handle(event);
					}
					catch(IllegalMoveException)
					{
						warning("Please don't try anything naughty");
					}
				}
			}
			state.draw(window);
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

private void writeThrowable(Throwable t)
{
	while(t !is null)
	{
		error(t.msg, "\n", t.file, " at ", t.line	);
		error("Stacktrace: \n", t.info);
		t = t.next;
	}
}

