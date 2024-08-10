import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import '../constants/tabs.dart' as tabs;
import 'abstract_component.dart';

final class TabComponent extends AbstractComponent {
  TabComponent(super.tester);

  @override
  final Finder rootFinder = find.byType(TabBar);

  Future<void> openTab(tabs.Tab tab) async {
    final tabFinder =
        find.descendant(of: rootFinder, matching: find.text(tab.value));
    await tester.tap(tabFinder, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
}
