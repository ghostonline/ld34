package;

import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.util.FlxPoint;

typedef TilePos = { col:Int, row:Int };
typedef DoorDef = { pos:TilePos, dir:Door.OpenDirection };

class Level extends FlxTypedGroup<FlxObject>
{
	static inline var ID_PLAYER = 2;
	static inline var ID_POT = 3;
	static inline var ID_SUN = 4;
	static inline var ID_SWITCH = 5;
	static inline var ID_DOOR_UP = 6;
	static inline var ID_DOOR_LEFT = 7;

	var tiles:FlxTilemap;
	public var tileWidth(default, null):Int;
	public var tileHeight(default, null):Int;

	public var start(default, null):TilePos;
	public var pot(default, null):TilePos;
	public var light(default, null):TilePos;
	public var doors(default, null):Array<DoorDef>;
	public var switch_(default, null):TilePos;

	public function new(name:String)
	{
		super();

		var data = new TiledMap('assets/data/$name.tmx');
		tileWidth = data.tileWidth;
		tileHeight = data.tileHeight;

		doors = new Array<Level.DoorDef>();

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
						start = { col:col, row:row };
					case ID_POT:
						pot = { col:col, row:row };
					case ID_SUN:
						light = { col:col, row:row };
					case ID_SWITCH:
						switch_ = { col:col, row:row };
					case ID_DOOR_UP:
						doors.push( { pos: { col:col, row:row }, dir:Door.OpenDirection.Up } );
					case ID_DOOR_LEFT:
						doors.push( { pos: { col:col, row:row }, dir:Door.OpenDirection.Left } );
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

	public function placeAt(pos:TilePos, obj:FlxObject)
	{
		obj.x = pos.col * tileWidth;
		obj.y = pos.row * tileHeight;
	}

	override public function destroy():Void
	{
		super.destroy();
		tiles = null;
	}

}
