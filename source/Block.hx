
package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;

class Block extends FlxSprite {
	private var physbody : Body;

	public function new(x : Int, y : Int, width : Int, height : Int) {
		super(x, y);

		makeGraphic(width, height, FlxColor.AZURE);

		// setup physics
		physbody = new Body(BodyType.KINEMATIC);
		physbody.shapes.add(new Polygon(Polygon.box(width, height)));
		physbody.space = flixel.addons.nape.FlxNapeState.space;
		physbody.position.setxy(x + width/2, y + height/2);
	}

	public override function update() : Void {
		super.update();
		//physbody.position.setxy(x + width/2, y + height/2);
	}
}