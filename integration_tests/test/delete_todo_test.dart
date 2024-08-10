import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../constants/tabs.dart';
import '../constants/tags.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TODO deletion', () {
    final List<Tag> tags = [
      Tag.urgent,
      Tag.important,
      Tag.notImportant,
    ];

    for (final Tag tag in tags) {
      testWidgets('Verify the ${tag.value} todo could be deleted',
          (WidgetTester tester) async {
        final App app = App(tester);
        const String title = 'Test title';
        const String description = 'Test Description';

        await app.launch();
        await app.todoListPage.addTodo(title, description, tag: tag.value);
        await app.todoListPage.openTodoDetails(title);
        await app.todoDetailsPage.deleteTodo();
        await app.todoDetailsPage.deleteTodoModalComponent.confirm();

        final bool isPresentInTodoList =
            await app.todoListPage.todoTileComponent.hasTitle(title);
        expect(isPresentInTodoList, false, reason: 'Todo is in the todo list');

        await app.todoListPage.tabComponent.openTab(Tab.deleted);

        final bool isPresentInDeletedList =
            await app.todoDeletedPage.todoTileComponent.hasTitle(title);
        expect(isPresentInDeletedList, true,
            reason: 'Todo is not in the deleted list');
      });
    }

    // testWidgets('Verify todo could be deleted', (WidgetTester tester) async {
    //   final App app = App(tester);
    //   const String title = 'Test title';
    //   const String description = 'Test Description';

    //   await app.launch();
    //   await app.todoListPage.addTodo(title, description);
    //   await app.todoListPage.openTodoDetails(title);
    //   await app.todoDetailsPage.deleteTodo();
    //   await app.todoDetailsPage.deleteTodoModalComponent.confirm();

    //   final bool isPresentInTodoList =
    //       await app.todoListPage.todoTileComponent.hasTitle(title);
    //   expect(isPresentInTodoList, false, reason: 'Todo is in the todo list');

    //   await app.todoListPage.tabComponent.openTab(Tab.deleted);

    //   final bool isPresentInDeletedList =
    //       await app.todoDeletedPage.todoTileComponent.hasTitle(title);
    //   expect(isPresentInDeletedList, true,
    //       reason: 'Todo is not in the deleted list');
    // });
  });
}
