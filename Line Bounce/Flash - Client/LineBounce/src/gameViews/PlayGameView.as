package gameViews
{
	import controllers.PlayController;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class PlayGameView extends Sprite implements GameView
	{
		private var playController:PlayController;
		
		public function PlayGameView()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToFrame);
		}
		
		private function addedToFrame(event:Event):void
		{
			playController = new PlayController();
			this.addChild(playController);
		}
		
		public function initialize():void
		{
			playController.visible = true;
		}
		
		public function disposeTemporarily():void
		{
			playController.visible = false;
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