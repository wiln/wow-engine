package shirotokoro.interfaces
{

	include RigidBody;
	include Vector3;
	include Matrix3;
	//namespace shirotokoro
	public interface IContact 
	{
		
		/*public*/
		public var body:Array typé RigidBody de taille 2;
		public var friction:Number;
		public var restitution:Number;
		public var contactPoint:Vector3;
		public var contactNormal:Vector3;
		public var penetration:Number;
		
		public function setBodyData(_one:RigidBody,_two:RigidBody,_friction:Number,_restitution:Number):void;
		/*protected*/
		protected var contactToWorld:Matrix3;
		protected var contactVelocity:Vector3;
		protected var desiredDeltaVelocity:Number;
		protected var relativeContactPosition:Array typé Vector3 de taille 2;

		
		protected var calculateInternals(_duration:Number):void;
		protected var swapBodies():void;
		protected var matchAwakeState():void;
		protected var calculateDesiredDeltaVelocity(_duration:Number):void;
		protected var calculateLocalVelocity(_bodyIndex:int,_duration:Number):Vector3;
		protected var calculateContactBasis():void;             
		protected var applyImpulse(_impulse:Vector3, _body:RigidBody,_velocityChange:Vector3, _rotationChange:Vector3):void;
		//param array typé vector3 de taille 2
        protected var applyVelocityChange( _velocityChange:Array*Vector3, _rotationChange:Array*Vector):void;
         //param array typé vector3 de taille 2
        protected var applyPositionChange(_linearChange:Array*Vector, _angularChange:Array*Vector,_penetration:Number);
        protected var calculateFrictionlessImpulse( _inverseInertiaTensor:Matrix3):Vector3;
        protected var calculateFrictionImpulse( _inverseInertiaTensor:Matrix3):Vector3;
	}
}