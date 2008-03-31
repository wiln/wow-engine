package shirotokoro
{
	//namespace shirotokoro
	public interface IRigidBody
	{
		
		/*protected*/
		
		/* Characteristic Data and State */
		protected var inverseMass:Number;
		protected var inverseInertiaTensor:Matrix3;
		protected var linearDamping:Number;
		protected var angularDamping:Number;
		protected var position:Vector3;
		protected var orientation:Quaternion;
		protected var velocity:Vector3;
		protected var rotation:Vector3
		
		/* devivate info */
		protected var inverseInertiaTensorWorld:Matrix3;
		protected var motion:Number;
		protected var isAwake:Boolean;
		protected var canSleep:Boolean;
		protected var transformMatrix:Matrix3;
		protected var forceAccum:Vector3
		protected var torqueAccum:Vector3
		protected var acceleration:Vector3
		protected var lastFrameAcceleration:Vector3
		
		/* public*/
		
		
		public function calculateDerivedData():void;
		
		public function integrate(duration:Number):void;
		
		public function set mass(_mass:Number):void;
		public function get mass():Number;
		
		public function set inverseMass(_inverseMass:Number):void;
		public function get inverseMass():Number;
		
		public function hasFiniteMass():Boolean;
		
		
		public function set inertiaTensor(_inertiaTensor:Matrix3):void;
		public function get inertiaTensor():Matrix3;
		public function get inertiaTensorWorld() Matrix3;  
		
		public function set inverseInertiaTensor(_inverseInertiaTensor:Matrix3):void;
		public function get inverseInertiaTensor() Matrix3;
		public function get inverseInertiaTensorWorld() :Matrix3;

		public function set damping(linearDamping:Number, angularDamping:Number):void;
		
		public function set linearDamping(linearDamping:Number):void;  
		public function get linearDamping() :Number; 
		
		public function set angularDamping(angularDamping:Number):void;
		public function get angularDamping() :Number;
		
		public function set position(_position:Vector3):void;
		public function set position(x:Number,y:Number, z:Number):void;
		public function get position() :Vector3;   

		public function set orientation(_orientation:Quaternion):void;  
		public function set orientation(r:Number,  i:Number, j:Number, k:Number):void;
		public function get orientation() :Quaternion;  
		public function get orientation():Matrix3;    

		public function get transform() :Matrix4;

		public function get PV3DTransform() :PV3DMatrix;
		public function get AwayTransform() :AwayMatrix;
		public function get SandyTransform() :SandyMatrix;
	
		public function getPointInLocalSpace(_point:Vector3) :Vector3;
		public function getPointInWorldSpace(_point:Vector3) :Vector3;
		public function getDirectionInLocalSpace(_direction:Vector3) :Vector3;
		public function getDirectionInWorldSpace(_direction:Vector3) :Vector3;
		
		public function set velocity(_velocity:Vector3):void; 
		public function set velocity(x:Number, y:Number,  z:Number):void; 
		public function get velocity() :Vector3;  
		public function addVelocity(_deltaVelocity:Vector3):void;
			
	  	public function set rotation(_rotation:Vector3):void;
		public function set rotation(x:Number,y:Number, z:Number):void;
		public function get rotation() :Vector3;
		public function addRotation(_deltaRotation:Vector3):void;
		   
		public function get awake() :Boolean{return isAwake; }
		public function set awake(awake:Boolean=true):void;

		public function get canSleep():Boolean{return canSleep;}
		public function set canSleep(canSleep:Boolean=true):void;

		public function get lastFrameAcceleration() :Vector3;

		public function clearAccumulators():void;
		
		public function addForce(_force:Vector3):void;
		public function addForceAtPoint(_force:Vector3, _point:Vector3):void;
		public function addForceAtBodyPoint(_force:Vector3, _point:Vector3):void;
		
		public function addTorque(_torque:Vector3):void;
			  
		public function set acceleration(_acceleration:Vector3):void;
		public function set acceleration(x:Number, y:Number, z:Number):void; 
		public function get acceleration() :Vector3; 
			
	}

}