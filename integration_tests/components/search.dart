import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'abstract_component.dart';

final class SearchComponent extends AbstractComponent {
  SearchComponent(super.tester);

  @override
  final Finder rootFinder = find.byKey(const ValueKey('searchBar'));

  late final Finder _searchInput = find.descendant(
      of: rootFinder, matching: find.byKey(const ValueKey('searchInput')));

  Future<void> search(String query) async {
    await tester.enterText(_searchInput, query);
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
  }
}
