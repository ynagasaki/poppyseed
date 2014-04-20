
package ;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite {
	public static inline var GRAVITY : Float = 400;
	public static inline var ANIM_IDLE : String = "idle";
	public static inline var ANIM_FLAP_ONCE : String = "flap_once";
	public static inline var ANIM_FLAP : String = "flap";

	private var feedItem : FoodItem;
	private var gameplayActive : Bool = true;
	private var currentAnimFlapName : String = ANIM_FLAP_ONCE;
	private var currentAnimIdleName : String = ANIM_IDLE;

	public function new() : Void {
		super(0, 0);
		loadGraphic("assets/images/player.png", true, true);
		acceleration.y = GRAVITY;
		maxVelocity.y = 700;

		animation.add(ANIM_IDLE,[0],0,false);
		animation.add(ANIM_FLAP,[0,1],8,true);
		animation.add(ANIM_FLAP_ONCE,[0,1],24,false);

		animation.add("corn_" + ANIM_IDLE,[2],0,false);
		animation.add("corn_" + ANIM_FLAP_ONCE,[2,3],24,false);
		
		velocity.x = velocity.y = 0;
	}

	public override function update() : Void {
		if(isFeeding() && feedItem.suck(FlxG.elapsed)) {
			stopFeeding();
		}
		super.update();
	}

	public function suspendActiveGameplay(suspend : Bool) : Void {
		gameplayActive = !suspend;
		velocity.y = 0;
		acceleration.y = (suspend) ? 0 : GRAVITY;
	}

	public function isFeeding() : Bool {
		return feedItem != null;
	}

	public function startFeeding(item : FoodItem) : Void {
		currentAnimFlapName = item.getName() + "_" + ANIM_FLAP_ONCE;
		currentAnimIdleName = item.getName() + "_" + ANIM_IDLE;
		feedItem = item;
		animation.play(currentAnimIdleName);
	}

	public function stopFeeding() : Void {
		currentAnimFlapName = ANIM_FLAP_ONCE;
		currentAnimIdleName = ANIM_IDLE;
		feedItem = null;
		animation.play(currentAnimIdleName);
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
}