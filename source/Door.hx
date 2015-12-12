package;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxMath;

enum OpenDirection
{
	Up;
	Left;
}

class Door extends FlxSprite
{
	static inline var MAX_OPEN_TICKS = 30;

	var isOpen:Bool;
	var openTicks:Int;

	public function new()
	{
		super();
		loadGraphic("assets/images/door_up.png");
		immovable = true;
		isOpen = false;
		openTicks = 0;
	}

	public function open()
	{
		if (isOpen) { return; }

		allowCollisions = FlxObject.NONE;
		isOpen = true;
	}

	override public function update():Void
	{
		if (isOpen && openTicks < MAX_OPEN_TICKS)
		{
			++openTicks;
			region.tileHeight = 16 - Math.floor(FlxMath.lerp(0, 14, openTicks / MAX_OPEN_TICKS));
			region.startY = 16 - region.tileHeight;
			updateFrameData();
		}
		super.update();
	}
}
