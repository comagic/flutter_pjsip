import 'package:flutter_pjsip_example/main.dart' as app;

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('just run the app', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(
        find.textContaining('This calls a native function'),
        findsOneWidget,
      );
    });
  });
}
