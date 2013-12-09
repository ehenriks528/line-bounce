package states
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Leaderboards extends Sprite
	{
		public var arrayUser:Array;
		
		public var user1:userObject;
		public var userImage1:Image;
		public var user2:userObject;
		public var userImage2:Image;
		
		private var bg:Image;
		private var title:TextField;
		
		public function Leaderboards()
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
			title = new TextField(400,100, "Leaderboards", "Verdana", 36);
			title.x = (stage.width - title.width) / 2;
			this.addChild(title);
			
			userImage1 = new Image(Assets.getTexture("Spring"));
			user1 = new userObject("ben", 400, userImage1);
			userImage2 = new Image(Assets.getTexture("JetPack"));
			user2 = new userObject("max", 200, userImage2);
			arrayUser = new Array();
			arrayUser.push(user1);
			arrayUser.push(user2);
			//server client shenangians to get list of users for leaderboards
			//positioning of user's info
			var x:int = 50;
			var y:int = 200;
			
			for (var i:int = 0; i < arrayUser.length; i++) {
				arrayUser[i].img.x = x;
				arrayUser[i].img.y = y;
				arrayUser[i].text.x = x ;
				arrayUser[i].text.y = y- arrayUser[i].img.height/3;// + arrayUser[i].text.height) / 2 + arrayUser[i].img.height / 2 ;
			
				this.addChild(arrayUser[i].img);
				this.addChild(arrayUser[i].text);
				y += 100;
				
			}
		}
		
		private function cleanUp():void
		{
			this.removeChild(user1.img);
			this.removeChild(user1.text);
			this.removeChild(user2.img);
			this.removeChild(user2.text);
			
		}
	}
}