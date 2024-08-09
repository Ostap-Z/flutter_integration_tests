import 'package:flutter_test/flutter_test.dart';

abstract class AbstractPage {
  late WidgetTester tester;

  AbstractPage(this.tester);
}
