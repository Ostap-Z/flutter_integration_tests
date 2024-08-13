enum Category {
  urgent,
  important,
  notImportant,
}

extension CategoryExtension on Category {
  String get value {
    switch (this) {
      case Category.urgent:
        return 'Urgent';
      case Category.important:
        return 'Important';
      case Category.notImportant:
        return 'Not Important';
      default:
        return '';
    }
  }
}

enum Status {
  completed,
  active,
}
