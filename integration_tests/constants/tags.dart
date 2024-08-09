enum TodoTag {
  urgent,
  important,
  notImportant,
}

extension TodoTagExtension on TodoTag {
  String get value {
    switch (this) {
      case TodoTag.urgent:
        return 'Urgent';
      case TodoTag.important:
        return 'Important';
      case TodoTag.notImportant:
        return 'Not Important';
      default:
        return '';
    }
  }
}
