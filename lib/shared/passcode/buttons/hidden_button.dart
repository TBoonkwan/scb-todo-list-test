import 'package:flutter/material.dart';
import 'package:scb_test/shared/passcode/buttons/styled_input_button.dart';
import 'package:scb_test/shared/passcode/configurations/input_button_config.dart';

/// Hidden button.
class HiddenButton extends StyledInputButton {
  final Widget? child;

  const HiddenButton({
    this.child = const Text(''),
    InputButtonConfig config = const InputButtonConfig(),
  }) : super(onPressed: null, config: config);

  @override
  ButtonStyle makeDefaultStyle() {
    return super.makeDefaultStyle().copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        );
  }

  @override
  Widget build(BuildContext context) {
    return makeKeyContainer(child: child ?? Container(), context: context);
  }
}
