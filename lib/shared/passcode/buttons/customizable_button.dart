import 'package:flutter/material.dart';
import 'package:scb_test/shared/passcode/buttons/styled_input_button.dart';
import 'package:scb_test/shared/passcode/configurations/input_button_config.dart';

/// Customizable button.
class CustomizableButton extends StyledInputButton {
  final Widget child;

  const CustomizableButton({
    this.child = const Text(''),
    required void Function() onPressed,
    InputButtonConfig config = const InputButtonConfig(),
  }) : super(onPressed: onPressed, config: config);

  @override
  ButtonStyle makeDefaultStyle() {
    return super.makeDefaultStyle().copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        );
  }

  @override
  Widget build(BuildContext context) {
    return makeKeyContainer(child: child, context: context);
  }
}
