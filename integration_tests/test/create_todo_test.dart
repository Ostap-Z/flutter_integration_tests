import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../constants/todo_tile.dart';

final List<Category> categories = [
  Category.urgent,
  Category.important,
  Category.notImportant,
  Category.custom,
];

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TODO creation', () {
    testWidgets('Verify todo could be created with a title and description',
        (WidgetTester tester) async {
      final App app = App(tester);
      const String title = 'Test title';
      const String description = 'Test Description';

      await app.launch();
      await app.todoListPage.addTodo(title, description);
      final bool isTodoCreated =
          await app.todoListPage.todoTileComponent.hasTitle(title);

      expect(isTodoCreated, true, reason: 'Todo is not created');
    }, tags: ['create_todo', 'smoke']);

    testWidgets('Verify todo could be created only with a title',
        (WidgetTester tester) async {
      final App app = App(tester);
      const String title = 'Test title empty description';
      const String description = '';

      await app.launch();
      await app.todoListPage.addTodo(title, description);
      final bool isTodoCreated =
          await app.todoListPage.todoTileComponent.hasTitle(title);

      expect(isTodoCreated, true, reason: 'Todo is not created');
    }, tags: ['create_todo', 'smoke']);

    for (final Category category in categories) {
      testWidgets('Verify the ${category.value} todo could be created',
          (WidgetTester tester) async {
        final App app = App(tester);
        const String title = 'Custom todo';
        const String description = 'Test description';

        await app.launch();
        await app.todoListPage
            .addTodo(title, description, category: category.value);
        final bool isTodoCreated =
            await app.todoListPage.todoTileComponent.hasTitle(title);
        final bool isTodoHasText = await app.todoListPage.todoTileComponent
            .hasTag(title, category.value);

        expect(isTodoCreated, true, reason: 'Todo is not created');
        expect(isTodoHasText, true, reason: 'Invalid todo tag');
      }, tags: ['create_todo', 'smoke']);
    }
  });
}
