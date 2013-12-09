package states
{
	import starling.display.Image;
	import starling.text.TextField;
	
	public class userObject
	{
		//display users on leaderboards, must display name, score, facebook profile pic
		public var img:Image;
		public var text:TextField;
		
		
		public function userObject(n:String, s:int, i:Image):void
		{
			var output:String = n + ": " + s as String;
			this.text = new TextField(400,100,output, "Verdana", 36);
			this.img = i;
		}
	}
}