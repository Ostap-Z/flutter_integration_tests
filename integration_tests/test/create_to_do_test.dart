import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TODO creation', () {
    testWidgets('Verify todo could be created 1', (WidgetTester tester) async {
      final App app = App(tester);
      const title = 'Test title 1';
      const description = 'Test Description';

      await app.launch();
      await app.todoPage.addTodo(title, description);
      final bool isTodoCreated = await app.todoPage.isTodoPresent(title);

      expect(isTodoCreated, true, reason: 'Todo is not created');
    });

    testWidgets('Verify todo could be created 2', (WidgetTester tester) async {
      final App app = App(tester);
      const title = 'Test title 2';
      const description = 'Test Description';

      await app.launch();
      await app.todoPage.addTodo(title, description);
      final bool isTodoCreated = await app.todoPage.isTodoPresent(title);

      expect(isTodoCreated, true, reason: 'Todo is not created');
    });
  });
}
