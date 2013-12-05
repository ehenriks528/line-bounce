package states
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
	
	public class Shop extends Sprite
	{
		private var bg:Image;
		private var shopTitle:TextField;
		
		private var item1:Button;
		private var item1Text:TextField;
		private var item2:Button;
		private var item2Text:TextField;
		
		private var shop1:Button;
		private var shop2:Button;
		private var shop3:Button;
		
		//confirmation buttons
		private var yb:Button;
		private var nb:Button;
		
		//keeps track of current shop tab open, 0 for powerups, 1 for skins, 2 for backgrounds etc.
		private var shopID:int;
		
		private var popUp:ScrollContainer; //popup menu for confirmation of sale
		private var itemCont:ScrollContainer; //contains powerups for sale
		
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
			
			//Switch between different shops
			var shopCont:ScrollContainer = new ScrollContainer();
			var shopLayout:HorizontalLayout = new HorizontalLayout();
			shopLayout.gap = 10;
			shopCont.layout = shopLayout;
			
			shop1 = new Button(Assets.getTexture("tabButton"));
			shop2 = new Button(Assets.getTexture("tabButton"));	
			shop3 = new Button(Assets.getTexture("tabButton"));
			
			shop1.text = "PowerUps";
			shop2.text = "Skins";
			shop3.text = "Backgrounds";
			shopCont.addChild(shop1);
			shopCont.addChild(shop2);
			shopCont.addChild(shop3);
			shopCont.y = 100;
			this.addChild(shopCont);
			
			var quad:Quad = new Quad(100, 60, 0x000000);
			quad.x = 20;
			quad.y = this.stage.height - 80;
			this.addChild(quad);
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
		} 
		
		private function loadShop1():void 
		{
			shopID = 0;
			shopTitle.text = "Shop - Powerups";
			this.addChild(shopTitle);
			x = 50;
			y = 0;
			
			itemCont = new ScrollContainer();
			this.addChild(itemCont);
			//var layout:VerticalLayout= new VerticalLayout();
			//layout.gap = 30;
			//itemCont.layout = layout;
			itemCont.y = 200;
			itemCont.width = 500;
			itemCont.height = 500;
			//itemCont.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;			
			
			item1 = new Button(Assets.getTexture("JetPack"));
			item1.text = "Jetpack";
			item1.name = "Jetpack";
			item1.x = x;
			item1.y = y;
			
			item1Text = new TextField(400, 100, "JetPack: 100$");
			item1Text.fontSize = 36;
			item1Text.x = (this.stage.width - item1Text.width) / 2;
			item1Text.y = item1.y;
			
			itemCont.addChild(item1);
			itemCont.addChild(item1Text);
			
			y += 100;
			
			item2 = new Button(Assets.getTexture("Spring"));
			item2.text = "Spring";
			item2.name = "Spring";
			item2.x = x;
			item2.y = y;
			
			item2Text = new TextField(400, 100, "Spring: 100$", "Verdana", 36);
			item2Text.x = (this.stage.width - item2Text.width) / 2;
			item2Text.y = item2.y;
			
			itemCont.addChild(item2);
			itemCont.addChild(item2Text);
			
			var quad:Quad = new Quad(100, 400, 0xffffff);
			itemCont.addChild(quad);
			quad.x = 100;
			quad.y = 300;
			
			this.addEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		
		private function loadShop2():void
		{
			shopID = 1;
			shopTitle.text = "Shop - Skins";
			this.addChild(shopTitle);
		}
		
		private function loadShop3():void
		{
			shopID = 2;
			shopTitle.text = "Shop - Backgrounds";
			this.addChild(shopTitle);
		}
	}
}