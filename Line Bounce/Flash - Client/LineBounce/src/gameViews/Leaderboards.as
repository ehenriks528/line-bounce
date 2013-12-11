package gameViews
{
	import controllers.GameViewController;
	
	import feathers.controls.ImageLoader;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Leaderboards extends Sprite implements GameView
	{
		public var arrayUser:Array;
		
		public var user1:userObject;
		public var userImage1:Image;
		public var user2:userObject;
		public var userImage2:Image;
		
		private var bg:Image;
		private var title:TextField;
		private var homeBtn:Button;
		
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
			
			homeBtn = new Button(Assets.getTexture("confirmButton"));
			homeBtn.text = "Home";
			homeBtn.x = 25;
			homeBtn.y = this.stage.height - 80;	
			this.addChild(homeBtn);
			
			userImage1 = new Image(Assets.getTexture("Spring"));
			user1 = new userObject("ben", 400, userImage1);
			userImage2 = new Image(Assets.getTexture("JetPack"));
			user2 = new userObject("max", 200, userImage2);
			
			arrayUser = new Array();
			arrayUser.push(user1);
			arrayUser.push(user2);
			
			
			/*Test  make userobjects take imageloaders instead of images
			var loader:ImageLoader = new ImageLoader();
			loader.source = "https://scontent-b.xx.fbcdn.net/hphotos-ash3/46630_10200551739269718_12025910_n.jpg";
			this.addChild(loader);
			loader.x = 50;
			loader.y = 400;
			
			//end test
			*/
			//server client shenangians to get list of users for leaderboards
			//positioning of user's info
			var x:int = 50;
			var y:int = 200;
			
			for (var i:int = 0; i < arrayUser.length; i++) {
				arrayUser[i].img.x = x;
				arrayUser[i].img.y = y;
				arrayUser[i].text.x = x ;
				arrayUser[i].text.y = y- arrayUser[i].img.height/3;
			
				this.addChild(arrayUser[i].img);
				this.addChild(arrayUser[i].text);
				y += 100;
			}
			
			this.addEventListener(Event.TRIGGERED, onButtonPressed);
		}
		
		private function onButtonPressed(event:Event):void
		{
			var button:Button = event.target as Button;
			if (button == homeBtn) 
			{
				GameViewController.exitGameView(GameViewController.getGameView("Leaderboards"));
				GameViewController.enterGameView(GameViewController.getGameView("MainMenu"));
			}
		}
		
		/*
		private function postToServer(session:Object):void{
			trace("POSTING 1");
			var urlRequest:URLRequest = new URLRequest("https://23.239.9.193/line-bounce/authenticate.php");
			urlRequest.method = "POST";
			var variables:URLVariables = new URLVariables();
			variables.accessToken = FacebookDesktop.getSession().accessToken;
			urlRequest.data = variables;
			urlRequest.method = 'POST';
			trace("POSTING 2");
			var urlLoader:URLLoader = new URLLoader(urlRequest);
			trace("POSTING 3");
			urlLoader.addEventListener(flash.events.Event.COMPLETE,  function(event:flash.events.Event):void{
				trace("POSTING 5 SUCCESS!!!");
				trace(XML(event.target.data));
			});
			trace("POSTING 4");
		}
		*/
		
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
		}
		
		public function pause():void
		{
			
		}
		
		public function unpause():void
		{
			
		}
	}
}