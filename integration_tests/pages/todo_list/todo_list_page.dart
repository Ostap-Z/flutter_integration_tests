import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../components/calendar.dart';
import '../../components/search.dart';
import '../../components/tab.dart';
import '../../components/todo_tile_component.dart';
import '../../constants/todo_tile.dart';
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

  Future<void> addTodo(String title, String description,
      {String? category, String? date}) async {
    await tester.tap(_addTodoIconLocator);
    await tester.pumpAndSettle();
    await tester.enterText(_todoTitleTextField, title);
    await tester.enterText(_todoDescriptionTextField, description);

    if (category != null) {
      final CategoryPage categoryPage = CategoryPage(tester);
      await categoryPage.clickCategoryIcon();

      if (category != Category.custom.value) {
        await categoryPage.set(category);
      } else {
        await categoryPage.create(category);
        await categoryPage.set(category);
      }
    }

    if (date != null) {
      final CalendarComponent calendarComponent = CalendarComponent(tester);
      await calendarComponent.clickCalendarIcon();
      await calendarComponent.set(date);
    }

    await tester.tap(_createTodoIcon);
    await tester.pumpAndSettle();
  }

  Future<void> openTodoDetails(String title) async {
    final todo = find.descendant(
        of: todoTileComponent.rootFinder, matching: find.text(title));
    await tester.tap(todo);
    await tester.pumpAndSettle();
  }
}
