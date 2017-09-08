module sliding.ui.anime;

import std.algorithm;
import std.array;
import std.conv;
import dsfml.graphics;

class Animation
{
	void animate()
	{
		nextFrame;
		if(done)
		{
			onDone;
		}
	}

	private void onDone()
	out
	{
		assert(!_animations.any!(x => x is this));
	}
	body
	{
		_animations = _animations.remove!(x => x is this).array;
	}

	abstract bool done() @property;
	
	protected abstract void nextFrame();
}

void animateAllAnimations()
{
	foreach(animation; _animations)
	{
		animation.animate;
	}
}

private Animation[] _animations;

private Animation addAndReturn(Animation animation)
{
	_animations ~= animation;
	return animation;
}

Animation appear(Sprite sprite, int amountOfFrames)
{
	return addAndReturn(new AppearSpriteAnimation(sprite, amountOfFrames));
}

private class AppearSpriteAnimation : Animation
{
	this(Sprite sprite, int amountOfFrames)
	{
		_sprite = sprite;
		_amountOfFrames = amountOfFrames;
	}

	private Sprite _sprite;
	private int _amountOfFrames;
	
	protected override void nextFrame()
	{
		auto color = _sprite.color;
		auto increment = (255 - color.a)/_amountOfFrames;
		_sprite.color = Color(color.r, color.g, color.b, (color.a + increment).to!ubyte);
		--_amountOfFrames;
	}

	protected override bool done() @property
	{
		return _amountOfFrames == 0;
	}
}

Animation glowRed(Sprite sprite, int amountOfFrames)
{
	return addAndReturn(new GlowingRedSpriteAnimation(sprite, amountOfFrames));
}

private class GlowingRedSpriteAnimation : Animation
{
	this(Sprite sprite, int amountOfFrames)
	{
		_sprite = sprite;
		_sprite.color = Color.Red;
		_amountOfFrames = amountOfFrames;
	}

	private Sprite _sprite;
	private int _amountOfFrames;
	
	protected override void nextFrame()
	{
		auto color = _sprite.color;
		auto increment_g = (255 - color.g)/_amountOfFrames;
		auto increment_b = ( 255 - color.b)/_amountOfFrames;
		_sprite.color = Color(color.r, 
			(color.g + increment_g).to!ubyte, 
			(color.b + increment_b).to!ubyte, color.a);
		--_amountOfFrames;
	}

	protected override bool done() @property
	{
		return _amountOfFrames == 0;
	}
}
