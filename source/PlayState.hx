 package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxPoint;

class PlayState extends FlxState
{
	var background : FlxSprite;
	var player : Player;
	var scheduler : Scheduler;
	var progressBar : ProgressBar;
	var level : Level;

	var speed : Float = 110; // pixels per sec

	override public function create():Void {
		super.create();

		FlxG.log.redirectTraces = false;

		scheduler = new Scheduler();

		background = new FlxSprite(0, 0);
		background.loadGraphic("assets/images/bg.png", false, false, FlxG.width, FlxG.height);
		add(background);

		player = new Player();
		add(player);

		progressBar = new ProgressBar();
		add(progressBar);

		var startingSequence = new PlayerStateChangeEvent(player, 
			{
				x : -player.width*1.6,
				y : FlxG.height * 0.5 - player.height * 1.6 * 0.5,
				anim : Player.ANIM_FLAP,
				suspend : true
			}
		);

		startingSequence.chain(new SpriteMoveEvent(player, 
				new FlxPoint(320, 0), 
				3.0
			)
		).chain(new PlayerStateChangeEvent(player, 
				{
					suspend : false,
					anim : Player.ANIM_IDLE
				},
				2.0
			)
		);

		scheduler.addEvent(startingSequence);

		level = new Level();
		level.add(new FoodItem(FlxG.width + 100, 52));
		level.add(new FoodItem(FlxG.width + 300, 252));
		level.add(new FoodItem(FlxG.width + 500, 132));
		level.add(new FoodItem(FlxG.width + 700, 82));
		level.add(new FoodItem(FlxG.width + 800, 112));
		level.add(new FoodItem(FlxG.width + 1000, 182));
		add(level);
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		scheduler.process();

		if(player.isGameplayActive()) {
			if(FlxG.keys.justPressed.UP) {
				player.flap(true);
			} else if(FlxG.keys.justReleased.UP) {
				player.flap(false);
			}

			level.moveThroughLevel(speed);

			progressBar.setProgress(level.traveled / level.distance);
		}
	}
}