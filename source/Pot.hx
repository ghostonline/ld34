package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxObject;

class Pot extends FlxSprite
{

	public var pickedUp(get, set):Bool;
	var _pickedUp:Bool;

	function get_pickedUp() { return _pickedUp; }
	function set_pickedUp(val:Bool)
	{
		_pickedUp = val;
		if (val)
		{
			setPickedUpPhysics();
		}
		else
		{
			setNormalPhysics();
		}
		return val;
	}

	public function new()
	{
		super();
		loadGraphic("assets/images/pot.png");
		pickedUp = false;
		setNormalPhysics();
	}

	function setPickedUpPhysics()
	{
		maxVelocity.set(0, 0);
		acceleration.set(0, 0);
		drag.set(0, 0);
	}

	function setNormalPhysics()
	{
		maxVelocity.set(0, 200);
		acceleration.y = maxVelocity.y;
		drag.set(200, 200);
	}

	public function playerCollide(obj:Player)
	{
		if (pickedUp) { return; }

		allowCollisions = FlxObject.UP;
		FlxG.collide(obj, this, notifyPlayer);
	}

	function notifyPlayer(player:Player, pot:Pot)
	{
		player.setCollidingPot(pot);
	}

	public function levelCollide(obj:FlxBasic)
	{
		if (pickedUp) { return; }

		allowCollisions = FlxObject.ANY;
		FlxG.collide(obj, this);
	}
}
