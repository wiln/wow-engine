package {

	import WOWVector3;

	public class RigidBodyCollisionInfo {
	
		public var collisionDepth:Number;
		public var collisionPoint:WOWVector3;
		public var collisionPointR:WOWVector3;
		public var collisionNormal:WOWVector3;
		public var collisionVelocity:WOWVector3;
		public var collisionTangent:WOWVector3;
		
		public function RigidBodyCollisionInfo (cd:Number,
												cp:WOWVector3,
												cpr:WOWVector3,
												cn:WOWVector3,
												cv:WOWVector3,
												ct:WOWVector3) {
		
			collisionDepth=cd;
			collisionPoint=cp;
			collisionPointR=cpr;
			collisionNormal=cn;
			collisionVelocity=cv;
			collisionTangent=ct;
			
		}	
	}
}