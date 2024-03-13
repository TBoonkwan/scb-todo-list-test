import 'package:flutter/material.dart';
import 'package:scb_test/shared/passcode/configurations/input_button_config.dart';

/// [OutlinedButton] based button.
abstract class StyledInputButton extends StatelessWidget {
  final StyledInputConfig? config;
  final void Function()? onPressed;

  const StyledInputButton({
    this.config = const StyledInputConfig(),
    required this.onPressed,
  });

  double computeHeight(Size boxSize) {
    if (config!.autoSize!) {
      return _computeAutoSize(boxSize);
    }

    return boxSize.height;
  }

  double computeWidth(Size boxSize) {
    if (config!.autoSize!) {
      return _computeAutoSize(boxSize);
    }

    return boxSize.width;
  }

  Size defaultSize(BuildContext context) {
    return Size(
      config?.height ?? MediaQuery.of(context).size.height * 0.6 * 0.16,
      config?.width ?? MediaQuery.of(context).size.width * 0.22,
    );
  }

  EdgeInsetsGeometry defaultMargin() {
    return const EdgeInsets.all(10);
  }

  double _computeAutoSize(Size size) {
    return size.width < size.height ? size.width : size.height;
  }

  /// Make default style from [OutlinedButton]
  ///
  /// Override this to customize the style.
  ButtonStyle makeDefaultStyle() {
    return config?.buttonStyle ?? OutlinedButton.styleFrom();
  }

  Widget makeKeyContainer({required BuildContext context, required Widget child}) {
    final boxSize = defaultSize(context);
    return Container(
      height: computeHeight(boxSize),
      width: computeWidth(boxSize),
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: onPressed,
        child: child,
        style: makeDefaultStyle(),
      ),
    );
  }
}
