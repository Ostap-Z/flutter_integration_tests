import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../components/modals/delete_todo_modal.dart';
import '../abstract_page.dart';

final class TodoDetailsPage extends AbstractPage {
  final DeleteTodoModalComponent deleteTodoModalComponent;

  TodoDetailsPage(super.tester, this.deleteTodoModalComponent);

  final Finder _trashIcon = find.byKey(const ValueKey('deleteTodo'));

  Future<void> deleteTodo() async {
    await tester.tap(_trashIcon, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
}
