package;

import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class Level extends FlxTypedGroup<FlxObject>
{
	static inline var ID_PLAYER = 2;
	static inline var ID_POT = 3;
	static inline var ID_SUN = 4;

	var tiles:FlxTilemap;

	public function new(name:String)
	{
		super();

		var data = new TiledMap('assets/data/$name.tmx');

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
					case ID_SUN:
						// Blaat
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
		tiles.loadMap(tileData, "assets/images/tiles.png", data.tileWidth, data.tileHeight, FlxTilemap.AUTO);
		add(tiles);
	}

	override public function destroy():Void
	{
		super.destroy();
		tiles = null;
	}

}
