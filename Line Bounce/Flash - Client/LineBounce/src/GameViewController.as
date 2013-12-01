package
{	
	
	import gameViews.Test01GameView;
	
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IOrderedListIterator;
	
	import starling.display.Sprite;

	public class GameViewController extends Sprite
	{
		private static var instance:GameViewController;
		private static var currentGameViews:ArrayList;
		public static var test01GameView:GameView;
		
		public function GameViewController()
		{
		}
		
		/**
		 * Sets up the instance of the GameViewController.
		 * There is an instance of the static class which is used to store GameView sprites.
		 * The GameView Sprites are added to the instance stored here so that GameViewController can be added
		 * as a child to the main game and render those GameViews as needed.
		 * 
		 * same method as getInstance.
		 */
		public static function initialize():GameViewController
		{	
			if(instance == null)
				instance = new GameViewController();
			return instance;
		}
		/**
		 * Sets up the instance of the GameViewController.
		 * There is an instance of the static class which is used to store GameView sprites.
		 * The GameView Sprites are added to the instance stored here so that GameViewController can be added
		 * as a child to the main game and render those GameViews as needed.
		 * 
		 * Same method as initialize
		 */
		public static function getInstance():GameViewController
		{
			if(instance == null)
				instance = new GameViewController();
			return instance;
		}
		
		/**
		 * Returns a GameView based off a name provided.
		 * Fed a String object, returns a GameView object.
		 */
		public static function getGameView(viewName:String):GameView
		{
			switch(viewName){
				case "Test01":
					if(test01GameView == null)
						test01GameView = new Test01GameView();
					instance.addChild(test01GameView as Sprite);
					trace("GameViewController:getGameView; Returning test01GameView");
					return test01GameView as GameView;
			}
			trace("GameViewController:getGameView; Returning null");
			return null;
		}
		
		/**
		 * Enters the provided gameView.
		 * Initialized the provided gameView.
		 * Does not dispose of other entered gameViews.
		 * 
		 */
		public static function enterGameView(gameView:GameView):void
		{
			if(currentGameViews === null )
				currentGameViews = new ArrayList();
			
			// See if we're already in this GameView or not by iterating over it. The ArrayList doesn't have "contains(Element)" so I do this instead.
			var iterator:IOrderedListIterator = currentGameViews.iterator() as IOrderedListIterator;
			while (iterator.hasNext()) {
				if(gameView == iterator.next()){
					trace("GameViewController:enterGameView; Already in this GameView, returning.");
					return;
				}
			}
			
			trace("GameViewController:enterGameView; Adding view to list and intializing");
			currentGameViews.add(gameView);
			gameView.initialize();
			trace("GameViewController:enterGameView; Finished entering GameView");
		}
		
		
		/**
		 * Leaves the provided gameView.
		 * Disposes the provided gameView.
		 * You may only leave a state that has been entered
		 * 
		 */
		public static function exitGameView(gameView:GameView):void
		{
			if(currentGameViews === null ){
				currentGameViews = new ArrayList();
				trace("GameViewController:exitGameView; Not in this state, returning");
				return;
			}
			trace("GameViewController:exitGameView; Attempting to remove the GameView");
			var removed:Boolean = currentGameViews.remove(gameView);
			if(removed == true){
				gameView.disposeTemporarily();
				trace("GameViewController:exitGameView; Removed GameView and temporarily disposed of it.");
			}
			else
				trace("GameViewController:exitGameView; Not in this state, returning");
		}
	}
}