package com.adams.scrum.controller
{
	import com.adams.scrum.models.vo.CurrentInstance;
	import com.adams.scrum.service.NativeMessenger;
	 
	import mx.collections.ArrayCollection;
	
	
	public class LoadConfigCommand
	{ 		 
		[Inject]
		public var service:ServiceController; 
		
		[PostConstruct]
		public function execute():void
		{			 
			service.serverLocation = 'http://localhost:8080/SwizDAO/';
			service.assignChannelSets();
			if(!service.consumer.subscribed)service.consumer.subscribe();
		}
	}
}