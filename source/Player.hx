package;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxVector;

class Player extends FlxSprite
{
	var actionDown:Bool;
	var draggingPot:Pot;
	var collidingPot:Pot;

	public function new()
	{
		super();
		loadGraphic("assets/images/player.png", false, 16, 16);

		maxVelocity.x = 80;
		maxVelocity.y = 300;
		drag.x = 1280;
		acceleration.y = maxVelocity.y;
		updateVisual();
	}

	function updateVisual()
	{
		var oldWidth = width;
		var oldHeight = height;
		if (draggingPot == null)
		{
			width = 12;
			height = 16;
			offset.set(2, 0);
			frame = framesData.frames[0];
		}
		else
		{
			width = 16;
			height = 12 + draggingPot.height;
			offset.set(0, 4 - draggingPot.height);
			frame = framesData.frames[1];
		}
		x += oldWidth - width;
		y += oldHeight - height;
	}

	public function setAction(action:Bool)
	{
		if (actionDown && action) { return; }
		actionDown = action;
		if (!action) { return; }

		if (draggingPot == null && collidingPot != null)
		{
			// Pickup pot
			draggingPot = collidingPot;
			draggingPot.pickedUp = true;
			updateVisual();
		}
		else if (draggingPot != null)
		{
			// Throw pot
			draggingPot.pickedUp = false;
			draggingPot.velocity.x = velocity.x + (flipX ? -100 : 100);
			draggingPot.velocity.y = -50;
			draggingPot = null;
			updateVisual();
		}
	}

	public function resetCollidingPot() { collidingPot = null; }
	public function setCollidingPot(pot:Pot)
	{
		collidingPot = pot;
	}

	public function setDirectionX(dir:Int)
	{
		acceleration.x = dir * drag.x;
		if (dir < 0) { flipX = true; }
		else if (dir > 0) { flipX = false; }
	}

	public function setJump(jumping:Bool)
	{
		if (jumping && isTouching(FlxObject.FLOOR))
		{
			velocity.y = draggingPot == null ? -175 : -150;
		}
	}

	override public function update():Void
	{
		super.update();
		if (draggingPot != null)
		{
			var target = FlxVector.get(x, y);
			target.subtract(draggingPot.x, draggingPot.y);
			var distance = target.length;
			target.normalize();
			var speed = Math.min(distance * 60, 1280);
			target.scale(speed);
			draggingPot.velocity.set(target.x, target.y);
			target.put();
		}
	}
}
