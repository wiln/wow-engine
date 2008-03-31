package shirotokoro.interfaces
{

	include Matrix3;
	include Matrix4;
	include Quaternion;
	include Vector3;

	//namespace shirotokoro
	public interface IRigidBody
	{
		
		/*protected*/
		
		/* Characteristic Data and State */
		protected var _inverseMass:Number;
		protected var _inverseInertiaTensor:Matrix3;
		protected var _linearDamping:Number;
		protected var _angularDamping:Number;
		protected var _position:Vector3;
		protected var _orientation:Quaternion;
		protected var _velocity:Vector3;
		protected var _rotation:Vector3
		
		/* derivate info */
		protected var _inverseInertiaTensorWorld:Matrix3;
		protected var _motion:Number;
		protected var _isAwake:Boolean;
		protected var _canSleep:Boolean;
		protected var _transformMatrix:Matrix3;
		protected var _forceAccum:Vector3
		protected var _torqueAccum:Vector3
		protected var _acceleration:Vector3
		protected var _lastFrameAcceleration:Vector3
		
		/* public*/
		
		
		public function calculateDerivedData():void;
		
		public function integrate(__duration:Number):void;
		
		public function set mass(__mass:Number):void;
		public function get mass():Number;
		
		public function set inverseMass(__inverseMass:Number):void;
		public function get inverseMass():Number;
		
		public function hasFiniteMass():Boolean;
		
		
		public function set inertiaTensor(__inertiaTensor:Matrix3):void;
		public function get inertiaTensor():Matrix3;
		public function get inertiaTensorWorld() Matrix3;  
		
		public function set inverseInertiaTensor(__inverseInertiaTensor:Matrix3):void;
		public function get inverseInertiaTensor() Matrix3;
		public function get inverseInertiaTensorWorld() :Matrix3;

		public function set damping(__linearDamping:Number, __angularDamping:Number):void;
		
		public function set linearDamping(__linearDamping:Number):void;  
		public function get linearDamping() :Number; 
		
		public function set angularDamping(__angularDamping:Number):void;
		public function get angularDamping() :Number;
		
		public function set position(__position:Vector3):void;
		public function get position() :Vector3;   

		public function set orientation(__orientation:Quaternion):void;  
		public function get orientation() :Quaternion;    

		public function get transform() :Matrix4;

		public function get PV3DTransform() :PV3DMatrix;
		public function get AwayTransform() :AwayMatrix;
		public function get SandyTransform() :SandyMatrix;
	
		public function getPointInLocalSpace(__point:Vector3) :Vector3;
		public function getPointInWorldSpace(__point:Vector3) :Vector3;
		public function getDirectionInLocalSpace(__direction:Vector3) :Vector3;
		public function getDirectionInWorldSpace(__direction:Vector3) :Vector3;
		
		public function set velocity(__velocity:Vector3):void; 
		public function get velocity() :Vector3;  
		public function addVelocity(__deltaVelocity:Vector3):void;
			
	  	public function set rotation(__rotation:Vector3):void;
		public function get rotation() :Vector3;
		public function addRotation(__deltaRotation:Vector3):void;
		   
		public function get awake() :Boolean{return _isAwake; }
		public function set awake(awake:Boolean=true):void;

		public function get canSleep():Boolean{return _canSleep;}
		public function set canSleep(__canSleep:Boolean=true):void;

		public function get lastFrameAcceleration() :Vector3;

		public function clearAccumulators():void;
		
		public function addForce(__force:Vector3):void;
		public function addForceAtPoint(_force:Vector3, __point:Vector3):void;
		public function addForceAtBodyPoint(__force:Vector3, __point:Vector3):void;
		
		public function addTorque(__torque:Vector3):void;
			  
		public function set acceleration(__acceleration:Vector3):void;
		public function get acceleration() :Vector3; 
			
	}

}