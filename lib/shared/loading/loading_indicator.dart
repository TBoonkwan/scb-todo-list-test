import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Size size;

  const LoadingIndicator({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
