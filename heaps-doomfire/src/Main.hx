
import h2d.Text;
import h2d.Object;
import h2d.Bitmap;

import hxd.Res;
import hxd.System;
import hxd.Key;

class Main extends hxd.App {

		private static var PALETTE:Array<Int> = [
                0x070707,
                0x1F0707,
                0x2F0F07,
                0x470F07,
                0x571707,
                0x671F07,
                0x771F07,
                0x8F2707,
                0x9F2F07,
                0xAF3F07,
                0xBF4707,
                0xC74707,
                0xDF4F07,
                0xDF5707,
                0xDF5707,
                0xD75F07,
                0xD75F07,
                0xD7670F,
                0xCF6F0F,
                0xCF770F,
                0xCF7F0F,
                0xCF8717,
                0xC78717,
                0xC78F17,
                0xC7971F,
                0xBF9F1F,
                0xBF9F1F,
                0xBFA727,
                0xBFA727,
                0xBFAF2F,
                0xB7AF2F,
                0xB7B72F,
                0xB7B737,
                0xCFCF6F,
                0xDFDF9F,
                0xEFEFC7,
                0xFFFFFF
            ];


		private var _fireHeight:Int = 256;
		private var _fireWidth:Int = 256;
		private var _fireData:Array<Int>;

		private var _texture : h3d.mat.Texture;
  		private var _graphics : h2d.Graphics;


		private function initGfx():Void
		{
			s2d.removeChildren();
			 _fireData = new Array<Int>();
			for(i in 0 ... _fireWidth * _fireHeight)
			{
				_fireData.push(0);
			}

			for(i in 0 ... _fireWidth) 
			{
                _fireData[(_fireHeight-1)*_fireWidth + i] = 36;
            }

			_texture = new h3d.mat.Texture(s2d.width, s2d.height,[Target]);
    		var bitmap = new h2d.Bitmap(h2d.Tile.fromTexture(_texture), s2d);
			bitmap.x = 0;
			bitmap.y = 0;

 			_graphics = new h2d.Graphics();
    		_graphics.filter = new h2d.filter.Blur(2,2,10);
			_graphics.beginFill(PALETTE[0],0.8);
			_graphics.drawRect(0, 0, s2d.width, s2d.height);
			_graphics.drawTo(_texture);
			_graphics.endFill();
		}

		// Called on creation
        override function init() {
			initGfx();
        }

		override function onResize()
		{
			initGfx();
		}

		private function redraw():Void
		{
			_graphics.clear();
			for(y in 0 ... _fireHeight)
			{
				for(x in 0 ... _fireWidth)
				{
					var color:Int = PALETTE[_fireData[x + y * _fireHeight]];
					_graphics.beginFill(color, 0.8);
					var cx = (s2d.width / _fireWidth) * (x + 0.5);
					var cy = (s2d.height / _fireHeight) * (y + 0.5);
					var rx = (s2d.width / _fireWidth) * 0.5;
					var ry = (s2d.height / _fireHeight) * 0.5;
					_graphics.drawEllipse(cx,cy,rx,ry);
				}
			}
			_graphics.drawTo(_texture);

		}

		private function spreadFire(src:Int):Void
		{
			var pixel = _fireData[src];
			if(pixel == 0) {
                _fireData[src - _fireWidth] = 0;
            } 
			else 
			{
                    var randIdx = Math.round(Math.random() * 3.0) & 3;
                    var dst = src - randIdx + 1;
                    _fireData[dst - _fireWidth ] = pixel - (randIdx & 1);
            }
		}
		


		// Called each frame
        override function update(dt:Float) {
			for(v in 0 ... _fireData.length)
			{
				spreadFire(v);
			}
			redraw();
			
        }



        static function main() {
            new Main();
        }
    }