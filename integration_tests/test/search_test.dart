import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TODO search', () {
    testWidgets('Verify todo could be found by title',
        (WidgetTester tester) async {
      final App app = App(tester);
      const String title = 'Test title';
      const String description = 'Test Description';

      await app.launch();
      await app.todoListPage.addTodo(title, description);
      await app.todoListPage.searchComponent.search(title);
      bool isPresentInSearchResults =
          await app.searchResultsPage.todoTileComponent.hasTitle(title);
      int todoAmount =
          await app.searchResultsPage.todoTileComponent.getTodoAmount();

      expect(isPresentInSearchResults, true,
          reason: 'Todo is not found by title');
      expect(todoAmount, 1, reason: 'Found more than one todo');
    }, tags: ['search_todo', 'regression']);

    testWidgets('Verify error message is correct when todo is not found',
        (WidgetTester tester) async {
      final App app = App(tester);
      const String title = 'Invalid title';
      const String message = '0 items found';

      await app.launch();
      await app.todoListPage.searchComponent.search(title);
      bool hasCorrectErrorMessage =
          await app.searchResultsPage.hasText(message);

      expect(hasCorrectErrorMessage, true,
          reason: 'Error message is not shown or incorrect');
    }, tags: ['search_todo', 'regression']);
  });
}
