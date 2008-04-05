package {
	import WOWMatrixFunc;
	import WOWVectorFunc;
	import WOWMatrix;
	import WOWVector;
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
		public var size:WOWVector;
		public var cgPosition:WOWVector;
		public var angles:WOWVector;
		public var forces:WOWVector;
		public var torques:WOWVector;
		public var linImpulse:WOWVector;
		public var rotImpulse:WOWVector;
		
		public var linVelocity:WOWVector;
		public var rotVelocity:WOWVector;
		public var linAcceleration:WOWVector;
		public var rotAcceleration:WOWVector;
		
		public var axis:WOWVector;
		public var angle:Number;
		
		
		public var localAxis:Array;
		
		public var rotation:WOWQuaternion;
		
		public var groundCollisionInfo:Array;
		public var rigidBodyCollisionInfo:Array;
		
		public var rbEdge:Array;
		public var rbTriangles:Array;

		public function RigidBody (m:Number,cr:Number,cf:Number,s:WOWVector) {	
			groundCollisionState=false;
			rigidBodyCollisionState=false;
			part=false;
			mass=m;
			coeffOfRestitution=cr;
			coeffOfFriction=cf;
			
			cgPosition=new WOWVector(0,0,0);
			angles=new WOWVector(0,0,0);
			size=s
			collisionRadii=Math.sqrt(Math.pow(size.x/2,2)+Math.pow(size.y/2,2)+Math.pow(size.z/2,2));
			localAxis=new Array(3)
			localAxis[0]=new WOWVector(1,0,0);
			localAxis[1]=new WOWVector(0,1,0);
			localAxis[2]=new WOWVector(0,0,1);
		
			inertia=WOWMATRIX(0,0,0,0,
							   0,0,0,0,
							   0,0,0,0,
							   0,0,0,0);
		
			InvInertia=WOWMATRIX(0,0,0,0,
								  0,0,0,0,
								  0,0,0,0,
								  0,0,0,0);
		
			axis=new WOWVector(0,0,0);
			angle=0;
			rotation=WOWQuaternion(axis.x,axis.y,axis.z,angle);
			WOWMatrixFunc.RotationY(Orientation,0);
		
			forces			= new WOWVector(0, 0, 0);
			torques			= new WOWVector(0, 0, 0);
			linImpulse      = new WOWVector(0, 0, 0);
			rotImpulse      = new WOWVector(0, 0, 0);
			linVelocity  	= new WOWVector(0, 0, 0);
			rotVelocity		= new WOWVector(0, 0, 0);
			linAcceleration	= new WOWVector(0, 0, 0);
			rotAcceleration	= new WOWVector(0, 0, 0);
		}
		public function resetForce():void
		{
			forces			= new WOWVector(0, 0, 0);
			torques			= new WOWVector(0, 0, 0);
			linAcceleration	= new WOWVector(0, 0, 0);
			rotAcceleration	= new WOWVector(0, 0, 0);
		}
		public function AddTorque(t:WOWVector):void{
			torques=WOWVectorFunc.plus(torques,t);
			//	D3DXVec3TransformNormal(&rotAcceleration,&torques,&InvInertia);
			rotAcceleration=WOWVectorFunc.transformNormal(torques,InvInertia);

		};
		public function AddForce(p:WOWVector, f:WOWVector):void{
		
			forces=WOWVectorFunc.plus(forces,f);
		
			linAcceleration=WOWVectorFunc.div(forces,mass);
			var t:WOWVector=WOWVectorFunc.cross(p-cgPosition,f)
			//D3DXVec3Cross(&t,&(*p-cgPosition),f);
			AddTorque(t);
		};
		public function AddImpulse(pr:WOWVector, j:WOWVector):void{

			linImpulse=WOWVectorFunc.plus(linImpulse,j);
			var temp:WOWVector=WOWVectorFunc.cross(pr,j);
			rotImpulse=WOWVectorFunc.plus(rotImpulse,temp);
			
		};
		public function applyImpulse():void{};
		public function resetForce():void{};
		public function setPos(pos:WOWVector):void{};
		public function setAng(ang:WOWVector):void{};
		public function rotateRB(ax:WOWVector, ang:Number):void{};
		public function Update():void{};
		
		public function updateVertices():void{};
			
		
		public function checkParticleCollision(pt:Particle):void{};
		public function checkRBCollision(rb:RigidBody):void{};
		
		public function groundCollisionResponse():void{};
		protected function computeOrientation(a:WOWVector,d:Number):void{};
		protected function rotateVector(v:WOWVector):void{}
	}
}