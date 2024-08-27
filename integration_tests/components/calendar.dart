import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icons.dart';

import 'abstract_component.dart';

final class CalendarComponent extends AbstractComponent {
  CalendarComponent(super.tester);

  @override
  final Finder rootFinder = find.byKey(const ValueKey('searchBar'));

  late final Finder _calendarIcon = find.byIcon(LineIcons.calendar);

  Future<void> clickCalendarIcon() async {
    await tester.tap(_calendarIcon);
    await tester.pumpAndSettle();
  }

  Future<void> set(String date) async {
    final dateInput = find.byType(InputDatePickerFormField);

    await tester.tap(find.byTooltip('Switch to input'));
    await tester.pumpAndSettle();

    await tester.enterText(dateInput, date);
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
  }
}
