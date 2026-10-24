import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/main.dart';

void main() {
  testWidgets('Welcome screen renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('CINEVERSE'), findsWidgets);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
