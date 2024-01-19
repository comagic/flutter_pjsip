import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('PjBoolTExtension', () {
    test('fromDartBool and toDartBool with true', () {
      final pjBoolT = PjBoolTExtension.fromDartBool(true);
      expect(pjBoolT.toDartBool(), true);
    });

    test('fromDartBool and toDartBool with false', () {
      final pjBoolT = PjBoolTExtension.fromDartBool(false);
      expect(pjBoolT.toDartBool(), false);
    });

    test('check value with true', () {
      final pjBoolT = PjBoolTExtension.fromDartBool(true);
      expect(pjBoolT, 1);
    });

    test('check value with false', () {
      final pjBoolT = PjBoolTExtension.fromDartBool(false);
      expect(pjBoolT, 0);
    });
  });
}
