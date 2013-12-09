package gameViews
{
	import feathers.controls.ScrollContainer;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Shop extends Sprite implements GameView
	{
		private var bg:Image;
		private var shopTitle:TextField;
		
		private var item1:Button;
		private var item1Text:TextField;
		private var item2:Button;
		private var item2Text:TextField;
		private var item:Button;
		private var itemText:TextField;
		
		private var itemArray:Array;
		
		private var shop1:Button;
		private var shop2:Button;
		private var shop3:Button;
		private var shop4:Button;
		
		//confirmation buttons
		private var yb:Button;
		private var nb:Button;
		
		private var homeBtn:Button;
		
		//keeps track of current shop tab open, 0 for powerups, 1 for skins, 2 for backgrounds etc.
		private var shopID:int;
		
		private var popUp:ScrollContainer; //popup menu for confirmation of sale
		private var itemCont:ScrollContainer; //contains powerups for sale
		private var shopCont:ScrollContainer; //contains tabs for different shops
		
		private var x:int;
		private var y:int;
		
		public function Shop()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			trace("shopmenu init");
			drawScreen();
		}
		
		private function onButtonTriggered(event:Event):void
		{
			var button:Button = event.target as Button;
			if (button == item1 || button == item2) //etc for however many items are created
				createPopUp(button);
		}
		
		private function createPopUp(button:Button):void 
		{
			popUp = new ScrollContainer();
			yb = new Button(Assets.getTexture("confirmButton"));
			yb.text = "Yes";
			yb.x = 60;
			yb.y = 100;
			
			nb = new Button(Assets.getTexture("confirmButton"));
			nb.text = "No";
			nb.x = 150;
			nb.y = 100;
			
			var q:Quad = new Quad(300,200, 0xffffff);
			q.alpha = 0.75;
			popUp.addChild(q);	
			var confirmText:TextField = new TextField(300, 100, "Are you sure you want to buy the " + button.name + "?");
			popUp.addChild(confirmText);
			popUp.addChild(yb);
			popUp.addChild(nb);
			PopUpManager.addPopUp(popUp, true, true);
			popUp.addEventListener(Event.TRIGGERED, onConfirmation);

		}
		
		private function onConfirmation(event:Event):void
		{
			var buttonPressed:Button = event.target as Button
			if (buttonPressed == yb) {
				trace ("yes");
				//purchase bullshit
				popUp.removeFromParent();
			}
				
			else if (buttonPressed == nb) {
				trace ("no");
				popUp.removeFromParent();
		
			}
				
		}
		
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("Background"));
			this.addChild(bg);
			
			shopTitle = new TextField(400,100,"");
			shopTitle.fontSize = 36;
			shopTitle.x = (this.stage.width - shopTitle.width ) / 2; 
			
			//Load first page of shop (PowerUps)
			loadShop1();
			
			//used to switch between different shops
			shopCont = new ScrollContainer();
			var shopLayout:HorizontalLayout = new HorizontalLayout();
			shopLayout.gap = 10;
			shopCont.layout = shopLayout;
			
			shop1 = new Button(Assets.getTexture("tabButton"));
			shop2 = new Button(Assets.getTexture("tabButton"));	
			shop3 = new Button(Assets.getTexture("tabButton"));
			shop4 = new Button(Assets.getTexture("tabButton"));
			
			shop1.text = "PowerUps";
			shop2.text = "Skins";
			shop3.text = "Backgrounds";
			shop4.text = "Coins";
			
			shopCont.addChild(shop1);
			shopCont.addChild(shop2);
			shopCont.addChild(shop3);
			shopCont.addChild(shop4);
			shopCont.y = 113;
			this.addChild(shopCont);
			
			homeBtn = new Button(Assets.getTexture("confirmButton"));
			homeBtn.text = "Home";
			homeBtn.x = 25;
			homeBtn.y = this.stage.height - 80;	
			this.addChild(homeBtn);
			
			this.addEventListener(Event.TRIGGERED, onShopChange);
		}
		
		private function onShopChange(event:Event):void
		{
			var button:Button = event.target as Button;
			
			if (button == shop1) {
				//ensure user doesn't keep reloading shop page if already on it /performance
				if (shopID == 0)
					return;
				else {
					this.removeChild(shopTitle);
					this.removeChild(itemCont); //unload current shop
					loadShop1();
				}
			}
			if (button == shop2) {
				if (shopID == 1)
					return;
				else {
					this.removeChild(shopTitle);
					this.removeChild(itemCont); 
					loadShop2();
				}
			}
			if (button == shop3) {
				if (shopID == 2)
					return;
				else {
					this.removeChild(shopTitle);
					this.removeChild(itemCont); 
					loadShop3();
				}
			}
			if (button == shop4) {
				if(shopID == 3)
					return;
				else{
					this.removeChild(shopTitle);
					this.removeChild(itemCont);
					loadShop4();
				}
			}
			if (button == homeBtn) {
				GameViewController.exitGameView(GameViewController.getGameView("Shop"));
				GameViewController.enterGameView(GameViewController.getGameView("MainMenu"));
			}
		} 
		
		private function loadShop1():void 
		{
			//initialize shop information
			shopID = 0;
			shopTitle.text = "Shop - Powerups";
			this.addChild(shopTitle);
			x = 50;
			y = 30;
			
			itemCont = new ScrollContainer();
			this.addChild(itemCont);
			
			itemCont.y = 200;
			itemCont.width = 500;
			itemCont.height = 500;
			//itemCont.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;			
			
			//array for holding powerup images(buttons) and corresponding text fields
			itemArray = new Array();
			
			//create all necessary data
			item1 = new Button(Assets.getTexture("AngelWings"));
			item1.name = "Angel Wings";
			itemArray.push(item1);
			
			item1Text = new TextField(300, 100, "Wings: 100$", "Verdana", 36);
			itemArray.push(item1Text);
			
			item2 = new Button(Assets.getTexture("Shield"));
			item2.name = "Shield";
			itemArray.push(item2);
			
			item2Text = new TextField(300, 100, "Shield: 100$", "Verdana", 36);
			itemArray.push(item2Text);
			
			//add items to shop
			addArrayToShop(itemArray);
			
			this.addEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		private function addArrayToShop(iArray:Array):void{
			for (var i:int = 0; i < iArray.length; i+=2) {
				iArray[i].x = x;
				iArray[i].y = y;
				
				iArray[i+1].x = (this.stage.width - iArray[i+1].width) / 2;
				iArray[i+1].y = y - iArray[i].height / 3;
				
				itemCont.addChild(iArray[i]);
				itemCont.addChild(iArray[i+1]);
				
				y += 100;
			}
		}
		
		//loads shop skins
		private function loadShop2():void
		{
			shopID = 1;
			shopTitle.text = "Shop - Skins";
			this.addChild(shopTitle);
			
			//initialize shop information
			shopID = 0;
			shopTitle.text = "Shop - Powerups";
			this.addChild(shopTitle);
			x = 50;
			y = 30;
			
			itemCont = new ScrollContainer();
			this.addChild(itemCont);
			
			itemCont.y = 200;
			itemCont.width = 500;
			itemCont.height = 500;
			//itemCont.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;			
			
			//array for holding powerup images(buttons) and corresponding text fields
			itemArray = new Array();
		}
		
		//loads shop backgrounds
		private function loadShop3():void
		{
			shopID = 2;
			shopTitle.text = "Shop - Backgrounds";
			this.addChild(shopTitle);
			
			//initialize shop information
			shopID = 0;
			shopTitle.text = "Shop - Powerups";
			this.addChild(shopTitle);
			x = 50;
			y = 30;
			
			itemCont = new ScrollContainer();
			this.addChild(itemCont);
			
			itemCont.y = 200;
			itemCont.width = 500;
			itemCont.height = 500;
			//itemCont.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;			
			
			//array for holding powerup images(buttons) and corresponding text fields
			itemArray = new Array();
		}
		
		//loads shop coins
		private function loadShop4():void
		{
			shopID = 3;
			shopTitle.text = "Shop - Coins";
			trace(shopTitle.text);
			this.addChild(shopTitle);
			
			//initialize shop information
			shopID = 0;
			shopTitle.text = "Shop - Powerups";
			this.addChild(shopTitle);
			x = 50;
			y = 30;
			
			itemCont = new ScrollContainer();
			this.addChild(itemCont);
			
			itemCont.y = 200;
			itemCont.width = 500;
			itemCont.height = 500;
			//itemCont.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;			
			
			//array for holding powerup images(buttons) and corresponding text fields
			itemArray = new Array();
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
		
		public function initialize():void
		{
			this.visible = true;
		}
	}
}