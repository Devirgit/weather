import 'package:weather/core/components/input_validator.dart';

class InputNum extends InputValidator<String?, String> {
  const InputNum.pure() : super.pure('');
  const InputNum.dirty([super.value = '']) : super.dirty();

  static final _stringRegExp = RegExp(r'^(0|[1-9]\d*)([.]\d+)?$');

  double get clearValue => double.tryParse(super.value) ?? 0;

  @override
  String? validator(String? value) {
    return _stringRegExp.hasMatch(value ?? '') ? null : 'UItext.notNumInput';
  }
}
