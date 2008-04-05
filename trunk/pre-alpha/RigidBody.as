package {
	import WOWMatrixFunc;
	import WOWVector3Func;
	import WOWMatrix;
	import WOWVector3;
	import WOWQuaternion;
	import Edge;
	import triangle;

	public class RigidBody {
		public var vertices:Array;
		public var verticesNum:int;
		public var trianglesNum:int;
		public var collisionRadii:int;
		public var visible:Boolean;
		public var groundCollisionState:Boolean;
		public var rigidBodyCollisionState:Boolean;
		public var part:Boolean;
		
		public var mass:Number;
		public var coeffOfRestitution:Number;
		public var coeffOfFriction:Number;
		public var inertia:WOWMATRIX;
		public var InvInertia:WOWMATRIX;
		public var Orientation:WOWMATRIX;
		public var size:WOWVector3;
		public var cgPosition:WOWVector3;
		public var angles:WOWVector3;
		public var forces:WOWVector3;
		public var torques:WOWVector3;
		public var linImpulse:WOWVector3;
		public var rotImpulse:WOWVector3;
		
		public var linVelocity:WOWVector3;
		public var rotVelocity:WOWVector3;
		public var linAcceleration:WOWVector3;
		public var rotAcceleration:WOWVector3;
		
		public var axis:WOWVector3;
		public var angle:Number;
		
		
		public var localAxis:Array;
		
		public var rotation:WOWQuaternion;
		
		public var groundCollisionInfo:Array;
		public var rigidBodyCollisionInfo:Array;
		
		public var rbEdge:Array;
		public var rbTriangles:Array;

		public function RigidBody (m:Number,cr:Number,cf:Number,s:WOWVector3) {	
			groundCollisionState=false;
			rigidBodyCollisionState=false;
			part=false;
			mass=m;
			coeffOfRestitution=cr;
			coeffOfFriction=cf;
			
			cgPosition=new WOWVector3(0,0,0);
			angles=new WOWVector3(0,0,0);
			size=s
			collisionRadii=Math.sqrt(Math.pow(size.x/2,2)+Math.pow(size.y/2,2)+Math.pow(size.z/2,2));
			localAxis=new Array(3)
			localAxis[0]=new WOWVector3(1,0,0);
			localAxis[1]=new WOWVector3(0,1,0);
			localAxis[2]=new WOWVector3(0,0,1);
		
			inertia=WOWMATRIX(0,0,0,0,
							   0,0,0,0,
							   0,0,0,0,
							   0,0,0,0);
		
			InvInertia=WOWMATRIX(0,0,0,0,
								  0,0,0,0,
								  0,0,0,0,
								  0,0,0,0);
		
			axis=new WOWVector3(0,0,0);
			angle=0;
			rotation=WOWQuaternion(axis.x,axis.y,axis.z,angle);
			WOWMatrixFunc.RotationY(Orientation,0);
		
			forces			= new WOWVector3(0, 0, 0);
			torques			= new WOWVector3(0, 0, 0);
			linImpulse      = new WOWVector3(0, 0, 0);
			rotImpulse      = new WOWVector3(0, 0, 0);
			linVelocity  	= new WOWVector3(0, 0, 0);
			rotVelocity		= new WOWVector3(0, 0, 0);
			linAcceleration	= new WOWVector3(0, 0, 0);
			rotAcceleration	= new WOWVector3(0, 0, 0);
		}
		public function resetForce():void
		{
			forces			= new WOWVector3(0, 0, 0);
			torques			= new WOWVector3(0, 0, 0);
			linAcceleration	= new WOWVector3(0, 0, 0);
			rotAcceleration	= new WOWVector3(0, 0, 0);
		}
		public function AddTorque(t:WOWVector3):void{
			torques=WOWVector3Func.plus(torques,t);
			//	D3DXVec3TransformNormal(&rotAcceleration,&torques,&InvInertia);
			rotAcceleration=WOWVector3Func.transformNormal(torques,InvInertia);

		};
		public function AddForce(p:WOWVector3, f:WOWVector3):void{
		
			forces=WOWVector3Func.plus(forces,f);
		
			linAcceleration=WOWVector3Func.div(forces,mass);
			var t:WOWVector3=WOWVector3Func.cross(p-cgPosition,f)
			//D3DXVec3Cross(&t,&(*p-cgPosition),f);
			AddTorque(t);
		};
		public function AddImpulse(pr:WOWVector3, j:WOWVector3):void{

			linImpulse=WOWVector3Func.plus(linImpulse,j);
			var temp:WOWVector3=WOWVector3Func.cross(pr,j);
			rotImpulse=WOWVector3Func.plus(rotImpulse,temp);
			
		};
		public function applyImpulse():void{};
		public function resetForce():void{};
		public function setPos(pos:WOWVector3):void{};
		public function setAng(ang:WOWVector3):void{};
		public function rotateRB(ax:WOWVector3, ang:Number):void{};
		public function Update():void{};
		
		public function updateVertices():void{};
			
		
		public function checkParticleCollision(pt:Particle):void{};
		public function checkRBCollision(rb:RigidBody):void{};
		
		public function groundCollisionResponse():void{};
		protected function computeOrientation(a:WOWVector3,d:Number):void{};
		protected function rotateVector(v:WOWVector3):void{}
	}
}