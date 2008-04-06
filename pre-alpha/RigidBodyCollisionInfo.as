package {

	import WOWVector;

	public class RigidBodyCollisionInfo {
	
		public var collisionDepth:Number;
		public var collisionPoint:WOWVector;
		public var collisionPointR:WOWVector;
		public var collisionNormal:WOWVector;
		public var collisionVelocity:WOWVector;
		public var collisionTangent:WOWVector;
		
		public function RigidBodyCollisionInfo (cd:Number,
												cp:WOWVector,
												cpr:WOWVector,
												cn:WOWVector,
												cv:WOWVector,
												ct:WOWVector) {
		
			collisionDepth=cd;
			collisionPoint=cp;
			collisionPointR=cpr;
			collisionNormal=cn;
			collisionVelocity=cv;
			collisionTangent=ct;
			
		}	
	}
}