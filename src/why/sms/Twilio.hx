package why.sms;

import why.Sms;

using tink.CoreApi;

#if nodejs
class Twilio implements Sms {
	var twilio:Native;
	var from:Phone;
	
	public function new(sid, token, from) {
		this.twilio = new Native(sid, token);
		this.from = from;
	}
	
	public function send(to:Phone, body:String):Promise<Noise> {
		return Promise.ofJsPromise(twilio.messages.create({
			from: from,
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
#end