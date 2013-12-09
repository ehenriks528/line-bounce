package gameViews
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class LoginScreen extends Sprite implements GameView
	{
		private var userInput:TextField;
		private var passwordInput:TextField;
		
		public function LoginScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage():void
		{
			drawScreen();	
		}
		
		private function drawScreen():void
		{
			
		}
		
		public function update(delta:int):void 
		{
			
		}
		
		public function disposeTemporarily():void
		{
			
		}
		
		public function pause():void
		{
			
		}
		
		public function unpause():void
		{
			
		}
		
		public function initialize():void
		{
			
		}
	}
}