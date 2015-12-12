package;
import flixel.FlxObject;
import flixel.FlxSprite;

class Light extends FlxSprite
{

	public function new()
	{
		super();
		loadGraphic("assets/images/sun.png");
		centerOrigin();
		angularVelocity = 30;
		allowCollisions = FlxObject.NONE;
	}

}
