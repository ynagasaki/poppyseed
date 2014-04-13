
package ;

typedef PlayerStateOptions = { ?x : Float, ?y : Float, ?anim : String, ?suspend : Bool};

class PlayerStateChangeEvent extends Event {
	public var player : Player;
	public var targetState : PlayerStateOptions;

	public function new(player : Player, targetState : PlayerStateOptions, duration : Float = 0.0) {
		super(duration);
		this.player = player;
		this.targetState = targetState;
	}

	public override function process(elapsedTime : Float) : Bool {
		if(targetState.x != null) {
			player.x = targetState.x;
		}
		if(targetState.y != null) {
			player.y = targetState.y;
		}
		if(targetState.anim != null) {
			player.animation.play(targetState.anim);
		}
		if(targetState.suspend != null) {
			player.suspendActiveGameplay(targetState.suspend);
		}
		return true;
	}
}