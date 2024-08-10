import '../abstract_component.dart';

abstract base class AbstractModal extends AbstractComponent {
  AbstractModal(super.tester);

  Future<void> confirm();
  Future<void> cancel();
}
