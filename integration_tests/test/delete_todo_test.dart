import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../constants/tabs.dart';
import '../constants/tags.dart';

final List<Tag> tags = [
  Tag.urgent,
  Tag.important,
  Tag.notImportant,
];

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TODO deletion', () {
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
        await app.todoListPage.tabComponent.openTab(Tab.deleted);
        final bool isPresentInDeletedList =
            await app.todoDeletedPage.todoTileComponent.hasTitle(title);

        expect(isPresentInDeletedList, true,
            reason: 'Todo is not in the deleted list');
      }, tags: ['delete_todo', 'regression']);
    }
  });
}
