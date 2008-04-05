package {

	import RigidBody;
	import WOWVector3;
	
	public class Cube extends RigidBody{
	
		private var verticesPos:Array()
		public function Cube (m:Number,cr:Number,cf:Number,v:Boolean,s:WOWVector3) {
			super(m,cr,cf,s);
			visible=v;
		}
		private function initVerticesPos():void{
		}
		private function initIndices():void{
		}
	}
}