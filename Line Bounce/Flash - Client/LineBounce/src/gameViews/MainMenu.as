package gameViews
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class MainMenu extends Sprite implements GameView
	{
		private var playGameBtn:Button;
		private var shopBtn:Button;
		private var optionsBtn:Button;
		private var leaderboardsBtn:Button;
		private var bg:Image;
		private var title:TextField;
		

		public function MainMenu()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			
			drawScreen();
		}
		
		private function drawScreen():void
		{
			playGameBtn = new Button(Assets.getTexture("menuButton"));
			shopBtn = new Button(Assets.getTexture("menuButton"));
			optionsBtn = new Button(Assets.getTexture("menuButton"));
			leaderboardsBtn = new Button(Assets.getTexture("menuButton"));
			
			bg = new Image(Assets.getTexture("MainMenuBG"));
			
			title = new TextField(480,100,"Line Bounce", "Segoe Print", 48, 0x000000, true);
			
			playGameBtn.text = "Play Game";
			shopBtn.text = "Shop";
			optionsBtn.text = "Options";
			leaderboardsBtn.text = "Leaderboards";
			
			this.addChild(bg);
			this.addChild(title);
			this.addChild(playGameBtn);
			this.addChild(shopBtn);
			this.addChild(optionsBtn);
			this.addChild(leaderboardsBtn);
			
			playGameBtn.x = (this.stage.width - playGameBtn.width) / 2;
			playGameBtn.y = 150;
			playGameBtn.fontSize = 36;
			
			shopBtn.x = playGameBtn.x
			shopBtn.y = playGameBtn.y + 150;
			shopBtn.fontSize = 36;
			
			leaderboardsBtn.x = playGameBtn.x
			leaderboardsBtn.y = shopBtn.y + 150;
			leaderboardsBtn.fontSize = 36;
			
			optionsBtn.x = playGameBtn.x
			optionsBtn.y = leaderboardsBtn.y + 150;;
			optionsBtn.fontSize = 36;
			
			this.addEventListener(Event.TRIGGERED, onMenuChange);
		}
		
		private function onMenuChange(event:Event):void
		{
			var button:Button = event.target as Button;
			if (button == playGameBtn){
				trace("play game");
			}
			else if (button == shopBtn) {
				GameViewController.exitGameView(GameViewController.getGameView("MainMenu"));
				GameViewController.enterGameView(GameViewController.getGameView("Shop"));
			}
			
			else if (button = leaderboardsBtn){
				GameViewController.exitGameView(GameViewController.getGameView("MainMenu"));
				GameViewController.enterGameView(GameViewController.getGameView("Leaderboards"));
			}
			else if (button = optionsBtn) {
				disposeTemporarily();
				//load options state
			}
		}
		
		public function initialize():void
		{
			this.visible = true;
		}
		
		public function update(delta:int):void 
		{
			
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			/*
			this.removeChild(bg);
			this.removeChild(playGameBtn);
			this.removeChild(shopBtn);
			this.removeChild(optionsBtn);
			this.removeChild(leaderboardsBtn);
			this.removeEventListener(Event.TRIGGERED, onMenuChange);
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			*/
		}
		
		public function pause():void
		{
			
		}
		
		public function unpause():void
		{
			
		}
	}
}