package;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxVector;
import haxe.io.UInt8Array;

class Light extends FlxSpriteGroup
{
	var sun:FlxSprite;
	var range:FlxSprite;
	var radiusSq:Float;

	public function new()
	{
		super();
		sun = new FlxSprite();
		sun.loadGraphic("assets/images/sun.png");
		sun.x = sun.width / -2;
		sun.y = sun.height / -2;
		sun.angularVelocity = 30;
		sun.allowCollisions = FlxObject.NONE;
		add(sun);

		range = new FlxSprite();
		range.loadGraphic("assets/images/sunradius.png");
		range.x = range.width / -2;
		range.y = range.height / -2;
		add(range);
		radiusSq = (range.width / 2) * (range.width / 2);
	}

	public function isShiningOnPot(pot:Pot)
	{
		var lightPoint = FlxVector.get();
		var potPoint = FlxVector.get();
		sun.getGraphicMidpoint(lightPoint);
		pot.getGraphicMidpoint(potPoint);
		lightPoint.subtractPoint(potPoint);
		return lightPoint.lengthSquared < radiusSq;
	}

}
