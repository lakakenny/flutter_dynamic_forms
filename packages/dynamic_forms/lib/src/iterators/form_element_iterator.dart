import 'dart:collection';

import 'package:dynamic_forms/dynamic_forms.dart';

Iterable<TFormElement> getFormElementIterator<TFormElement extends FormElement>(
    FormElement formElement) sync* {
  Queue<FormElement> stack = Queue<FormElement>.from([formElement]);
  Set<FormElement> visitedElements = {formElement};
  while (stack.isNotEmpty) {
    var formElement = stack.removeLast();
    visitedElements.add(formElement);
    if (formElement is TFormElement) {
      yield formElement;
    }
    var formElements = formElement
        .getProperties()
        .values
        .whereType<ElementValue<FormElement>>()
        .map((v) => v.value)
        .toList();

    var formListElements = formElement
        .getProperties()
        .values
        .whereType<ElementValue<List<FormElement>>>()
        .map((v) => v.value)
        .expand((x) => x);
    formElements.addAll(formListElements);

    formElements.forEach((e) {
      if (!visitedElements.contains(e)) {
        stack.addLast(e);
      }
    });
  }
}
