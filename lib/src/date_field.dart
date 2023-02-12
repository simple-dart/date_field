import 'dart:html';

import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';
import 'package:simple_dart_utils_date_time/simple_dart_utils_date_time.dart' as utils_date_time;

class DateField extends Component
    with ValueChangeEventSource<DateTime>, MixinDisable
    implements StateComponent<DateTime> {
  DateField() : super('DateField') {
    element.onChange.listen((event) {
      try {
        final newValue = value;
        fireValueChange(newValue, newValue);
      } on Exception catch (_) {}
    });
  }

  @override
  DateInputElement element = DateInputElement();

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
    element.value = value.toIso8601String().substring(0, 10);
  }

  @override
  String get state => getStringValue();

  @override
  set state(String newValue) =>
      value = DateTime.fromMillisecondsSinceEpoch((element.valueAsNumber ?? 0).ceil(), isUtc: true);

  String getStringValue() => utils_date_time.formatDate(value);

  void focus() {
    element.focus();
  }
}
