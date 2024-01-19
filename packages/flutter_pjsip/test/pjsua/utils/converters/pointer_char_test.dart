import 'dart:ffi';

import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('PjStrTExtension', () {
    test('fromDartString and toDartString', () {
      final pjStrT = PCExtension.fromDartString('test');
      expect(pjStrT.toDartString(), 'test');
    });

    test('fromDartString and toDartString with empty string', () {
      final pjStrT = PCExtension.fromDartString('');
      expect(pjStrT.toDartString(), '');
    });

    test('allocate and free', () {
      final pjStrT = PCExtension.allocate(10);
      expect(pjStrT.elementAt(0).value, 0);
      expect(pjStrT.elementAt(1).value, 0);
      expect(pjStrT.elementAt(2).value, 0);
      expect(pjStrT.elementAt(3).value, 0);
      expect(pjStrT.elementAt(4).value, 0);
      expect(pjStrT.elementAt(5).value, 0);
      expect(pjStrT.elementAt(6).value, 0);
      expect(pjStrT.elementAt(7).value, 0);
      expect(pjStrT.elementAt(8).value, 0);
      expect(pjStrT.elementAt(9).value, 0);
      expect(pjStrT.elementAt(10).value, 0);
      expect(pjStrT.elementAt(11).value, 0);
      pjStrT.free();
    });
  });
}
