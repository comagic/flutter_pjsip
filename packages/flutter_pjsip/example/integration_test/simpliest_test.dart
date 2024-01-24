import 'package:flutter_pjsip/flutter_pjsip.dart' as pjsip;
import 'package:flutter_pjsip_example/main_integration_test.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Simplest lib loading and executing', () {
    testWidgets('Run app and call sum()', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(
        pjsip.Pjsua.sum(4, 6),
        10,
      );
    });
  });
}
