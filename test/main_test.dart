import 'package:dart_inject/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_inject/reflector.dart';
import 'main_test.reflectable.dart';

@reflector
class TestService {
  final String name;
  TestService(this.name);
}

void main() {
  initializeReflectable();
  test('reflect and injector', () {
    final injector = Injector();
    final me1 = injector.getSingleton<TestService>(arguments: ['123']);
    final me2 = injector.getSingleton<TestService>(arguments: ['234']);
    expect(me1.name == me2.name, true);
  });
}
