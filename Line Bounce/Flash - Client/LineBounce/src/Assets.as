package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets
	{
		[Embed(source="Media/JetPack.png")]
		public static const JetPack:Class;
		
		[Embed(source="Media/Spring.png")]
		public static const Spring:Class;
		
		[Embed(source="Media/Background.png")]
		public static const Background:Class;
		
		[Embed(source="Media/confirmButton.png")]
		public static const confirmButton:Class
		
		[Embed(source="Media/tabButton.png")]
		public static const tabButton:Class

		[Embed(source="../media/graphics/facebook.png")]
		public static const testImage:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}