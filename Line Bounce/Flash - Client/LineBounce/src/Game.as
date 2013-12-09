package
{
	import starling.events.KeyboardEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import controllers.GameViewController;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			// TODO Auto Generated method stub
			trace("Starling Framework Initialized");
			
			this.addChild(GameViewController.initialize());
			
			this.addEventListener(KeyboardEvent.KEY_DOWN, testKeyDown);
			
			GameViewController.enterGameView(GameViewController.getGameView("Test01"));
			trace("GameView Entered");
		}
		
		private function testKeyDown(event:KeyboardEvent):void
		{
			trace("Key pressed: "+String.fromCharCode(event.charCode));
			switch(String.fromCharCode(event.charCode)){
				case "1":
					trace("Game:testKeyDown; Case 1 begin");
					GameViewController.enterGameView(GameViewController.getGameView("Test01"));
					trace("Game:testKeyDown; Case 1 complete");
					break;
				case "2":
					trace("Game:testKeyDown; Case 2 begin");
					GameViewController.exitGameView(GameViewController.getGameView("Test01"));
					trace("Game:testKeyDown; Case 2 complete");
					break;
				case "3":
					trace("Game:testKeyDown; Case 3 begin");
					GameViewController.enterGameView(GameViewController.getGameView("Play"));
					trace("Game:testKeyDown; Case 3 complete");
					break;
				case "4":
					trace("Game:testKeyDown; Case 3 begin");
					GameViewController.exitGameView(GameViewController.getGameView("Play"));
					trace("Game:testKeyDown; Case 3 complete");
					break;
				
			}
		}		
		
	}
}