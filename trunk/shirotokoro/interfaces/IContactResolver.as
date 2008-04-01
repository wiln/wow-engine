package shirotokoro.interfaces
{

	include Vector3;

	//namespace shirotokoro
	public interface IContactResolver
	{
		
		/*protected*/
		
		protected var velocityIterations:int;
		protected var positionIterations:int;
		protected var velocityEpsilon:Number;
		protected var positionEpsilon:Number;
		
		/*public*/
		public var velocityIterationsUsed:int;
		public var positionIterationsUsed:int;
		
		
		
		public function ContactResolver(_iterations:int,
										_velocityEpsilon:Number=0.01,
										_positionEpsilon:Number=0.01);
		
		 public function ContactResolver(_velocityIterations:int,
										_positionIterations:int,
										_velocityEpsilon:Number=0.01,
										_positionEpsilon:Number=0.01);
            
        public function isValid():Boolean
        {
            return ((velocityIterations > 0) &&
                   (positionIterations > 0) &&
                   (positionEpsilon >= 0) &&
                   (positionEpsilon >= 0));   
        }
        
         public function setIterations(_velocityIterations:int,
									_positionIterations:int):void;
                           
          public function set iterations(_iterations:int):void;
                              
          public function set epsilon(_velocityEpsilon:Number,
										_positionEpsilon:Number):void;
                        
          public function resolveContacts( _contactArray:Contact,
											_numContacts:int,
											_duration:Number):void;
		/*private*/
		private var validSettings:Boolean;
			
		private function prepareContacts( _contactArray:Contact, _numContacts:int,
            _duration:Number):void;
            
        private function adjustVelocities(_contactArray:Contact,
            _numContacts:int,
           _duration:Number):void;
            
        private function adjustPositions( _contacts:Contact,
           _numContacts:int,
           _duration:Number):void;
	}
}