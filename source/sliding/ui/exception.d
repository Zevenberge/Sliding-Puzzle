module sliding.ui.exception;

class UiException : Exception
{
	this(string msg)
	{
		super(msg);
	}
}

class LoadFromFileFailedException : UiException
{
	this(string filename)
	{
		super("Loading from file " ~ filename ~ " failed");
		this.filename = filename;
	}

	const string filename;
}