
package ;

import flixel.FlxSprite;

class Player extends FlxSprite {
	public static inline var GRAVITY : Float = 400;
	public static inline var ANIM_IDLE : String = "idle";
	public static inline var ANIM_FLAP_ONCE : String = "flap_once";
	public static inline var ANIM_FLAP : String = "flap";

	private var gameplayActive : Bool = true;

	public function new() : Void {
		super(0, 0);
		loadGraphic("assets/images/player.png", true, true);
		acceleration.y = GRAVITY;
		maxVelocity.y = 700;
		animation.add(ANIM_IDLE,[0],0,false);
		animation.add(ANIM_FLAP,[0,1],8,true);
		animation.add(ANIM_FLAP_ONCE,[0,1],24,false);
		scale.x = 1.6;
		scale.y = 1.6;
		velocity.x = velocity.y = 0;
	}

	public function suspendActiveGameplay(suspend : Bool) : Void {
		gameplayActive = !suspend;
		velocity.y = 0;
		acceleration.y = (suspend) ? 0 : GRAVITY;
	}

	public function flap(flap : Bool) : Void {
		if(flap) {
			velocity.y = -200;
			animation.play(ANIM_FLAP_ONCE);
		} else {
			animation.play(ANIM_IDLE);
		}
	}

	public function isGameplayActive() : Bool { 
		return gameplayActive;
	}
}