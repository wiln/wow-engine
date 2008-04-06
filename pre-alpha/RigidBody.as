package {
	import WOWMatrixFunc;
	import WOWVectorFunc;
	import WOWMatrix;
	import WOWVector;
	import WOWQuaternion;
	import Edge;
	import triangle;

	public class RigidBody {
		public var vertices:Array;
		public var verticesNum:int;
		public var trianglesNum:int;
		public var collisionRadii:int;
		public var visible:Boolean;
		public var groundCollisionState:Boolean;
		public var rigidBodyCollisionState:Boolean;
		public var part:Boolean;
		
		public var mass:Number;
		public var coeffOfRestitution:Number;
		public var coeffOfFriction:Number;
		public var inertia:WOWMATRIX;
		public var InvInertia:WOWMATRIX;
		public var Orientation:WOWMATRIX;
		public var size:WOWVector;
		public var cgPosition:WOWVector;
		public var angles:WOWVector;
		public var forces:WOWVector;
		public var torques:WOWVector;
		public var linImpulse:WOWVector;
		public var rotImpulse:WOWVector;
		
		public var linVelocity:WOWVector;
		public var rotVelocity:WOWVector;
		public var linAcceleration:WOWVector;
		public var rotAcceleration:WOWVector;
		
		public var axis:WOWVector;
		public var angle:Number;
		
		
		public var localAxis:Array;
		
		public var rotation:WOWQuaternion;
		
		public var groundCollisionInfo:Array;
		public var rigidBodyCollisionInfo:Array;
		
		public var rbEdge:Array;
		public var rbTriangles:Array;

		public function RigidBody (m:Number,cr:Number,cf:Number,s:WOWVector) {	
			groundCollisionState=false;
			rigidBodyCollisionState=false;
			part=false;
			mass=m;
			coeffOfRestitution=cr;
			coeffOfFriction=cf;
			
			cgPosition=new WOWVector(0,0,0);
			angles=new WOWVector(0,0,0);
			size=s
			collisionRadii=Math.sqrt(Math.pow(size.x/2,2)+Math.pow(size.y/2,2)+Math.pow(size.z/2,2));
			localAxis=new Array(3)
			localAxis[0]=new WOWVector(1,0,0);
			localAxis[1]=new WOWVector(0,1,0);
			localAxis[2]=new WOWVector(0,0,1);
		
			inertia=WOWMATRIX(0,0,0,0,
							   0,0,0,0,
							   0,0,0,0,
							   0,0,0,0);
		
			InvInertia=WOWMATRIX(0,0,0,0,
								  0,0,0,0,
								  0,0,0,0,
								  0,0,0,0);
		
			axis=new WOWVector(0,0,0);
			angle=0;
			rotation=WOWQuaternion(axis.x,axis.y,axis.z,angle);
			WOWMatrixFunc.RotationY(Orientation,0);
		
			forces			= new WOWVector(0, 0, 0);
			torques			= new WOWVector(0, 0, 0);
			linImpulse      = new WOWVector(0, 0, 0);
			rotImpulse      = new WOWVector(0, 0, 0);
			linVelocity  	= new WOWVector(0, 0, 0);
			rotVelocity		= new WOWVector(0, 0, 0);
			linAcceleration	= new WOWVector(0, 0, 0);
			rotAcceleration	= new WOWVector(0, 0, 0);
		}
		public function AddTorque(t:WOWVector):void{
			WOWVectorFunc.plusEqual(torques,t);
			//	D3DXVec3TransformNormal(&rotAcceleration,&torques,&InvInertia);
			rotAcceleration=WOWVectorFunc.transformNormal(torques,InvInertia);

		};
		public function AddForce(p:WOWVector, f:WOWVector):void{
		
			WOWVectorFunc.plusEqual(forces,f);
		
			linAcceleration=WOWVectorFunc.div(forces,mass);
			var t:WOWVector=WOWVectorFunc.cross(p-cgPosition,f)
			//D3DXVec3Cross(&t,&(*p-cgPosition),f);
			AddTorque(t);
		};
		public function AddImpulse(pr:WOWVector, j:WOWVector):void{

			WOWVectorFunc.plusEqual(linImpulse,j);
			var temp:WOWVector=WOWVectorFunc.cross(pr,j);
			WOWVectorFunc.plusEqual(rotImpulse,temp);
			
		};
		public function applyImpulse():void{
			linVelocity=WOWVectorFunc.plus(linImpulse,WOWVectorFunc.div(linImpulse,mass));
			var temp:WOWVector=WOWVectorFunc.transformNormal(rotImpulse,InvInertia);
			WOWVectorFunc.plusEqual(rotVelocity,temp);
	
			linImpulse=new WOWVector(0, 0, 0);
			rotImpulse=new WOWVector(0, 0, 0);
		};
		public function resetForce():void{
			forces			= new WOWVector(0, 0, 0);
			torques			= new WOWVector(0, 0, 0);
			linAcceleration	= new WOWVector(0, 0, 0);
			rotAcceleration	= new WOWVector(0, 0, 0);
		};
		public function setPos(pos:WOWVector):void{
			prevPos=cgPosition;
			cgPosition=pos;
			var tf:WOWVector=WOWVectorFunc.min(pos,prevPos);
			for(var i:int=0;i<verticesNum;i++)
			{
				WOWVectorFunc.plusEqual(vertices[i],tf);
			}
		};
		public function setAng(ang:WOWVector):void{
			prevAng=angles;
			angles=ang;
		
			var ag:WOWVector=WOWVectorFunc.min(ang,prevAng);
			rotateRB(new WOWVector(1,0,0),ag.x);
			rotateRB(new WOWVector(0,1,0),ag.y);
			rotateRB(new WOWVector(0,0,1),ag.z);
		
		};
		protected function computeOrientation(a:WOWVector,d:Number):void{
			rotation.w=cos(d/2);
			rotation.x=sin(d/2)*a.x;
			rotation.y=sin(d/2)*a.y;
			rotation.z=sin(d/2)*a.z;
			//D3DXQuaternionNormalize
			WOWQuaternionFunc.Normalize(rotation,rotation);
		};
		protected function rotateVector(v:WOWVector):void{
			var QV:WOWQuaternion=new WOWQuaternion(v.x,v.y,v.z,0);
			var invOrientation:WOWQuaternion=WOWQuaternionFunc.Inverse(rotation);
			var temp:WOWQuaternion=WOWQuaternionFunc.Multiply(invOrientation,QV);
			temp=WOWQuaternionFunc.Multiply(temp,rotation);
			v.x=temp.x;
			v.y=temp.y;
			v.z=temp.z;
		}
		public function rotateRB(ax:WOWVector, ang:Number):void{
			var temp:WOWVector=cgPosition;
			computeOrientation(ax,ang);
			rotateVector(temp);
		
		
			for(var i:int=0;i<verticesNum;i++)
			{
				rotateVector(vertices[i]);
				WOWVectorFunc.minEqual(vertices[i],temp);
				WOWVectorFunc.plusEqual(vertices[i],cgPosition);
			}
			for(var i:int=0;i<3;i++)
			{
				rotateVector(localAxis[i]);
				WOWVectorFunc.Normalize(localAxis[i],localAxis[i]);
			}
		
			var tempM:WOWMatrix=WOWMatrixFunc.RotationQuaternion(rotation);
			Orientation=WOWMatrixFunc.Multiply(Orientation,tempM);
		};
		public function Update():void{
			applyImpulse();

			if(groundCollisionInfo.size()>=3)
			{
				if(Math.abs(WOWVectorFunc.Length(linVelocity))<0.5)
				{
					linVelocity=new WOWVector(0,0,0);
				}
				if(abs(WOWVectorFunc.Length(rotVelocity))<0.5)
				{
					rotVelocity=new WOWVector(0,0,0);
				}
			}
		
			//dt c'est une variable global il me semble >_>
			var ds:WOWVector=WOWVectorFunc.plus(WOWVectorFunc.mult(linVelocity, dt) , WOWVectorFunc.mult(linAcceleration,(dt*dt*0.5)));
			WOWVectorFunc.plusEqual(cgPosition, ds);
			for(var i:int=0;i<verticesNum;i++)
			{
				WOWVectorFunc.plusEqual(vertices[i],ds);
			}
		
			WOWVectorFunc.plusEqual(linVelocity,WOWVectorFunc.mult(linAcceleration,dt);
		
		
			if(WOWVectorFunc.Length(rotVelocity)>0)
			{
				WOWVectorFunc.Normalize(axis,rotVelocity);
			}
			else
			{
				axis=new WOWVector(0,1,0);
			}
		
			
			angle=WOWVectorFunc.Length((WOWVectorFunc.plus(WOWVectorFunc.mult(rotVelocity , dt) , WOWVectorFunc.mult(rotAcceleration , (dt*dt*0.5)))));
			rotateRB(axis,angle);
		
			WOWVectorFunc.plusEqual(rotVelocity,WOWVectorFunc.mult(rotAcceleration,dt));
		
			WOWVectorFunc.multEqual(linVelocity,0.995);
			WOWVectorFunc.multEqual(rotVelocity,0.995);
		};
		public function groundCollisionResponse():void{
		
			var ImpulseNumerator:Number;
			var ImpulseDenominator:Number;
			var temp:WOWVector;
			var impulse:WOWVector;
		
			for(var i:int=0;i<groundCollisionInfo.size();i++)
			{
				AddForce(cgPosition,(-(WOWVectorFunc.mult(WOWVectorFunc.Dot(groundCollisionInfo[i].collisionNormal,forces),groundCollisionInfo[i].collisionNormal))));
		
				temp=WOWVectorFunc.cross(groundCollisionInfo[i].collisionPointR,groundCollisionInfo[i].collisionNormal);
				temp=WOWVectorFunc.ransformNormal(temp,InvInertia);
				temp=WOWVectorFunc.cross(temp,groundCollisionInfo[i].collisionPointR);
				ImpulseDenominator=(1/mass) + WOWVectorFunc.Dot(temp,groundCollisionInfo[i].collisionNormal);
		
				if(i==0 || (i>0 && groundCollisionInfo[i].collisionNormal!=groundCollisionInfo[i-1].collisionNormal))
				{
				
					ImpulseNumerator=-(1 + coeffOfRestitution) * WOWVectorFunc.Dot(groundCollisionInfo[i].collisionVelocity,groundCollisionInfo[i].collisionNormal);
					impulse=WOWVectorFunc.mult(groundCollisionInfo[i].collisionNormal,(ImpulseNumerator/ImpulseDenominator) );
		
				
					ImpulseNumerator=-coeffOfFriction*WOWVectorFunc.Dot(groundCollisionInfo[i].collisionVelocity,groundCollisionInfo[i].collisionTangent);
					WOWVectorFunc.plusEqual(impulse,ImpulseNumerator*groundCollisionInfo[i].collisionTangent);
				}
				else
				{
					impulse=new WOWVector(0,0,0);
				}
				
				AddImpulse(groundCollisionInfo[i].collisionPointR, impulse);
			}
		};
		
		public function updateVertices():void{
			var v:Array=new Array()
			//vb bitmap de test
			vb.lock();
			for(var i:int=0;i<verticesNum;i++)
			{
				v[i]=new CUSTOMVERTEX(vertices[i].x,vertices[i].y,vertices[i].z,0xffff0000);
			}
			vb.unlock();
			var pVertex2:Array=new Array(6)
				pVertex2[0]=CUSTOMVERTEX(cgPosition.x,cgPosition.y,cgPosition.z,0xffff0000);
				pVertex2[1]=new CUSTOMVERTEX(cgPosition.x+50*localAxis[0].x,cgPosition.y+50*localAxis[0].y,cgPosition.z+50*localAxis[0].z,0xffff0000);
				pVertex2[2]=new CUSTOMVERTEX(cgPosition.x,cgPosition.y,cgPosition.z,0xffff0000);
				pVertex2[3]=new CUSTOMVERTEX(cgPosition.x+50*localAxis[1].x,cgPosition.y+50*localAxis[1].y,cgPosition.z+50*localAxis[1].z,0xffff0000);
				pVertex2[4]=new CUSTOMVERTEX(cgPosition.x,cgPosition.y,cgPosition.z,0xffff0000);
				pVertex2[5]=new CUSTOMVERTEX(cgPosition.x+50*localAxis[2].x,cgPosition.y+50*localAxis[2].y,cgPosition.z+50*localAxis[2].z,0xffff0000);
			
				};
			
		
		public function checkParticleCollision(pt:Particle):void{};
		public function checkRBCollision(rb:RigidBody):void{};
		
	
		
	}
}