package
{
	import starling.events.KeyboardEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
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
			
			GameViewController.enterGameView(GameViewController.getGameView("Test01"));
			trace("GameView Entered");
		}	
		
	}
}