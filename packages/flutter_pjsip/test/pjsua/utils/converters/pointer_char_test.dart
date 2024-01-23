import 'dart:ffi' as ffi;

import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('pcExtension', () {
    test('fromDartString and toDartString', () {
      final pc = PCExtension.fromDartString('test');
      expect(pc.toDartString(), 'test');
      pc.free();
    });

    test('fromDartString and toDartString with empty string', () {
      final pc = PCExtension.fromDartString('');
      expect(pc.toDartString(), '');
      pc.free();
    });

    test('allocate and free', () {
      final pc = PCExtension.allocate(10);
      expect(pc.elementAt(0).value, 0);
      expect(pc.elementAt(1).value, 0);
      expect(pc.elementAt(2).value, 0);
      expect(pc.elementAt(3).value, 0);
      expect(pc.elementAt(4).value, 0);
      expect(pc.elementAt(5).value, 0);
      expect(pc.elementAt(6).value, 0);
      expect(pc.elementAt(7).value, 0);
      expect(pc.elementAt(8).value, 0);
      expect(pc.elementAt(9).value, 0);
      expect(pc.elementAt(10).value, 0);
      expect(pc.elementAt(11).value, 0);
      pc.free();
    });
  });
}
