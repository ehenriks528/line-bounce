package
{
	import flash.media.Sound;
	
	public class Sounds
	{
		public function Sounds()
		{
		}
		//background music
		[Embed(source="Media/Sounds/Ambiance.mp3")]
		public static const Ambiance:Class;
		//used whenever collisions occur
		[Embed(source="Media/Sounds/Boing.mp3")]
		public static const Collision:Class;
		
		public static var bgMusic:Sound = new Sounds.Ambiance() as Sound;
		public static var collisionFX:Sound = new Sounds.Collision() as Sound;
		
		public static var musicMuted:Boolean = false;
		public static var soundFXMuted:Boolean = false;
	}
}