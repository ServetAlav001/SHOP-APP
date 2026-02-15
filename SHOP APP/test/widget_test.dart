import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/main.dart';

void main() {
  testWidgets('SHOP APP başlığı görünür', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('SHOP APP'), findsOneWidget);
  });
}
