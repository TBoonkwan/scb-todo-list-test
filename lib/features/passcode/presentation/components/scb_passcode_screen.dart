import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:scb_test/theme/color/app_color.dart';

enum PasscodeEventChange { error, input, confirm, unlock }

class SCBPasscodeScreen extends StatelessWidget {
  final String title;
  final String password;

  final Function(String)? textInputChanged;

  final Function()? unlockAccount;

  const SCBPasscodeScreen({
    super.key,
    required this.title,
    required this.password,
    this.unlockAccount,
    this.textInputChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenLock(
      correctString: password,
      onValidate: (inputPassword) {
        if (inputPassword == password) {
          return Future(() => true);
        }
        textInputChanged?.call(inputPassword);
        return Future(() => false);
      },
      onUnlocked: () {
        unlockAccount?.call();
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
      config: const ScreenLockConfig(
        backgroundColor: AppColor.primaryColor,
      ),
      secretsConfig: SecretsConfig(
        spacing: 16,
        padding: const EdgeInsets.all(40),
        secretConfig: SecretConfig(
          disabledColor: Colors.white38,
          enabledColor: AppColor.primaryColor,
          builder: (context, config, enabled) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: enabled ? config.enabledColor : config.disabledColor,
                border: Border.all(
                  width: config.borderSize,
                  color: config.borderColor,
                ),
              ),
              padding: const EdgeInsets.all(16),
              width: config.size,
              height: config.size,
            );
          },
        ),
      ),
      keyPadConfig: KeyPadConfig(
        buttonConfig: KeyPadButtonConfig(size: 64),
        actionButtonConfig: KeyPadButtonConfig(
          buttonStyle: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1, color: Colors.white),
            backgroundColor: AppColor.primaryColor,
          ),
        ),
      ),
      deleteButton: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }
}
