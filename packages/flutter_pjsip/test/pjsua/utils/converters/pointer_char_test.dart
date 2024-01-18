import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('PjStrTExtension', () {
    test('fromDartString and toDartString', () {
      final pjStrT = PjStrTExtension.fromDartString('test');
      expect(pjStrT.toDartString(), 'test');
    });
  });
}
