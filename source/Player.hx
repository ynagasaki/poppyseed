
package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;

class Player extends FlxSprite {
	public static inline var GRAVITY : Float = 400;
	public static inline var MAX_VELOCITY_Y : Float = 700;
	public static inline var ANIM_IDLE : String = "idle";
	public static inline var ANIM_FLAP_ONCE : String = "flap_once";
	public static inline var ANIM_FLAP : String = "flap";

	public var speed : Float = 80; // pixels per sec
	//public var hitarea : FlxSprite;

	private var gameplayActive : Bool = true;
	private var currentAnimFlapName : String = ANIM_FLAP_ONCE;
	private var currentAnimIdleName : String = ANIM_IDLE;
	private var physbody : Body;

	public function new() : Void {
		super(0, 0);

		// load sprite
		loadGraphic("assets/images/player-creature.png", true);

		// set up motion constants and initial settings
		acceleration.y = GRAVITY;
		maxVelocity.y = MAX_VELOCITY_Y;
		velocity.x = velocity.y = 0;
		setPosition(0, FlxG.height * 0.5 - this.height * 0.5);

		// setup animation cycles
		animation.add(ANIM_IDLE,[0],0,false);
		animation.add(ANIM_FLAP,[0,1],8,true);
		animation.add(ANIM_FLAP_ONCE,[0,1],24,false);

		// setup physics
		physbody = new Body(BodyType.KINEMATIC);
		physbody.space = flixel.addons.nape.FlxNapeState.space;
		physbody.shapes.add(new Circle(width / 2));
		physbody.position.setxy(x + width / 2, y + height / 2);

		// hitarea -- TODO: FIX THE HIT AREA
		//hitarea = new FlxSprite(this.x, this.y);
		//hitarea.loadGraphic("assets/images/player.hitarea.png", false);
		//syncHitArea();
	}

	//public function syncHitArea() : Void {
	//	hitarea.x = this.x;
	//	hitarea.y = this.y;
	//}

	public override function update() : Void {
		super.update();
		physbody.position.setxy(x + width / 2, y + height / 2);
		//syncHitArea();
	}

	public function suspendActiveGameplay(suspend : Bool) : Void {
		gameplayActive = !suspend;
		velocity.y = 0;
		acceleration.y = (suspend) ? 0 : GRAVITY;
	}

	public function flap(flap : Bool) : Void {
		if(flap) {
			velocity.y = -200;
			animation.play(currentAnimFlapName);
		} else {
			animation.play(currentAnimIdleName);
		}
	}

	public function isGameplayActive() : Bool { 
		return gameplayActive;
	}

	public override function kill() : Void {
		//hitarea.kill();
		super.kill();
	}
}