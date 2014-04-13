
package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class ProgressBar extends FlxSpriteGroup {

	private var icon : FlxSprite;
	private var capacity : Float;

	public function new() {
		super();

		var progressbar : FlxSprite = new FlxSprite(0, 0);
		progressbar.loadGraphic("assets/images/progress-bar.png");

		icon = new FlxSprite(0, 0);
		icon.loadGraphic("assets/images/chicken-icon.png");

		// position progress bar
		progressbar.y = icon.height * 0.5 - progressbar.height * 0.5;
		progressbar.x = 0;

		this.x = FlxG.width * 0.5 - progressbar.width * 0.5;
		this.y = FlxG.height - icon.height - 20;

		add(progressbar);
		add(icon);

		capacity = progressbar.width - icon.width;
	}

	public function setProgress(percent : Float) {
		if(percent >= 0 && percent <= 1)
			icon.x = this.x + capacity * percent;
	}
}