import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scb_test/features/todo/config/todo_list_route.dart';
import 'package:scb_test/shared/passcode/configurations/input_button_config.dart';
import 'package:scb_test/shared/passcode/configurations/screen_lock_config.dart';
import 'package:scb_test/shared/passcode/configurations/secret_config.dart';
import 'package:scb_test/shared/passcode/configurations/secrets_config.dart';
import 'package:scb_test/shared/passcode/screen_lock.dart';
import 'package:scb_test/theme/color/app_color.dart';

class InputScreenConfig {
  bool shouldShowCloseIcon;

  InputScreenConfig({
    this.shouldShowCloseIcon = true,
  });
}

class InputPasscodeScreen extends StatelessWidget {
  InputScreenConfig? _inputScreenConfig;

  InputPasscodeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments!=null && arguments is InputScreenConfig) {
      _inputScreenConfig = arguments;
    }else{
      _inputScreenConfig = InputScreenConfig();
    }

    return Scaffold(
      body: Stack(
        children: [
          ScreenLock(
            correctString: '123456',
            digits: 6,
            maxRetries: 3,
            didError: (times) {},
            didTextChanged: (passcode) async {},
            didMaxRetries: (time) {},
            didConfirmed: (passcode) {},
            didUnlocked: () {
              // if password is correct
              Navigator.of(context).popAndPushNamed(
                TodoListRoute.todoListScreen,
              );
            },
            title: Text(
              "Please enter your PIN",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            screenLockConfig: const ScreenLockConfig(
              backgroundColor: AppColor.primaryColor,
            ),
            secretsConfig: SecretsConfig(
              spacing: 16,
              padding: const EdgeInsets.all(40),
              secretConfig: SecretConfig(
                  disabledColor: Colors.white,
                  enabledColor: AppColor.primaryColor,
                  height: 16,
                  width: 16,
                  build: (
                    context, {
                    required config,
                    required enabled,
                  }) {
                    return SizedBox(
                      width: config.width,
                      height: config.height,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: enabled
                              ? config.enabledColor
                              : config.disabledColor,
                          border: Border.all(
                            width: config.borderSize,
                            color: config.borderColor,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        width: config.width,
                        height: config.height,
                      ),
                    );
                  }),
            ),
            inputButtonConfig: InputButtonConfig(
              width: 64,
              height: 64,
              buttonStyle: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1, color: Colors.white),
                backgroundColor: AppColor.primaryColor,
              ),
            ),
            deleteButton: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            canCancel: false,
          ),
          Positioned(
            top: 56,
            right: 24,
            child: Builder(builder: (context) {
              if (_inputScreenConfig?.shouldShowCloseIcon == true) {
                return IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      exit(0);
                    }
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                );
              }

              return const SizedBox();

            }),
          )
        ],
      ),
    );
  }
}
