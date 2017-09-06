module sliding.ui.app;

import etc.linux.memoryerror;
import sliding.ui.game;

void main(string[] args)
{
	static if (is(typeof(registerMemoryErrorHandler)))
		registerMemoryErrorHandler(); 
	run;
}
