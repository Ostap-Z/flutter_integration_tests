enum Tab {
  todo,
  completed,
  deleted,
}

extension TabsExtension on Tab {
  String get value {
    switch (this) {
      case Tab.todo:
        return 'Todo';
      case Tab.completed:
        return 'Completed';
      case Tab.deleted:
        return 'Deleted';
      default:
        return '';
    }
  }
}
