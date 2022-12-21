import 'dart:html';

import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

import 'date_utils.dart';

class DateTimeField extends Component
    with ValueChangeEventSource<DateTime>, MixinDisable
    implements StateComponent<DateTime> {
  DateTimeField() : super('DateTimeField') {
    element.onChange.listen((event) {
      try {
        final newValue = value;
        fireValueChange(newValue, newValue);
      } on Exception catch (_) {}
    });
  }

  @override
  LocalDateTimeInputElement element = LocalDateTimeInputElement();

  void onChange(Function(Event event) listener) {
    element.onChange.listen((e) {
      listener(e);
    });
  }

  DateTime get value {
    if (element.valueAsNumber == null) {
      throw Exception('bad field value');
    }
    if (element.valueAsNumber!.isNaN) {
      throw Exception('bad field value');
    }
    return DateTime.fromMillisecondsSinceEpoch((element.valueAsNumber ?? 0).ceil(), isUtc: true);
  }

  set value(DateTime value) {
    var newValue = '';
    newValue = formatDateTimeText(value);
    element.value = newValue;
  }

  @override
  String get state => getStringValue();

  @override
  set state(String newValue) =>
      value = DateTime.fromMillisecondsSinceEpoch((element.valueAsNumber ?? 0).ceil(), isUtc: true);

  String getStringValue() => formatDateTime(value);

  void focus() {
    element.focus();
  }
}
