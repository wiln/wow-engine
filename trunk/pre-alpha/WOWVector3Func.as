package {

	import WOWMatrixFunc;
	import WOWVector3Func;
	import WOWMatrix;
	import WOWVector3;
	public class WOWVector3Func {
	
		private function WOWVector3Func () {

		}
		/*
		TransformNormal  ======================= D3DXVec3TransformNormal
		see http://msdn2.microsoft.com/en-us/library/bb205524.aspx
		
		Transforms the 3D vector normal by the given matrix.
		
		*/
		public function transformNormal(pV:WOWVector3,pM:WOWMatrix):WOWVector3{
			var pOut=new WOWVector3();
			return pOut;
		}
		/*
		D3DXVec3Cross ============ cross
		//Determines the cross-product of two 3-D vectors.
		//see  http://msdn2.microsoft.com/en-us/library/bb205507(VS.85).aspx
		*/
		public function cross(pV1:WOWVector3,pV2:WOWVector3):WOWVector3{
			var pOut=new WOWVector3();
			return pOut;
		}
		
		public function div(pV1:WOWVector3,pV2:WOWVector3):WOWVector3{
		}
		
	}
}
