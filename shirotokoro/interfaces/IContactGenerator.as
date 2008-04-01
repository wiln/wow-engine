package shirotokoro.interfaces
{

	include Contact;

	//namespace shirotokoro
	public interface IContactGenerator
	{
		
		/*public*/
		
		 public function addContact(_contact:Contact, _limit:int):int;
	}
}