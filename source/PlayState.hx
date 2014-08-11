package ;

import sys.io.File;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxCollision;
import flixel.addons.nape.FlxNapeState;

import nape.geom.Vec2;

class PlayState extends FlxNapeState
{
	var background : FlxSprite;
	var player : Player;
	var scheduler : Scheduler;
	var progressBar : ProgressBar;
	var level : Level;

	var stuff : FlxSprite;

	override public function create():Void {
		super.create();

		FlxG.log.redirectTraces = false;

		scheduler = new Scheduler();

		background = new FlxSprite(0, 0);
		background.loadGraphic("assets/images/bg-light.png", false, FlxG.width, FlxG.height);
		add(background);

		// initialize physics
		FlxNapeState.space.gravity = new Vec2(0, Player.GRAVITY);

		// initialize debug
		#if !FLX_NO_DEBUG
		FlxG.debugger.visible = true;
		set_napeDebugEnabled(true);
		FlxNapeState.debug.thickness = 1.0;
		#end

		// initialize player
		player = new Player();
		add(player);

		// setup starting sequence
		var startingSequence = new PlayerStateChangeEvent(player, 
			{
				x : -player.width,
				y : FlxG.height * 0.5 - player.height * 0.5,
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

		// load level
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

		/*
		progressBar = new ProgressBar();
		add(progressBar);
		*/

		// butt stuff
		stuff = new FlxSprite(1500, 0);
		stuff.loadGraphic("assets/images/baddie-1.png", true, true);
		stuff.animation.add("flappio",[0,1],4,true);
		level.add(stuff);
		stuff.acceleration.y = Player.GRAVITY*0.5;
		stuff.maxVelocity.y = 700;
		stuff.velocity.x = -50;
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	var stuffbla : Float = 0;

	override public function update():Void {
		super.update();

		scheduler.process();

			if(stuffbla >= 0.98) {
				stuff.velocity.y = -100;
				stuff.animation.play("flappio");
				stuffbla = 0;
			} else {
				stuffbla += FlxG.elapsed;
			}

		if(player.alive && player.isGameplayActive()) {
			if(FlxG.keys.justPressed.UP) {
				player.flap(true);
			} else if(FlxG.keys.justReleased.UP) {
				player.flap(false);
			}

			level.moveThroughLevel(player.speed);

			for(member in level.members) {
				if(member.x > FlxG.width || member.x < -member.width) {
					continue;
				}
				
				var memberClass : Class<Dynamic> = Type.getClass(member);
				if(memberClass == Player) {
					continue;
				} else if(memberClass == StarCoin) {
					if(FlxCollision.pixelPerfectCheck(player, member, 255)) {
						collisionCallbackCoin(cast(member, StarCoin));
					}
				} /*else {
					if(FlxCollision.pixelPerfectCheck(player.hitarea, member, 255)) {
						collisionCallbackObstacle(cast(member, FlxSprite));
					}
				}*/
			}

			//progressBar.setProgress(level.traveled / level.distance);
		}

	}

	private function collisionCallbackCoin(coin : StarCoin) : Void {
		coin.kill();
	}

	private function collisionCallbackObstacle(obstacle : FlxSprite) : Void {
		player.kill();
	}
}