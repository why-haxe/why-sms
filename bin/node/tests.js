// Generated by Haxe 4.0.0-rc.2+032d959
(function ($global) { "use strict";
var HxOverrides = function() { };
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var RunTests = function() { };
RunTests.main = function() {
};
RunTests.main();
})({});