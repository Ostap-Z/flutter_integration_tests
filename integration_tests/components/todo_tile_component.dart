import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icons.dart';

import 'package:todo_app/components/todo_tile.dart';
import '../constants/todo_tile.dart';
import 'abstract_component.dart';

final class TodoTileComponent extends AbstractComponent {
  TodoTileComponent(super.tester);

  @override
  final Finder rootFinder = find.byType(TodoTile);

  Future<void> complete(String title) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder uncompletedIcon =
        find.descendant(of: row, matching: find.byIcon(LineIcons.circle));

    await tester.tap(uncompletedIcon, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<bool> hasTitle(String title) async {
    final Finder todo = _getTodoByTitle(title);
    return tester.any(todo);
  }

  Future<bool> hasTag(String title, String tag) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder tagText = find.descendant(of: row, matching: find.text(tag));

    return tester.any(tagText);
  }

  Future<bool> hasStatus(String title, Status status) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder iconWidget = find.descendant(
        of: row,
        matching: status == Status.completed
            ? find.byIcon(LineIcons.checkCircle)
            : find.byIcon(LineIcons.circle));

    return tester.any(iconWidget);
  }

  Finder _getTodoByTitle(String title) {
    return find.descendant(of: rootFinder, matching: find.text(title));
  }
}
