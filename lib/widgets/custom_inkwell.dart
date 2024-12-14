import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInkwell extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;

  const CustomInkwell({super.key, this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isTapped = false;
    return AbsorbPointer(
      absorbing: isTapped,
      child: InkWell(
        onTap: () {
          isTapped = true;
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          onTap?.call();
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: child,
      ),
    );
  }
}
