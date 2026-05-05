import 'package:flutter_test/flutter_test.dart';
import 'package:spata_guard/main.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SpataGuardApp());

    // Basic app initialization test
    expect(find.byType(SpataGuardApp), findsOneWidget);
  });
}
