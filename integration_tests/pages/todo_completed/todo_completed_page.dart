import '../../components/tab.dart';
import '../../components/todo_tile_component.dart';
import '../abstract_page.dart';

final class TodoCompletedPage extends AbstractPage {
  final TodoTileComponent todoTileComponent;
  final TabComponent tabComponent;

  TodoCompletedPage(super.tester, this.todoTileComponent, this.tabComponent);
}
