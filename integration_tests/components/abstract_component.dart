import 'package:flutter_test/flutter_test.dart';

abstract base class AbstractComponent {
  late WidgetTester tester;

  AbstractComponent(this.tester);

  Finder get rootFinder;
}
