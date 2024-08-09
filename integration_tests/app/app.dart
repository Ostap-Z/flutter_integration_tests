import 'package:flutter_test/flutter_test.dart';

import '../pages/todo/to_do_page.dart';
import 'package:todo_app/main.dart' as todo_app;

class App {
  final WidgetTester tester;
  late final todoPage = ToDoPage(tester);

  App(this.tester);

  Future<void> launch() async {
    todo_app.main();
    await tester.pump(const Duration(seconds: 5));
  }
}
