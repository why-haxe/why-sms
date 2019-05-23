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
		return Promise.ofJsPromise(twilio.messages.create({
			from: switch from {
				case Phone(phone): phone;
				case SenderId(id): id;
			},
			to: to,
			body: body,
		}));
	}
}

@:jsRequire('twilio')
private extern class Native {
	var messages:Messages;
	function new(sid:String, token:String);
}
private extern class Messages {
	function create(opt:{body:String, from:String, to:String}):js.Promise<Message>;
}

private extern class Message {
	var sid:String;
}

private enum From {
	Phone(phone:Phone);
	SenderId(id:String);
}
#end