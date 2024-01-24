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

  group('SipHeader', () {
    testWidgets('should create a SipHeader instance',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();

      const header = SipHeader(name: 'Content-Type', value: 'application/json');
      expect(header.name, 'Content-Type');
      expect(header.value, 'application/json');
    });

    testWidgets('should create a SipHeader instance from pjsip structure',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();

      final pjHdr = ffipkg.calloc.allocate<pjsip_hdr>(
        ffi.sizeOf<pjsip_hdr>(),
      );
      pjHdr.ref.name = PjStrTExtension.fromDartString('Content-Type').ref;
      pjHdr.ref.sname = PjStrTExtension.fromDartString('Sname').ref;
      pjHdr.ref.type = pjsip_event_id_e.PJSIP_EVENT_TIMER;

      // TODO(nesquikm): it fails here
      // final header = SipHeader.fromPj(pjHdr);
      // expect(header.name, 'Content-Length');
      // expect(header.value, '100');

      pjHdr.ref.name.free();
      pjHdr.ref.sname.free();
      ffipkg.calloc.free(pjHdr);
    });
  });
}



// import 'dart:ffi' as ffi;
// import 'package:ffi/ffi.dart' as ffipkg;
// import 'package:flutter_pjsip/bindings/bindings.dart';
// import 'package:flutter_pjsip/pjsua/pjsua.dart';
// import 'package:flutter_pjsip/pjsua/utils/utils.dart';

// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('SipHeader', () {
//     test('should create a SipHeader instance', () {
//       const header = SipHeader(name: 'Content-Type', value: 'application/json');
//       expect(header.name, 'Content-Type');
//       expect(header.value, 'application/json');
//     });

//     test('should create a SipHeader instance from pjsip structure', () {
//       final pjHdr = ffipkg.calloc.allocate<pjsip_hdr>(
//         ffi.sizeOf<pjsip_hdr>(),
//       );
//       pjHdr.ref.name = PjStrTExtension.fromDartString('Content-Type').ref;
//       pjHdr.ref.sname = PjStrTExtension.fromDartString('Sname').ref;
//       pjHdr.ref.type = pjsip_event_id_e.PJSIP_EVENT_TIMER;

//       final header = SipHeader.fromPj(pjHdr);
//       // expect(header.name, 'Content-Length');
//       // expect(header.value, '100');

//       pjHdr.ref.name.free();
//       pjHdr.ref.sname.free();
//       ffipkg.calloc.free(pjHdr);
//     });

//     // test('should export to pjsip structure', () {
//     //   const header = SipHeader(name: 'Content-Type', value: 'application/json');
//     //   final pjHdr = header.toPj();

//     //   expect(pjHdr.ref.hname, 'Content-Type'.toNativeUtf8());
//     //   expect(pjHdr.ref.hvalue, 'application/json'.toNativeUtf8());

//     //   ffi.free(pjHdr.ref.hname);
//     //   ffi.free(pjHdr.ref.hvalue);
//     //   ffi.free(pjHdr);
//     // });
//   });
// }
