package why;

using tink.CoreApi;

interface Sms {
	function send(to:Phone, body:String):Promise<Noise>;
}

abstract Phone(Pair<Int, String>) {
	public var code(get, never):Int;
	public var number(get, never):String;
	public inline function new(code, number) this = new Pair(code, number);
	inline function get_code() return this.a;
	inline function get_number() return this.b;
	@:to public inline function toString() return '+$code$number';
}