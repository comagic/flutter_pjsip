import 'dart:ffi';

import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('PjStrTExtension', () {
    test('fromDartString and toDartString', () {
      final pjStrT = PjStrTExtension.fromDartString('test');
      expect(pjStrT.toDartString(), 'test');
      pjStrT.free();
    });

    test('fromDartString and toDartString with empty string', () {
      final pjStrT = PjStrTExtension.fromDartString('');
      expect(pjStrT.toDartString(), '');
      pjStrT.free();
    });

    test('check slen with one-byte utf8', () {
      final pjStrT = PjStrTExtension.fromDartString('test');
      expect(pjStrT.slen, 4);
      expect(pjStrT.ptr.elementAt(0).value, 'test'.codeUnitAt(0));
      expect(pjStrT.ptr.elementAt(0).value, 0x74);
      expect(pjStrT.ptr.elementAt(1).value, 0x65);
      expect(pjStrT.ptr.elementAt(2).value, 0x73);
      expect(pjStrT.ptr.elementAt(3).value, 0x74);
      pjStrT.free();
    });

    test('check slen with mixed-length utf8', () {
      final pjStrT = PjStrTExtension.fromDartString('testɠ');
      expect(pjStrT.slen, 6);
      pjStrT.free();
    });

    test('check slen with emty string', () {
      final pjStrT = PjStrTExtension.fromDartString('');
      expect(pjStrT.slen, 0);
      pjStrT.free();
    });
  });
}
