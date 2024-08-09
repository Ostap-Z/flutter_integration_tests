import 'package:flutter_test/flutter_test.dart';

import '../components/todo_tile_component.dart';
import '../pages/todo/to_do_page.dart';
import 'package:todo_app/main.dart' as todo_app;

final class App {
  final WidgetTester tester;
  late final TodoTileComponent _todoTileComponent = TodoTileComponent(tester);
  late final TodoListPage todoListPage =
      TodoListPage(tester, _todoTileComponent);

  App(this.tester);

  Future<void> launch() async {
    todo_app.main();
    await tester.pump(const Duration(seconds: 5));
  }
}
