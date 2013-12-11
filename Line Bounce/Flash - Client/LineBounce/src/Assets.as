package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets
	{
		[Embed(source="../media/graphics/facebook.png")]
		public static const testImage:Class;
		
		//fake red image
		[Embed(source="Media/JetPack.png")]
		public static const JetPack:Class;
		//fake blue image
		[Embed(source="Media/Spring.png")]
		public static const Spring:Class;
		//Powerups
		[Embed(source="Media/AngelWings.png")]
		public static const AngelWings:Class
		
		[Embed(source="Media/Shield.png")]
		public static const Shield:Class
		//Coins
		[Embed(source="Media/coin0.png")]
		public static const coin0:Class;
		
		[Embed(source="Media/coin1.png")]
		public static const coin1:Class;
		
		[Embed(source="Media/coin2.png")]
		public static const coin2:Class;
		
		[Embed(source="Media/coin3.png")]
		public static const coin3:Class;
		
		//GUIs
		[Embed(source="Media/Background.png")]
		public static const Background:Class;
		
		[Embed(source="Media/shopBackground.png")]
		public static const shopBackground:Class;
		
		[Embed(source="Media/MainMenuBackground.png")]
		public static const MainMenuBG:Class;
		
		[Embed(source="Media/confirmButton.png")]
		public static const confirmButton:Class
		
		[Embed(source="Media/menuButton.png")]
		public static const menuButton:Class
		
		[Embed(source="Media/tabButton.png")]
		public static const tabButton:Class
		
		[Embed(source="Media/music_on.png")]
		public static const musicON:Class
		
		[Embed(source="Media/music_off.png")]
		public static const musicOFF:Class
		
		[Embed(source="Media/sound_on.png")]
		public static const soundON:Class
		
		[Embed(source="Media/sound_off.png")]
		public static const soundOFF:Class
		
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