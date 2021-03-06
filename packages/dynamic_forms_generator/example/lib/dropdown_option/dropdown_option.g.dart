// GENERATED CODE - DO NOT MODIFY BY HAND

import '../components.dart';
import 'package:meta/meta.dart';

class DropdownOption extends SingleSelectChoice {
  void fillDropdownOption({
    @required String id,
    @required ElementValue<FormElement> parent,
    @required ElementValue<bool> isVisible,
    @required ElementValue<String> label,
    @required ElementValue<String> value,
  }) {
    fillSingleSelectChoice(
      id: id,
      parent: parent,
      isVisible: isVisible,
      label: label,
      value: value,
    );
  }

  @override
  FormElement getInstance() {
    return DropdownOption();
  }
}
