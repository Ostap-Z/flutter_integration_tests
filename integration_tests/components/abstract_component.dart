import 'package:flutter_test/flutter_test.dart';

abstract class AbstractComponent {
  late WidgetTester tester;

  AbstractComponent(this.tester);

  Finder get rootFinder;
}
