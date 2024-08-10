import '../../components/tab.dart';
import '../../components/todo_tile_component.dart';
import '../abstract_page.dart';

final class TodoDeletedPage extends AbstractPage {
  final TodoTileComponent todoTileComponent;
  final TabComponent tabComponent;

  TodoDeletedPage(super.tester, this.todoTileComponent, this.tabComponent);
}
