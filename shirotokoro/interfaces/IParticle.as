package shirotokoro.interfaces
{

	include Vector3;

	//namespace shirotokoro
	public interface IParticle
	{
		
		/*protected*/
		
		/* Characteristic Data and State */
		protected var _inverseMass:Number;
		protected var _damping:Number;
		protected var _position:Vector3;
		protected var _velocity:Vector3;
		protected var _forceAccum:Vector3
		protected var _acceleration:Vector3
		
		
		
		/* public*/
		public function integrate(duration:Number):void;
		
		public function set mass(__mass:Number):void;
		public function get mass() :Number;
		
		public function set inverseMass(__inverseMass:Number):void;
		public function get inverseMass():Number;
		
		public function hasFiniteMass() :Boolean;
		
		public function set damping(__damping:Number):void;
		public function get damping() :Number;
		
		public function set position(__position:Vector3):void;
		public function get position() :Vector3;
		
		public function set velocity(__velocity:Vector3):void;
		public function get velocity() :Vector3; 
		 
		public function set acceleration(__acceleration:Vector3):void;
		public function get acceleration() :Vector3; 
		  
		public function clearAccumulator():void;
		public function addForce(__force:Vector3):void;
		
		}
	}
}