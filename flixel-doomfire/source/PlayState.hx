package;


import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;


class PlayState extends FlxState
{
		private static var PALETTE:Array<Int> = [
                0xFF070707,
                0xFF1F0707,
                0xFF2F0F07,
                0xFF470F07,
                0xFF571707,
                0xFF671F07,
                0xFF771F07,
                0xFF8F2707,
                0xFF9F2F07,
                0xFFAF3F07,
                0xFFBF4707,
                0xFFC74707,
                0xFFDF4F07,
                0xFFDF5707,
                0xFFDF5707,
                0xFFD75F07,
                0xFFD75F07,
                0xFFD7670F,
                0xFFCF6F0F,
                0xFFCF770F,
                0xFFCF7F0F,
                0xFFCF8717,
                0xFFC78717,
                0xFFC78F17,
                0xFFC7971F,
                0xFFBF9F1F,
                0xFFBF9F1F,
                0xFFBFA727,
                0xFFBFA727,
                0xFFBFAF2F,
                0xFFB7AF2F,
                0xFFB7B72F,
                0xFFB7B737,
                0xFFCFCF6F,
                0xFFDFDF9F,
                0xFFEFEFC7,
                0xFFFFFFFF
            ];

 	private var _canvas:FlxSprite;
	private var _fireData:Array<Int>;
	private var _fireWidth:Int = 320;
	private var _fireHeight:Int = 240;


	override public function create():Void
	{
		super.create();



		_canvas = new FlxSprite();
		_canvas.makeGraphic(_fireWidth, _fireHeight, PALETTE[0], true);

        add(_canvas);
		_canvas.scale.set(2,2);
		_canvas.screenCenter();


		 _fireData = new Array<Int>();
		for(i in 0 ... _fireWidth * _fireHeight)
		{
			_fireData.push(0);
		}

			for(i in 0 ... _fireWidth) 
			{
                _fireData[(_fireHeight-1)*_fireWidth + i] = 36;
            }
	}

	private function spreadFire(src:Int):Void
	{
		var pixel = _fireData[src];
		if(pixel == 0) 
		{
            _fireData[src - _fireWidth] = 0;
        } 
		else 
		{
            var randIdx = Math.round(Math.random() * 3.0) & 3;
            var dst = src - randIdx + 1;
            _fireData[dst - _fireWidth ] = pixel - (randIdx & 1);
        }
	}



	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		for(v in 0 ... _fireData.length)
		{
			spreadFire(v);
		}
		_canvas.pixels.lock();
		for(y in 0 ... _fireHeight)
		{
			for(x in 0 ... _fireWidth)
			{
				_canvas.pixels.setPixel32(x, y, PALETTE[_fireData[y*_fireWidth+x]]);
			}
		}
		_canvas.pixels.unlock();
	}
}
