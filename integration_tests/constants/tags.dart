enum Tag {
  urgent,
  important,
  notImportant,
}

extension TodoTagExtension on Tag {
  String get value {
    switch (this) {
      case Tag.urgent:
        return 'Urgent';
      case Tag.important:
        return 'Important';
      case Tag.notImportant:
        return 'Not Important';
      default:
        return '';
    }
  }
}
