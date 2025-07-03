import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final Color? color;
  final double size;
  const LoaderWidget({super.key, this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? Colors.blue,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
