package {

	import WOWMatrixFunc;
	import WOWVectorFunc;
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
		public function transformNormal(pV:WOWVector,pM:WOWMatrix):WOWVector{
			var pOut=new WOWVector();
			return pOut;
		}
		/*
		D3DXVec3Cross ============ cross
		//Determines the cross-product of two 3-D vectors.
		//see  http://msdn2.microsoft.com/en-us/library/bb205507(VS.85).aspx
		*/
		public function cross(pV1:WOWVector,pV2:WOWVector):WOWVector{
			var pOut=new WOWVector();
			return pOut;
		}
		
		public function div(pV1:WOWVector,pV2:WOWVector):WOWVector{
		}
		
	}
}
