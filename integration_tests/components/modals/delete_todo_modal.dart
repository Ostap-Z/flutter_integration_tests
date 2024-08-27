import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'abstract_modal.dart';

final class DeleteTodoModalComponent extends AbstractModal {
  DeleteTodoModalComponent(super.tester);

  @override
  final Finder rootFinder = find.byType(AlertDialog);
  late final Finder _confirmIcon = find.descendant(
      of: rootFinder, matching: find.byKey(const ValueKey('confirmDelete')));
  late final Finder _cancelIcon = find.descendant(
      of: rootFinder, matching: find.byKey(const ValueKey('cancelDelete')));

  @override
  Future<void> confirm() async {
    await tester.tap(_confirmIcon);
    await tester.pumpAndSettle();
  }

  @override
  Future<void> cancel() async {
    await tester.tap(_cancelIcon);
    await tester.pumpAndSettle();
  }
}
