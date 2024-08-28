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

    await tester.tap(uncompletedIcon);
    await tester.pumpAndSettle();
  }

  Future<void> uncomplete(String title) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder completedIcon =
        find.descendant(of: row, matching: find.byIcon(LineIcons.checkCircle));

    await tester.tap(completedIcon);
    await tester.pumpAndSettle();
  }

  Future<void> restore(String title) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder restore = find.descendant(
        of: row, matching: find.byKey(const ValueKey('restoreTodo')));

    await tester.tap(restore);
    await tester.pumpAndSettle();
  }

  Future<int> getTodoAmount() async {
    return find.byType(TodoTile).evaluate().length;
  }

  Future<bool> hasTitle(String title) async {
    final Finder todo = _getTodoByTitle(title);
    return tester.any(todo);
  }

  Future<bool> hasCategory(String title, String category) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder tagText =
        find.descendant(of: row, matching: find.text(category));

    return tester.any(tagText);
  }

  Future<bool> hasStatus(String title, Status status) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder statusIcon = find.descendant(
        of: row,
        matching: status == Status.completed
            ? find.byIcon(LineIcons.checkCircle)
            : find.byIcon(LineIcons.circle));

    return tester.any(statusIcon);
  }

  Future<bool> hasDate(String title, String date) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder dateText = find.descendant(of: row, matching: find.text(date));

    return tester.any(dateText);
  }

  Future<bool> hasTime(String title, String time) async {
    final Finder todo = _getTodoByTitle(title);
    final Finder row = find.ancestor(of: todo, matching: find.byType(Row));
    final Finder dateText = find.descendant(of: row, matching: find.text(time));

    return tester.any(dateText);
  }

  Finder _getTodoByTitle(String title) {
    return find.descendant(of: rootFinder, matching: find.text(title));
  }
}
