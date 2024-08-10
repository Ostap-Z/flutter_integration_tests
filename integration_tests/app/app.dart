import 'package:flutter_test/flutter_test.dart';

import '../components/modals/delete_todo_modal.dart';
import '../components/tab.dart';
import '../components/todo_tile_component.dart';
import '../pages/todo_deleted/todo_deleted_page.dart';
import '../pages/todo_details/todo_details_page.dart';
import '../pages/todo_list/todo_list_page.dart';
import 'package:todo_app/main.dart' as todo_app;

final class App {
  final WidgetTester _tester;

  late final TodoTileComponent _todoTileComponent = TodoTileComponent(_tester);
  late final DeleteTodoModalComponent _deleteTodoModalComponent =
      DeleteTodoModalComponent(_tester);
  late final TabComponent _tabComponent = TabComponent(_tester);

  late final TodoListPage todoListPage =
      TodoListPage(_tester, _todoTileComponent, _tabComponent);
  late final TodoDetailsPage todoDetailsPage =
      TodoDetailsPage(_tester, _deleteTodoModalComponent);
  late final TodoDeletedPage todoDeletedPage =
      TodoDeletedPage(_tester, _todoTileComponent, _tabComponent);

  App(this._tester);

  Future<void> launch() async {
    todo_app.main();
    await _tester.pump(const Duration(seconds: 5));
  }
}
