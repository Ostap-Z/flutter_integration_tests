import 'package:flutter_test/flutter_test.dart';

abstract base class AbstractPage {
  late WidgetTester tester;

  AbstractPage(this.tester);

  Future<bool> hasText(String text) async {
    return tester.any(find.text(text));
  }
}
