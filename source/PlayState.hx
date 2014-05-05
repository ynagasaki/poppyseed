 package;

import sys.io.File;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	var background : FlxSprite;
	var player : Player;
	var scheduler : Scheduler;
	var progressBar : ProgressBar;
	var consumedItems : ConsumedFoodHud;
	var level : Level;
	var score : Int = 0;
	var scoreText : FlxText;

	override public function create():Void {
		super.create();

		FlxG.log.redirectTraces = false;

		scheduler = new Scheduler();

		background = new FlxSprite(0, 0);
		background.loadGraphic("assets/images/bg.png", false, false, FlxG.width, FlxG.height);
		add(background);

		player = new Player();
		player.feedFinishListeners.add(feedFinishCallback);
		add(player);

		consumedItems = new ConsumedFoodHud(0, 0);
		add(consumedItems);

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

		var contents :  String = null;

		try {
			contents = File.getContent("assets/data/level_0.json");
		} catch(ex : Dynamic) {
			trace("** error: File probably not found: " + ex);
		}

		try {
			var jsonobj = haxe.Json.parse(contents);
			level = Level.fromJson(jsonobj);
			add(level);
		} catch(ex : Dynamic) {
			trace("** error: Parsing level json string failed: " + ex);
		}

		scoreText = new FlxText(0, 0, FlxG.width, Std.string(score));
		scoreText.alignment = "right";
		scoreText.size = 52;
		scoreText.setBorderStyle(FlxText.BORDER_OUTLINE, 0xCCCCCC, 2, 0);
		add(scoreText);

		progressBar = new ProgressBar();
		add(progressBar);
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		scheduler.process();

		if(player.alive && player.isGameplayActive()) {
			if(FlxG.keys.justPressed.UP) {
				player.flap(true);
			} else if(FlxG.keys.justReleased.UP) {
				player.flap(false);
			}

			level.moveThroughLevel(player.speed);

			/*if(!player.isFeeding()) {
				FlxG.overlap(player, level, collisionCallback);
			}*/
			for(member in level.members) {
				if(member.x > FlxG.width || member.x < -member.width) continue;
				if(FlxCollision.pixelPerfectCheck(player, member, 255)) {
					collisionCallback(player, member);
				}
			}

			progressBar.setProgress(level.traveled / level.distance);
		}
	}

	private function feedFinishCallback(item : FoodItem, finished : Bool) : Void {
		item.visible = true;
		level.remove(item, true);
		consumedItems.addFoodItem(item);
		score += 1;

		if(consumedItems.full()) {
			var commonFoodType : String = consumedItems.getCommonFoodType();
			if(commonFoodType == "") {
				//score += 3;
			} else {
				trace("old classic bakers: " + commonFoodType);
			}
			scoreText.text = Std.string(score);
			consumedItems.clearHud();
		}
	}

	private function collisionCallback(player : Dynamic, item : Dynamic) : Void {
		if(Type.getClass(item) == FoodItem) {
			if(this.player.isFeeding()) return;
			var food : FoodItem = cast(item, FoodItem);
			food.visible = false;
			this.player.startFeeding(food);
		} else if(Type.getClass(item) == FlxSprite) {
			player.die();
		}
	}
}