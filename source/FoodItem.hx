
package ;

import flixel.FlxSprite;

class FoodItem extends FlxSprite {
	public function new(x : Float, y : Float) : Void {
		super(x, y);
		loadGraphic("assets/images/kernel.png");
	}
}