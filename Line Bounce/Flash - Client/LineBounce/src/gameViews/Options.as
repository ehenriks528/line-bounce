package gameViews
{
	import flash.media.SoundMixer;
	
	import controllers.GameViewController;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	//notifications? sync purchases? reset progress?
	
	public class Options extends Sprite implements GameView
	{
		private var bg:Image;
		private var title:TextField;
		private var homeBtn:Button;
		
		private var musicON:Button;
		private var musicOFF:Button;
		private var soundFXON:Button;
		private var soundFXOFF:Button;
		
		private var logout:Button;
		
		
		
		public function Options()
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
			bg = new Image(Assets.getTexture("Background"));
			this.addChild(bg);
			title = new TextField(480, 100, "Options", "Segoe Print", 48);
			this.addChild(title);
			
			musicON = new Button(Assets.getTexture("musicON"));
			musicON.x = 50;
			musicON.y = 150;
		
			musicOFF = new Button(Assets.getTexture("musicOFF"));
			musicOFF.x = 50;
			musicOFF.y = 150;
			
			soundFXON = new Button(Assets.getTexture("soundON"));
			soundFXON.x = 380;
			soundFXON.y = 150;
			
			soundFXOFF = new Button(Assets.getTexture("soundOFF"));
			soundFXOFF.x = 380;
			soundFXOFF.y = 150;
			
			this.addChild(musicON);
			this.addChild(soundFXON);
			
			logout = new Button(Assets.getTexture("menuButton"));
			logout.x = (this.stage.width - logout.width) / 2;
			logout.y = 250;
			logout.text = "FB Logout";
			this.addChild(logout);
			
			homeBtn = new Button(Assets.getTexture("confirmButton"));
			homeBtn.text = "Home";
			homeBtn.x = 25;
			homeBtn.y = this.stage.height - 80;	
			this.addChild(homeBtn);
			
			this.addEventListener(Event.TRIGGERED, onButtonPress);
		}
		
		private function onButtonPress(event:Event):void
		{
			var button:Button = event.target as Button;
			if (button == musicON) {
				//turns background music off
				this.removeChild(musicON);
				this.addChild(musicOFF);
				Sounds.musicMuted = true;
				SoundMixer.stopAll();
			}
			else if (button == musicOFF) {
				//turns background music back on
				this.removeChild(musicOFF);
				this.addChild(musicON);
				Sounds.musicMuted = false;
				//add stuff to turn music on
				Sounds.bgMusic.play(0,999);
			}
			else if (button == soundFXON) {
				//turns off in game sound effects
				this.removeChild(soundFXON);
				this.addChild(soundFXOFF);
				Sounds.soundFXMuted = true;
			}
			else if (button == soundFXOFF) {
				//turns in game sound effects back on
				this.removeChild(soundFXOFF);
				this.addChild(soundFXON);
				Sounds.soundFXMuted = false;
			}
			else if (button == homeBtn) {
				GameViewController.exitGameView(GameViewController.getGameView("Options"));
				GameViewController.enterGameView(GameViewController.getGameView("MainMenu"));
			}
			
		}
		
		public function initialize():void
		{
			this.visible = true;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		public function pause():void
		{
			
		}
		
		public function unpause():void
		{
			
		}
		
		public function update(delta:int):void 
		{
			
		}
	}
}