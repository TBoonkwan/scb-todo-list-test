import 'package:flutter/material.dart';
import 'package:scb_test/shared/passcode/configurations/secret_config.dart';
import 'package:scb_test/shared/passcode/configurations/secrets_config.dart';

class Secrets extends StatefulWidget {
  SecretsConfig? config;
  Stream<String>? inputStream;
  Stream<bool>? verifyStream;
  int? length;

  Secrets({
    this.config,
    required this.inputStream,
    required this.verifyStream,
    required this.length,
  });

  @override
  _SecretsState createState() => _SecretsState();
}

class _SecretsState extends State<Secrets> with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    widget.verifyStream!.listen((valid) {
      if (!valid) {
        // shake animation when invalid
        _animationController.forward();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 80),
    );

    _animation = _animationController
        .drive(CurveTween(curve: Curves.elasticIn))
        .drive(Tween<Offset>(begin: Offset.zero, end: const Offset(0.05, 0)))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          }
        },
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double? _computeSpacing(BuildContext context) {
    if (widget.config!.spacing != null) {
      return widget.config!.spacing;
    }

    return MediaQuery.of(context).size.width * widget.config!.spacingRatio;
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: StreamBuilder<String>(
        stream: widget.inputStream,
        builder: (context, snapshot) {
          return Container(
            padding: widget.config!.padding,
            child: Wrap(
              spacing: _computeSpacing(context) ?? 0,
              children: List.generate(
                widget.length ?? 0,
                (index) {
                  if (!snapshot.hasData) {
                    return Secret(
                      config: widget.config!.secretConfig,
                      enabled: false,
                    );
                  }

                  return Secret(
                    config: widget.config!.secretConfig,
                    enabled: index < snapshot.data!.length,
                  );
                },
                growable: false,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Secret extends StatelessWidget {
  bool enabled;
  SecretConfig config;

  Secret({
    required this.enabled,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (config.build != null) {
      return config.build!(
        context,
        config: config,
        enabled: enabled,
      );
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: enabled ? config.enabledColor : config.disabledColor,
        border: Border.all(
          width: config.borderSize,
          color: config.borderColor,
        ),
      ),
      width: config.width,
      height: config.height,
    );
  }
}
