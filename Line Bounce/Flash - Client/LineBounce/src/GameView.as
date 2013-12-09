package
{
	public interface GameView
	{
		
		function initialize():void; //make it visible
		function disposeTemporarily():void; //get rid of everything
		function pause():void; 
		function unpause():void;
		function update(delta:int):void;
	}
}