package gameViews
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.FacebookSession;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class Test01GameView extends Sprite implements GameView
	{
		private var APP_ID:String = "164181750458934"; 
		private var PERMISSIONS:Array = ["publish_stream","user_website","user_status","user_about_me"];
		private var image:Image;
		private var picture:Image;
		
		public function Test01GameView()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			trace("Test01GameView:onAddedToStage; initializing resources.");
			
			//Facebook.addJSEventListener("auth.sessionChange", initHandler);
			//Facebook.init(APP_ID, initHandler, {cookie: true, appId: APP_ID, perms: PERMISSIONS});
			//Facebook.init(APP_ID, initHandler);
			//Facebook.login(loginHandler);
			image = new Image(Assets.getTexture("testImage"));
			this.addChild(image);
			image.x = 0;
			image.y= 256;
			image.smoothing = TextureSmoothing.BILINEAR; 
			trace("Test01GameView:onAddedToStage; initializing resources completed.");
		}
		
		private function initHandler(success:Object,fail:Object):void
		{
			if(success)         
			{               
				trace("success init");  
				trace(Facebook.getImageUrl(success.uid,"small"));
				// good the user is already connected       
				var urlPicture:String = Facebook.getImageUrl(success.uid);
				// create the loader
				var loader:Loader = new Loader();
				// load the texture
				loader.load ( new URLRequest (urlPicture) );
				// when texture is loaded
				loader.contentLoaderInfo.addEventListener ( flash.events.Event.COMPLETE, onComplete );
				
				trace("accessToken :: " + Facebook.getAuthResponse().accessToken); // correct value
				trace("uid :: " + Facebook.getAuthResponse().uid); //correct value  
				
				postToServer(success);
			}           
			else            
			{
				trace("logging in");
				Facebook.login(loginHandler,PERMISSIONS);
			}       
		}
		
		private function loginHandler(success:Object,fail:Object):void
		{
			
			trace('loginHandler called');
			// TODO Auto Generated method stub
			if(success)         
			{               
				trace('Good');
				trace(Facebook.getImageUrl(success.uid,"small"));
				// good the user is already connected       
				var urlPicture:String = Facebook.getImageUrl(success.uid);
				// create the loader
				var loader:Loader = new Loader();
				// load the texture
				loader.load ( new URLRequest (urlPicture) );
				// when texture is loaded
				loader.contentLoaderInfo.addEventListener ( flash.events.Event.COMPLETE, onComplete );
				
				trace("accessToken :: " + Facebook.getAuthResponse().accessToken); // correct value
				trace("uid :: " + Facebook.getAuthResponse().uid); //correct value
				
				postToServer(success);
			}           
			else            
			{
				trace('FAILURE');
			} 
		}		
		
		private function onComplete ( e : flash.events.Event ):void
		{
			// grab the loaded bitmap
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			
			// create a texture from the loaded bitmap
			var texture:Texture = Texture.fromBitmap ( loadedBitmap )
			
			picture = new Image(texture);
			picture.x=0;
			picture.y=300;
			picture.width=200;
			picture.height=200;
			this.addChild(picture);
		}
		
		
		
		private function testKeyDown(event:KeyboardEvent):void
		{
			// TODO Auto Generated method stub
			switch(String.fromCharCode(event.charCode)){
				case "3":
					break;
			}
		}
		
		private function postToServer(session:Object):void{
			trace("POSTING 1");
			var urlRequest:URLRequest = new URLRequest("https://23.239.9.193/line-bounce/authenticate.php");
			urlRequest.method = "POST";
			
			var variables:URLVariables = new URLVariables();
			variables.accessToken = Facebook.getAuthResponse().accessToken;
			
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