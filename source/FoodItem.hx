
package ;

import flixel.FlxSprite;

class FoodItem extends FlxSprite {
	public function new(x : Float, y : Float, hitpoints : Float) : Void {
		super(x, y);
		loadGraphic("assets/images/kernel.png");
		health = hitpoints;
	}

	public function getName() : String {
		return "corn";
	}

	public function suck(amt : Float) : Bool {
		return (health = health - amt) <= 0.0;
	}
}