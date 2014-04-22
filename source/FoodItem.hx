
package ;

import flixel.FlxSprite;

class FoodItem extends FlxSprite {
	public var name : String;

	public function new(name : String, x : Float, y : Float, hitpoints : Float) : Void {
		super(x, y);
		this.name = name;
		loadGraphic("assets/images/" + this.name + ".png");
		health = hitpoints;

		if(this.name == "kernel") { // hack
			scale.x = .8;
			scale.y = .8;
		}
	}

	public function getName() : String {
		return this.name;
	}

	public function suck(amt : Float) : Bool {
		return (health = health - amt) <= 0.0;
	}
}