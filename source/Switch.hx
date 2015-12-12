package;
import flixel.FlxSprite;

class Switch extends FlxSprite
{

	var primed:Bool;
	var triggered:Bool;
	var doors:Array<Door>;

	public function new()
	{
		super();
		loadGraphic("assets/images/switch.png", false, 16);
		primed = false;
		triggered = false;
		doors = new Array<Door>();
		offset.y = height - 3;
		height = 3;
	}

	public function connectDoor(door:Door)
	{
		doors.push(door);
	}

	public function prime()
	{
		primed = !triggered;
	}

	public function trigger()
	{
		if (primed) { triggered = true; }
	}

	public function checkTrigger()
	{
		if (!primed || !triggered) { return; }

		frame = framesData.frames[1];
		for (door in doors) { door.open(); }
	}
}
