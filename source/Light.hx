package;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxVector;

class Light extends FlxSprite
{
	static inline var SUN_SHINE_RADIUS = 60;

	public function new()
	{
		super();
		loadGraphic("assets/images/sun.png");
		centerOrigin();
		angularVelocity = 30;
		allowCollisions = FlxObject.NONE;
	}

	public function isShiningOnPot(pot:Pot)
	{
		var lightPoint = FlxVector.get();
		var potPoint = FlxVector.get();
		getGraphicMidpoint(lightPoint);
		pot.getGraphicMidpoint(potPoint);
		lightPoint.subtractPoint(potPoint);
		return lightPoint.lengthSquared < SUN_SHINE_RADIUS * SUN_SHINE_RADIUS;
	}

}
