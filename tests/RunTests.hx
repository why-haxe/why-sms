package ;

import why.sms.*;
import why.Sms;
import tink.unit.*;
import tink.testrunner.*;

using tink.CoreApi;

class RunTests {

  static function main() {
    Runner.run(TestBatch.make([
      new PhoneTest(),
    ])).handle(Runner.exit);
  }
  
}

@:asserts
class PhoneTest {
  public function new() {}
  
  public function parse() {
    asserts.assert(Phone.parse('+85212345'));
    asserts.assert(!Phone.parse('+11111').isSuccess());
    return asserts.done();
  }
}