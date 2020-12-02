package why.sms;

#if !hxnodejs_twilio #error "Requires the hxnodejs-twilio library" #end

import why.Sms;
import twilio.Twilio as Native;
import twilio.lib.rest.api.v2010.account.message.MessageListInstanceCreateOptions;

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
		var opt:MessageListInstanceCreateOptions = {to: to, body: body}
		
		switch from {
			case Phone(phone): opt.from = phone;
			case SenderId(id): opt.from = id;
			case MessagingService(id): opt.messagingServiceSid = id;
		}
		
		return Promise.ofJsPromise(twilio.messages.create(opt));
	}
}

private enum From {
	Phone(phone:Phone);
	SenderId(id:String);
	MessagingService(id:String);
}
#end