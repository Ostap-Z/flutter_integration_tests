import '../../components/todo_tile_component.dart';
import '../abstract_page.dart';

final class SearchResultsPage extends AbstractPage {
  final TodoTileComponent todoTileComponent;

  SearchResultsPage(super.tester, this.todoTileComponent);
}
