package controllers
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;

	public class Box2DController
	{
		// World scale: DO NOT CHANGE AFTER CREATION.
		private var world_scale:int=6;
		// Size of the world, width and height.
		private var width:int;
		private var height:int;
		// World that all objects are in.
		private var world:b2World;
		// Walls
		private var left_wall:b2Body;
		private var right_wall:b2Body;
		
		
		/**
		 * Initializes the world.
		 * Takes a width and a height, a gravity vector, and can take a world scale integer.
		 * Width and height are used to set up walls on the sides of the screen.
		 * Gravity is applied to all objects every update.
		 * World scale is used to increase performance and defaults to 6. You shouldn't need to change this value.
		 * Sets up walls on the edges of the world.
		 */
		public function Box2DController(w:int, h:int, gravity:b2Vec2, world_scale:int = null){
			width=w/world_scale;
			height=h/world_scale;
			world = new b2World(gravity,true);
			if(world_scale!=null)
				this.world_scale = world_scale;
			
			left_wall = this.getLineBody(100,height,"Left Wall",false);
			left_wall.SetPosition(new b2Vec2(-50/world_scale,height/2));
			right_wall = this.getLineBody(100,height,"Right Wall",false);
			right_wall.SetPosition(new b2Vec2(width+50/world_scale,height/2));
		}
		
		/**
		 * Returns the world scale of the Box2DController. VERY IMPORTANT! 
		 * Everything is scaled down by a factor of "world_scale" and you need this to scale it back up.
		 */
		public function getScale():int{
			return world_scale;
		}
		
		/**
		 * Returns a circle body with the radius specified.
		 * dynamic:Boolean determines if the object is "dynamic" or not, meaning that it can move if it is "dynamic" and
		 * it cannot move if "dynamic" is false. Dynamic objects can be moved manually, but will not move due to physics.
		 * 
		 * Defaults to 0 friction and 1 restitution.
		 */
		public function getCircleBody(radius, description:String = null, dynamic:Boolean = null):b2Body{
			var my_body:b2BodyDef= new b2BodyDef();
			my_body.position.Set(0, 0);
			if (dynamic == null || dynamic) {
				my_body.type=b2Body.b2_dynamicBody;
			}
			var my_circle:b2CircleShape=new b2CircleShape(radius/world_scale);
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			my_fixture.shape=my_circle;
			my_fixture.restitution = 1;
			my_fixture.friction = 0;
			var world_body:b2Body;
			world_body=world.CreateBody(my_body);
			if(description != null)
				world_body.SetUserData(description);
			world_body.CreateFixture(my_fixture);
			return world_body;
		}
		
		/**
		 * Returns a line body with the width and height specified.
		 * Description is just a description of it, typically one world such as "Left" or "Ground".
		 * dynamic:Boolean determines if the object is "dynamic" or not, meaning that it can move if it is "dynamic" and
		 * it cannot move if "dynamic" is false. Dynamic objects can be moved manually, but will not move due to physics.
		 * Default value is true.
		 * 
		 * Defaults to 0 friction and 1 restitution.
		 */
		public function getLineBody(width, height, description:String = null, dynamic:Boolean = null):b2Body{
			var my_body:b2BodyDef= new b2BodyDef();
			my_body.position.Set(0, 0);
			if (dynamic == null || dynamic) {
				my_body.type=b2Body.b2_dynamicBody;
			}
			var my_box:b2PolygonShape = new b2PolygonShape();
			my_box.SetAsBox(width/2/world_scale, height/2/world_scale);
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			my_fixture.shape=my_box;
			my_fixture.restitution = 1;
			my_fixture.friction = 0;
			var world_body:b2Body=world.CreateBody(my_body);
			if(description != null)
				world_body.SetUserData(description);
			world_body.CreateFixture(my_fixture);
			return world_body;
		}
		
		/**
		 * Removes the provided body from the world. Does not destroy the variable itself.
		 */
		public function destroyBody(body:b2Body):void{
			world.DestroyBody(body);
		}
		
		/**
		 * While in typical cases this will not be needed, you may manually add a body to the world yourself here.
		 * Useful for adding custom bodies you create to the world.
		 * 
		 * Takes a body definition, and optional fixture definition and an optional description string.
		 * 
		 * Returns the body produced.
		 */
		public function addBody(bodydef:b2BodyDef, fixdef:b2FixtureDef = null, desc:String = null):b2Body{
			var world_body:b2Body = world.CreateBody(bodydef);
			if(fixdef != null)
				world_body.CreateFixture(fixdef);
			if(desc != null)
				world_body.SetUserData(desc);
		}
		
		/**
		 * Rotates a body a given amount of degrees. This is rotation from nuetral, not addative.
		 * Final parameter is an optional boolean that determines if you want it in radians or not.
		 * True: Use radians,
		 * False: Use degrees.
		 * Default is FALSE for degrees.
		 */
		public function rotateBody(rotation, body:b2Body, radians:Boolean = null):void{
			var angle:b2Mat22 = new b2Mat22();
			var rotate = rotation;
			if(radians == null || radians ){
				rotate*=180/Math.PI;
			}
			angle.Set(rotate);
			body.SetTransform(new b2Transform(body.GetWorldCenter(),angle));
		}
		
		/**
		 * Updates Box2D objects, requires the milliseconds that have passed since the last update.
		 */
		public function update(delta:int){
			world.Step(delta/1000, 10, 10);
		}
	}
}