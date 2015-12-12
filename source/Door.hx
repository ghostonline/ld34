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
	var dir:OpenDirection;

	public function new(dir:OpenDirection)
	{
		super();
		if (dir == OpenDirection.Up)
		{
			loadGraphic("assets/images/door_up.png");
		}
		else
		{
			loadGraphic("assets/images/door_left.png");
		}
		immovable = true;
		isOpen = false;
		openTicks = 0;
		this.dir = dir;
	}

	public function open()
	{
		if (isOpen) { return; }

		isOpen = true;
	}

	override public function update():Void
	{
		if (isOpen && openTicks < MAX_OPEN_TICKS)
		{
			++openTicks;
			if (dir == OpenDirection.Up)
			{
				region.tileHeight = 16 - Math.floor(FlxMath.lerp(0, 14, openTicks / MAX_OPEN_TICKS));
				region.startY = 16 - region.tileHeight;
			}
			else
			{
				region.tileWidth = 16 - Math.floor(FlxMath.lerp(0, 14, openTicks / MAX_OPEN_TICKS));
				region.startX = 16 - region.tileWidth;
			}
			updateFrameData();

			if (openTicks == MAX_OPEN_TICKS)
			{
				allowCollisions = FlxObject.NONE;
			}
		}
		super.update();
	}
}
