import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../components/todo_tile_component.dart';
import '../abstract_page.dart';

final class TodoListPage extends AbstractPage {
  final TodoTileComponent todoTileComponent;

  TodoListPage(super.tester, this.todoTileComponent);

  final _addTodoIconLocator = find.byType(FloatingActionButton);
  final _todoTitleTextField = find.byKey(const ValueKey('todoTitleTextField'));
  final _todoDescriptionTextField =
      find.byKey(const ValueKey('todoDescriptionTextField'));
  final _createTodoIcon = find.byIcon(LineIcons.paperPlane);
  final _todoTag = find.byIcon(LineIcons.tag);

  Future<void> addTodo(String title, String description, {String? tag}) async {
    await tester.tap(_addTodoIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.enterText(_todoTitleTextField, title);
    await tester.enterText(_todoDescriptionTextField, title);

    if (tag != null) {
      await _setTag(tag);
    }

    await tester.tap(_createTodoIcon, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> _setTag(String tag) async {
    final tagText = find.text(tag);
    final tagRow = find.ancestor(of: tagText, matching: find.byType((Row)));
    final tagAddIcon =
        find.descendant(of: tagRow, matching: find.byIcon(LineIcons.plus));

    await tester.tap(_todoTag);
    await tester.pumpAndSettle();
    await tester.tap(tagAddIcon, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
}
