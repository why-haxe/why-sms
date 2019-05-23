package why.sms;

import haxe.io.Bytes;
import haxe.crypto.Base64;
import tink.http.Header;
import tink.http.Fetch.*;
import why.Sms;

using tink.CoreApi;

class Sinch implements Sms {
	var auth:HeaderField;
	var contentType:HeaderField;
	
	public function new(key, secret) {
		auth = new HeaderField(AUTHORIZATION, 'Basic ${Base64.encode(Bytes.ofString('$key:$secret')).toString()}');
		contentType = new HeaderField(CONTENT_TYPE, 'application/json');
	}
	
	public function send(to:Phone, body:String):Promise<Noise> {
		var contentLength = new HeaderField(CONTENT_LENGTH, Std.string(body.length));
		return fetch('https://messagingapi.sinch.com/v1/sms/$to', {
			method: POST,
			headers: [auth, contentLength, contentType],
			body: body,
		}).all();
	}
}