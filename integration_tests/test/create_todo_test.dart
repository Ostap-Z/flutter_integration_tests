import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../constants/todo_tile.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TODO creation', () {
    const String title = 'Test title';
    const String description = 'Test Description';
    const String descriptionEmpty = '';
    const String date = '09/30/2024';
    const String time = '20:15';

    final List<Category> categories = [
      Category.urgent,
      Category.important,
      Category.notImportant,
      Category.custom,
    ];

    testWidgets('Verify todo could be created with a title and description',
        (WidgetTester tester) async {
      final App app = App(tester);

      await app.launch();
      await app.todoListPage.addTodo(title, description);
      final bool hasCorrectTitle =
          await app.todoListPage.todoTileComponent.hasTitle(title);

      expect(hasCorrectTitle, true, reason: 'Todo is not created');
    }, tags: ['create_todo', 'smoke']);

    testWidgets('Verify todo could be created only with a title',
        (WidgetTester tester) async {
      final App app = App(tester);

      await app.launch();
      await app.todoListPage.addTodo(title, descriptionEmpty);
      final bool hasCorrectTitle =
          await app.todoListPage.todoTileComponent.hasTitle(title);

      expect(hasCorrectTitle, true, reason: 'Todo is not created');
    }, tags: ['create_todo', 'smoke']);

    for (final Category category in categories) {
      testWidgets('Verify the ${category.value} todo could be created',
          (WidgetTester tester) async {
        final App app = App(tester);

        await app.launch();
        await app.todoListPage
            .addTodo(title, description, category: category.value);
        final bool hasCorrectCategory = await app.todoListPage.todoTileComponent
            .hasCategory(title, category.value);

        expect(hasCorrectCategory, true, reason: 'Invalid todo tag');
      }, tags: ['create_todo', 'smoke']);
    }

    testWidgets('Verify a todo could be created with a specified date',
        (WidgetTester tester) async {
      final App app = App(tester);

      await app.launch();
      await app.todoListPage.addTodo(title, description, date: date);
      final bool hasCorrectDate =
          await app.todoListPage.todoTileComponent.hasDate(title, 'Sep 30');

      expect(hasCorrectDate, true, reason: 'Invalid todo date');
    }, tags: ['create_todo', 'smoke']);

    testWidgets('Verify a todo could be created with a specified time',
        (WidgetTester tester) async {
      final App app = App(tester);

      await app.launch();
      await app.todoListPage.addTodo(title, description, time: time);
      final bool hasCorrectTime =
          await app.todoListPage.todoTileComponent.hasTime(title, time);

      expect(hasCorrectTime, true, reason: 'Invalid todo time');
    }, tags: ['create_todo', 'smoke']);
  });
}
