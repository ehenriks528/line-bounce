package
{
	public interface GameView
	{
		function initialize():void;
		function disposeTemporarily():void;
		function pause():void;
		function unpause():void;
		function update(delta:int):void;
	}
}