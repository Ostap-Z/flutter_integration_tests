enum Category {
  urgent,
  important,
  notImportant,
  custom,
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
      case Category.custom:
        return 'Custom category';
      default:
        return '';
    }
  }
}

enum Status {
  completed,
  active,
}
