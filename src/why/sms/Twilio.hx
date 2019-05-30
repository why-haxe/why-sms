package why.sms;

import why.Sms;

using tink.CoreApi;

#if nodejs
class Twilio implements Sms {
	var twilio:Native;
	var from:From;
	
	public function new(opt) {
		twilio = new Native(opt.sid, opt.token);
		from = opt.from;
	}
	
	public function send(to:Phone, body:String):Promise<Noise> {
		var opt:MessageCreateOptions = {to: to, body: body}
		
		switch from {
			case Phone(phone): opt.from = phone;
			case SenderId(id): opt.from = id;
			case MessagingService(id): opt.messagingServiceSid = id;
		}
		
		return Promise.ofJsPromise(twilio.messages.create(opt));
	}
}

@:jsRequire('twilio')
private extern class Native {
	var messages:Messages;
	function new(sid:String, token:String);
}
private extern class Messages {
	function create(opt:MessageCreateOptions):js.Promise<Message>;
}

private typedef MessageCreateOptions =	{
	body:String, 
	to:String,
	?from:String,
	?messagingServiceSid:String,
}

private extern class Message {
	var sid:String;
}

private enum From {
	Phone(phone:Phone);
	SenderId(id:String);
	MessagingService(id:String);
}
#end