package;
import flixel.FlxSprite;

class Light extends FlxSprite
{

	public function new()
	{
		super();
		loadGraphic("assets/images/sun.png");
		centerOrigin();
		angularVelocity = 30;
	}

}
