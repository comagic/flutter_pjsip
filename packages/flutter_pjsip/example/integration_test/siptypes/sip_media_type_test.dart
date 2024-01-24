import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffipkg;
import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:flutter_pjsip_example/main_integration_test.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    app.main();
  });

  group('SipMediaType', () {
    testWidgets('should create a SipMediaType instance',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();

      const sipMediaType = SipMediaType(type: 'myType', subtype: 'mySubtype');
      expect(sipMediaType.type, 'myType');
      expect(sipMediaType.subtype, 'mySubtype');
    });

    testWidgets('should create a SipMediaType instance from pjsip structure',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();

      final pjMt = ffipkg.calloc.allocate<pjsip_media_type>(
        ffi.sizeOf<pjsip_media_type>(),
      );

      pjMt.ref.type = PjStrTExtension.fromDartString('myType').ref;
      pjMt.ref.subtype = PjStrTExtension.fromDartString('mySubtype').ref;

      final sipMediaType = SipMediaType.fromPj(pjMt.ref);
      expect(sipMediaType.type, 'myType');
      expect(sipMediaType.subtype, 'mySubtype');
    });
  });
}
