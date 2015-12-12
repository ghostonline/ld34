package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;

class Pot extends FlxSprite
{
	static inline var FULL_GROW_TIME = 120;

	public var plant(default, null):FlxSprite;
	public var pickedUp(get, set):Bool;
	var _pickedUp:Bool;
	var growTicks:Int;
	public var isGrown(get, null):Bool;

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
	function get_isGrown() { return growTicks >= FULL_GROW_TIME; }

	public function new()
	{
		super();
		loadGraphic("assets/images/pot.png");
		pickedUp = false;
		setNormalPhysics();
		plant = new FlxSprite();
		plant.loadGraphic("assets/images/plant.png", false, 16);
		growTicks = -1;
		addGrowthTick();
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

	function updatePlant()
	{
		plant.x = x;
		plant.y = y - plant.height;
	}

	public function addGrowthTick()
	{
		if (growTicks == FULL_GROW_TIME) { return; }
		++growTicks;

		if (growTicks == FULL_GROW_TIME)
		{
			plant.region.startX = 16;
		}

		var oldSize = plant.region.tileHeight;
		var newSize = Math.floor(growTicks / FULL_GROW_TIME * 32);
		if (oldSize != newSize)
		{
			plant.visible = newSize > 0;
			plant.region.tileHeight = newSize;
			plant.updateFrameData();
			plant.updateHitbox();
		}
	}

	override public function update():Void
	{
		super.update();
		updatePlant();
	}
}
