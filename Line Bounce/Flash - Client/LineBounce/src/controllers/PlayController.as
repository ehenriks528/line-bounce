package controllers
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Common.b2Settings;
	import Box2D.Dynamics.*;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Transform;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class PlayController extends Sprite {
		// world creation
		public var world_scale:int=6;
		public var world:b2World=new b2World(new b2Vec2(0,320/world_scale),true);
		public var movement_velocity:int = 480/world_scale;
		// the player
		public var player:b2Body;
		public var player2:b2Body;
		// force to apply to the player
		public var force:b2Vec2;
		// variables to store whether the keys are pressed or not
		// true = pressed;
		// false = unpressed
		public var left:Boolean=false;
		public var right:Boolean=false;
		public var up:Boolean=false;
		public var down:Boolean=false;
		
		
		private var image:Image;
		private var image2:Image;
		
		public function PlayController():void {
			image = new Image(Assets.getTexture("testImage"));
			this.addChild(image);
			image2 = new Image(Assets.getTexture("testImage"));
			this.addChild(image2);
			
			image.x = 100;
			image.y = 100;
			image.width = 60;
			image.height = 60;
			image2.x = 100;
			image2.y = 100;
			image2.width = 60;
			image2.height = 60;
			this.addEventListener( starling.events.Event.ENTER_FRAME, update );
			// drawing the boundaries
			draw_box(240,850,480,100,false,"ground");
			draw_box(-50,400,100,800,false,"left");
			draw_abox(240,650,480,100,true,"angle",2);
			draw_box(530,400,100,800,false,"right");
			draw_box(240,-50,480,100,false,"roof");
			// adding the player at 250,200
			// some listeners
			add_player(200,200);
			add_player(200,200);
			starling.core.Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN,on_key_down);
			starling.core.Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP,on_key_up);
			
			
		}
	
		// according to the key pressed, set the proper variable to "true"
		public function on_key_down(e:flash.events.KeyboardEvent):void {
			switch (e.keyCode) {
				case 37 :
					left=true;
					break;
				case 38 :
					up=true;
					break;
				case 39 :
					right=true;
					break;
				case 40 :
					down=true;
					break;
			}
		}
		// according to the key released, set the proper variable to "false"
		public function on_key_up(e:flash.events.KeyboardEvent):void {
			switch (e.keyCode) {
				case 37 :
					left=false;
					break;
				case 38 :
					up=false;
					break;
				case 39 :
					right=false;
					break;
				case 40 :
					down=false;
					break;
			}
		}
		// simple function to draw a box
		public function draw_box(px,py,w,h,d,ud):void {
			var my_body:b2BodyDef= new b2BodyDef();
			my_body.position.Set(px/world_scale, py/world_scale);
			if (d) {
				my_body.type=b2Body.b2_dynamicBody;
			}
			var my_box:b2PolygonShape = new b2PolygonShape();
			my_box.SetAsBox(w/2/world_scale, h/2/world_scale);
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			my_fixture.shape=my_box;
			var world_body:b2Body=world.CreateBody(my_body);
			world_body.SetUserData(ud);
			world_body.CreateFixture(my_fixture);
		}
		
		// simple function to draw a box
		public function draw_abox(px,py,w,h,d,ud,a):void {
			var my_body:b2BodyDef= new b2BodyDef();
			my_body.position.Set(px/world_scale, py/world_scale);
			if (d) {
				my_body.type=b2Body.b2_dynamicBody;
			}
			var my_box:b2PolygonShape = new b2PolygonShape();
			my_box.SetAsBox(w/2/world_scale, h/2/world_scale);
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			my_fixture.shape=my_box;
			var world_body:b2Body=world.CreateBody(my_body);
			world_body.SetUserData(ud);
			world_body.CreateFixture(my_fixture);
			
			var angle:b2Mat22 = new b2Mat22();
			angle.Set(.785);
			world_body.SetTransform(new b2Transform(world_body.GetWorldCenter(),angle));
		}
		// function to add the player
		public function add_player(px,py):void {
			var my_body:b2BodyDef= new b2BodyDef();
			my_body.position.Set(px/world_scale, py/world_scale);
			my_body.type=b2Body.b2_dynamicBody;
			var my_circle:b2CircleShape=new b2CircleShape(25/world_scale);
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			my_fixture.shape=my_circle;
			my_fixture.restitution = 1;
			my_fixture.friction = 0;
			if(!player){
			player=world.CreateBody(my_body);
			player.CreateFixture(my_fixture);
			}
			else{
				player2=world.CreateBody(my_body);
				player2.CreateFixture(my_fixture);
			}
			
		}
		
		// functiojn to be executed at every frame
		public function update(e:starling.events.Event):void {
			// setting the force to null
			force=new b2Vec2(0,0);
			// according to the key(s) pressed, add the proper vector force
			if (left) {
				force.Add(new b2Vec2(-movement_velocity/world_scale,0));
			}
			if (right) {
				force.Add(new b2Vec2(movement_velocity/world_scale,0));
			}
			if (up) {
				force.Add(new b2Vec2(0,-2*movement_velocity/world_scale));
			}
			if (down) {
				force.Add(new b2Vec2(0,movement_velocity/2/world_scale));
			}
			// if there is any force, then apply it
			if (force.x||force.y) {
				player.ApplyImpulse(force,player.GetWorldCenter());
			}
			world.Step(1/60,10,10);
			world.ClearForces();
			trace((movement_velocity/world_scale)+"   " +image.x+", "+image.y+": "+left+", "+right+", "+up+", "+down);
			image.x = (player.GetPosition().x)*world_scale - 30;
			image.y = (player.GetPosition().y)*world_scale - 30;
			
			image2.x = (player2.GetPosition().x)*world_scale - 30;
			image2.y = (player2.GetPosition().y)*world_scale - 30;
		}
		
		public function initialize():void{
			this.visible = true;
			this.addEventListener( starling.events.Event.ENTER_FRAME, update );
		}
		public function disposeTemporarily():void{
			this.visible = false;
			this.removeEventListener( starling.events.Event.ENTER_FRAME, update );
		}
	}
}