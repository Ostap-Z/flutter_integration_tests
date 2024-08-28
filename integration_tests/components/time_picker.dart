import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icons.dart';

import 'abstract_component.dart';

final class TimePickerComponent extends AbstractComponent {
  TimePickerComponent(super.tester);

  @override
  final Finder rootFinder = find.byType(ConstrainedBox);

  late final Finder _timeIcon = find.byIcon(LineIcons.clock);
  late final Finder _switchToInputIcon = find.descendant(
      of: rootFinder, matching: find.byTooltip('Switch to text input mode'));
  late final Finder _hoursInput = find
      .descendant(of: rootFinder, matching: find.byType(TextFormField))
      .first;
  late final Finder _minutesInput = find
      .descendant(of: rootFinder, matching: find.byType(TextFormField))
      .last;
  late final Finder _okIcon =
      find.descendant(of: rootFinder, matching: find.text('OK'));

  Future<void> clickTimeIcon() async {
    await tester.tap(_timeIcon);
    await tester.pumpAndSettle();
  }

  Future<void> set(String time) async {
    final String hours = time.split(':')[0];
    final String minutes = time.split(':')[1];

    await tester.tap(_switchToInputIcon);
    await tester.pumpAndSettle();

    await tester.enterText(_hoursInput, hours);
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.enterText(_minutesInput, minutes);
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.tap(_okIcon);
    await tester.pumpAndSettle();
  }
}
