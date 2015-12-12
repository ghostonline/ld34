package;

import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.util.FlxPoint;

class Level extends FlxTypedGroup<FlxObject>
{
	static inline var ID_PLAYER = 2;
	static inline var ID_POT = 3;
	static inline var ID_SUN = 4;

	var tiles:FlxTilemap;
	var tileWidth:Int;
	var tileHeight:Int;

	var pots:FlxTypedGroup<Pot>;
	var lights:Array<Light>;

	public function new(name:String)
	{
		super();

		var data = new TiledMap('assets/data/$name.tmx');
		tileWidth = data.tileWidth;
		tileHeight = data.tileHeight;

		pots = new FlxTypedGroup<Pot>();
		lights = new Array<Light>();

		var tileData = data.layers[0].tileArray.copy();
		var idx = 0;
		for (row in 0...data.height)
		{
			for (col in 0...data.width)
			{
				var tileId = tileData[idx];
				var replaced = 0;
				switch(tileId)
				{
					case ID_PLAYER:
					case ID_POT:
						createPot(col, row);
					case ID_SUN:
						createLight(col, row);
					default:
						replaced = tileId;
				}
				tileData[idx] = replaced;
				++idx;
			}
		}

		tiles = new FlxTilemap();
		tiles.widthInTiles = data.width;
		tiles.heightInTiles = data.height;
		tiles.loadMap(tileData, "assets/images/tiles.png", tileWidth, tileHeight, FlxTilemap.AUTO);
		add(tiles);
	}

	function createPot(col:Int, row:Int)
	{
		var pot = new Pot();
		pot.x = col * tileWidth;
		pot.y = row * tileHeight;
		pots.add(pot);
		add(pot);
	}

	function createLight(col:Int, row:Int)
	{
		var light = new Light();
		light.x = col * tileWidth;
		light.y = row * tileHeight;
		lights.push(light);
		add(light);
	}

	override public function update():Void
	{
		super.update();
		FlxG.collide(tiles, pots);
	}

	override public function destroy():Void
	{
		super.destroy();
		tiles = null;
	}

}
