package
{
	

	import starling.display.Sprite;
	import starling.events.Event;
	
	import states.Leaderboards;
	import states.Shop;
	
	public class Game extends Sprite
	{
		private var shopMenu:Shop;
		private var leaderboardState:Leaderboards;
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);		
		}
	
		private function onAddedToStage(event:Event):void
		{
			trace("Starling framework init");
			//leaderboardState = new Leaderboards();
			//this.addChild(leaderboardState);
			
			shopMenu = new Shop();
			this.addChild(shopMenu);
		}
	}
}