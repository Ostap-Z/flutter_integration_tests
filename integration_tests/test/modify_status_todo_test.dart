import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../constants/tabs.dart' as tabs;
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

  group('TODO modify status', () {
    for (final Category category in categories) {
      testWidgets('Verify the ${category.value} todo could be completed',
          (WidgetTester tester) async {
        final App app = App(tester);
        const String title = 'Test title';
        const String description = 'Test Description';

        await app.launch();
        await app.todoListPage
            .addTodo(title, description, category: category.value);
        await app.todoListPage.todoTileComponent.complete(title);
        await app.todoListPage.tabComponent.openTab(tabs.Tab.completed);
        final bool isPresentInDeletedList =
            await app.todoCompletedPage.todoTileComponent.hasTitle(title);
        final bool isMarkedCompleted = await app
            .todoCompletedPage.todoTileComponent
            .hasStatus(title, Status.completed);

        expect(isPresentInDeletedList, true, reason: 'Todo is not completed');
        expect(isMarkedCompleted, true, reason: 'Todo is not checked');
      }, tags: ['complete_todo', 'smoke']);

      testWidgets('Verify the ${category.value} todo could be uncompleted',
          (WidgetTester tester) async {
        final App app = App(tester);
        const String title = 'Test title';
        const String description = 'Test Description';

        await app.launch();
        await app.todoListPage
            .addTodo(title, description, category: category.value);
        await app.todoListPage.todoTileComponent.complete(title);
        await app.todoListPage.tabComponent.openTab(tabs.Tab.completed);
        await app.todoCompletedPage.todoTileComponent.uncomplete(title);
        await app.todoListPage.tabComponent.openTab(tabs.Tab.todo);
        final bool isPresentInTodoList =
            await app.todoListPage.todoTileComponent.hasTitle(title);
        expect(isPresentInTodoList, true, reason: 'Todo is not uncompleted');
      }, tags: ['uncomplete_todo', 'smoke']);

      testWidgets('Verify the ${category.value} todo could be deleted',
          (WidgetTester tester) async {
        final App app = App(tester);
        const String title = 'Test title';
        const String description = 'Test Description';

        await app.launch();
        await app.todoListPage
            .addTodo(title, description, category: category.value);
        await app.todoListPage.openTodoDetails(title);
        await app.todoDetailsPage.deleteTodo();
        await app.todoDetailsPage.deleteTodoModalComponent.confirm();
        await app.todoListPage.tabComponent.openTab(tabs.Tab.deleted);
        final bool isPresentInDeletedList =
            await app.todoDeletedPage.todoTileComponent.hasTitle(title);

        expect(isPresentInDeletedList, true,
            reason: 'Todo is not in the deleted list');
      }, tags: ['delete_todo', 'regression']);

      testWidgets('Verify the ${category.value} todo could be restored',
          (WidgetTester tester) async {
        final App app = App(tester);
        const String title = 'Test title';
        const String description = 'Test Description';

        await app.launch();
        await app.todoListPage
            .addTodo(title, description, category: category.value);
        await app.todoListPage.openTodoDetails(title);
        await app.todoDetailsPage.deleteTodo();
        await app.todoDetailsPage.deleteTodoModalComponent.confirm();
        await app.todoListPage.tabComponent.openTab(tabs.Tab.deleted);
        await app.todoDeletedPage.todoTileComponent.restore(title);

        final isPresentInDeletedList =
            await app.todoDeletedPage.todoTileComponent.hasTitle(title);
        expect(isPresentInDeletedList, false,
            reason: 'Todo is in deleted list');

        await app.todoListPage.tabComponent.openTab(tabs.Tab.todo);

        final isPresentInTodoList =
            await app.todoListPage.todoTileComponent.hasTitle(title);
        expect(isPresentInTodoList, true, reason: 'Todo is not in todo list');
      }, tags: ['restore_todo', 'regression']);
    }
  });
}
