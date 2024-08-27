import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icons.dart';

import '../abstract_page.dart';

final class CategoryPage extends AbstractPage {
  CategoryPage(super.tester);

  final Finder _tagIcon = find.byIcon(LineIcons.tag);
  final Finder _createIcon = find.byType(FloatingActionButton);
  final Finder _categoryInput = find.byKey(const ValueKey('categoryInput'));
  final Finder _addIcon = find.byKey(const ValueKey('addCategoryIcon'));

  Future<void> clickCategoryIcon() async {
    await tester.tap(_tagIcon);
    await tester.pumpAndSettle();
  }

  Future<void> set(String category) async {
    final tagText = find.text(category);
    final tagRow = find.ancestor(of: tagText, matching: find.byType((Row)));
    final tagAddIcon =
        find.descendant(of: tagRow, matching: find.byIcon(LineIcons.plus));

    await tester.tap(tagAddIcon);
    await tester.pumpAndSettle();
  }

  Future<void> create(String category) async {
    await tester.tap(_createIcon);
    await tester.pumpAndSettle();
    await tester.enterText(_categoryInput, category);
    await tester.tap(_addIcon);
    await tester.pumpAndSettle();
  }
}
