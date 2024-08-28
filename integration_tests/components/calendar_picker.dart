import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icons.dart';

import 'abstract_component.dart';

final class CalendarPickerComponent extends AbstractComponent {
  CalendarPickerComponent(super.tester);

  @override
  final Finder rootFinder = find.byType(ConstrainedBox);

  late final Finder _calendarIcon = find.byIcon(LineIcons.calendar);
  late final Finder _switchToInputIcon = find.descendant(
      of: rootFinder, matching: find.byTooltip('Switch to input'));
  late final Finder _dateInput = find.descendant(
      of: rootFinder, matching: find.byType(InputDatePickerFormField));
  late final Finder _okIcon =
      find.descendant(of: rootFinder, matching: find.text('OK'));

  Future<void> clickCalendarIcon() async {
    await tester.tap(_calendarIcon);
    await tester.pumpAndSettle();
  }

  Future<void> set(String date) async {
    await tester.tap(_switchToInputIcon);
    await tester.pumpAndSettle();

    await tester.enterText(_dateInput, date);
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.tap(_okIcon);
    await tester.pumpAndSettle();
  }
}
