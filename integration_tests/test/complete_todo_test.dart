import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../constants/tabs.dart' as tabs;
import '../constants/todo_tile.dart';

final List<Tag> tags = [
  Tag.urgent,
  Tag.important,
  Tag.notImportant,
];

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TODO complete', () {
    for (final Tag tag in tags) {
      testWidgets('Verify the ${tag.value} todo could be completed',
          (WidgetTester tester) async {
        final App app = App(tester);
        const String title = 'Test title';
        const String description = 'Test Description';

        await app.launch();
        await app.todoListPage.addTodo(title, description, tag: tag.value);
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
    }
  });
}
