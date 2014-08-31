
package ;

import flixel.FlxG;
import flixel.FlxSprite;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;

class Player extends FlxSprite {
	public static inline var GRAVITY : Float = 400;
	public static inline var MAX_VELOCITY_Y : Float = 700;
	public static inline var ANIM_IDLE : String = "idle";
	public static inline var ANIM_FLAP_ONCE : String = "flap_once";
	public static inline var ANIM_FLAP : String = "flap";

	public var speed : Float = 50;

	private var halfWidth : Float;
	private var gameplayActive : Bool = true;
	private var currentAnimFlapName : String = ANIM_FLAP_ONCE;
	private var currentAnimIdleName : String = ANIM_IDLE;
	private var physbody : Body;

	public function new() : Void {
		super(0, 0);

		// load sprite
		loadGraphic("assets/images/player-creature.png", true);

		// set up motion constants and initial settings
		//acceleration.y = GRAVITY;
		//maxVelocity.y = MAX_VELOCITY_Y;
		//velocity.x = velocity.y = 0;
		setPosition(0, FlxG.height * 0.5 - this.height * 0.5);
		halfWidth = width / 2;

		// setup animation cycles
		animation.add(ANIM_IDLE,[0],0,false);
		animation.add(ANIM_FLAP,[0,1],8,true);
		animation.add(ANIM_FLAP_ONCE,[0,1],24,false);

		// setup physics
		physbody = new Body(BodyType.DYNAMIC);
		physbody.space = flixel.addons.nape.FlxNapeState.space;
		physbody.mass = 5;
		physbody.shapes.add(new Circle(halfWidth - 4));
		physbody.position.setxy(x + halfWidth, y + halfWidth);
		physbody.velocity.x = speed;
	}

	public override function update() : Void {
		super.update();
		x = physbody.position.x - halfWidth;
		y = physbody.position.y - halfWidth;
		//physbody.position.setxy(x + halfWidth, y + halfWidth);
	}

	public function suspendActiveGameplay(suspend : Bool) : Void {
		//gameplayActive = !suspend;
		//velocity.y = 0;
		//acceleration.y = (suspend) ? 0 : GRAVITY;
	}

	public function flap(flap : Bool) : Void {
		if(flap) {
			//velocity.y = -200;
			physbody.velocity.y = -200;
			animation.play(currentAnimFlapName);
		} else {
			animation.play(currentAnimIdleName);
		}
	}

	public function isGameplayActive() : Bool { 
		return gameplayActive;
	}

	public override function kill() : Void {
		super.kill();
	}
}