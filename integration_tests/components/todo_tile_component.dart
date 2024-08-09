import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/components/todo_tile.dart';
import 'abstract_component.dart';

class TodoTileComponent extends AbstractComponent {
  TodoTileComponent(super.tester);

  @override
  final Finder rootFinder = find.byType(TodoTile);

  Future<bool> hasTitle(String title) async {
    final todo = find.descendant(of: rootFinder, matching: find.text(title));
    return tester.any(todo);
  }

  Future<bool> hasTag(String title, String tag) async {
    final todo = find.descendant(of: rootFinder, matching: find.text(title));
    final row = find.ancestor(of: todo, matching: find.byType(Row));
    final tagText = find.descendant(of: row, matching: find.text(tag));

    return tester.any(tagText);
  }
}
