package why.sms;

import js.aws.sns.SNS;
import why.Sms;

using tink.CoreApi;

#if nodejs
class AwsSns implements Sms {
	
	var sns:SNS;
	
	public function new(?opt) {
		sns = new SNS(opt);
	}
	
	public function send(to:Phone, body:String):Promise<Noise> {
		return Future.async(function(cb) sns.publish({
			PhoneNumber: (to:String),
			Message: body,
		}, function(err, _) cb(err == null ? Success(Noise) : Failure(Error.ofJsError(err)))));
	}
}
#end
