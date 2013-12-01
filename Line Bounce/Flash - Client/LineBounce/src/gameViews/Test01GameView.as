package gameViews
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	public class Test01GameView extends Sprite implements GameView
	{
		
		private var image:Image;
		
		public function Test01GameView()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			trace("Test01GameView:onAddedToStage; initializing resources.");
			image = new Image(Assets.getTexture("testImage"));
			this.addChild(image);
			image.x = 0;
			image.y= 256;
			trace("Test01GameView:onAddedToStage; initializing resources completed.");
		}
		
		private function testKeyDown(event:KeyboardEvent):void
		{
			// TODO Auto Generated method stub
			switch(String.fromCharCode(event.charCode)){
				case "3":
					image.height= image.height*4/5;
					image.width= image.width*4/5;
					break;
			}
		}
		
		public function initialize():void
		{
			this.addEventListener(KeyboardEvent.KEY_DOWN, testKeyDown);
			this.visible = true;
			trace("Test01GameView:initialize; Complete.");
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			this.removeEventListener(KeyboardEvent.KEY_DOWN, testKeyDown);
			trace("Test01GameView:disposeTemporarily; Complete.");
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