import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icons.dart';

import '../abstract_page.dart';

final class CategoryPage extends AbstractPage {
  CategoryPage(super.tester);

  Future<void> setCategory(String category) async {
    final tagText = find.text(category);
    final tagRow = find.ancestor(of: tagText, matching: find.byType((Row)));
    final tagAddIcon =
        find.descendant(of: tagRow, matching: find.byIcon(LineIcons.plus));

    await tester.tap(tagAddIcon, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
}
