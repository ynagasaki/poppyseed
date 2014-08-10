
package ;

import flixel.FlxG;
import flixel.FlxSprite;

class StarCoin extends FlxSprite {
	public function new(x : Float, y : Float) : Void {
		super(x, y);
		loadGraphic("assets/images/star.png", true, true);
		origy = y;
		i = x;
	}

	var i : Float = 0.0;
	var origy : Float = 0.0;

	public override function update() : Void {
		super.update();
		this.y = origy + 10.0 * Math.sin(i);
		i += FlxG.elapsed * 5.0;
	}
}