import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../components/search.dart';
import '../../components/tab.dart';
import '../../components/todo_tile_component.dart';
import '../abstract_page.dart';
import '../category/category_page.dart';

final class TodoListPage extends AbstractPage {
  final TodoTileComponent todoTileComponent;
  final TabComponent tabComponent;
  final SearchComponent searchComponent;

  TodoListPage(super.tester, this.todoTileComponent, this.tabComponent,
      this.searchComponent);

  final Finder _addTodoIconLocator = find.byType(FloatingActionButton);
  final Finder _todoTitleTextField =
      find.byKey(const ValueKey('todoTitleTextField'));
  final Finder _todoDescriptionTextField =
      find.byKey(const ValueKey('todoDescriptionTextField'));
  final Finder _createTodoIcon = find.byIcon(LineIcons.paperPlane);
  final Finder _todoTag = find.byIcon(LineIcons.tag);

  Future<void> addTodo(String title, String description,
      {String? category}) async {
    await tester.tap(_addTodoIconLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.enterText(_todoTitleTextField, title);
    await tester.enterText(_todoDescriptionTextField, description);

    if (category != null) {
      await tester.tap(_todoTag);
      await tester.pumpAndSettle();
      await CategoryPage(tester).setCategory(category);
    }

    await tester.tap(_createTodoIcon, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> openTodoDetails(String title) async {
    final todo = find.descendant(
        of: todoTileComponent.rootFinder, matching: find.text(title));
    await tester.tap(todo, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
}
