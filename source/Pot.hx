package;
import flixel.FlxSprite;

class Pot extends FlxSprite
{

	public function new()
	{
		super();
		loadGraphic("assets/images/pot.png");
		maxVelocity.y = 200;
		acceleration.y = maxVelocity.y;
	}

}
