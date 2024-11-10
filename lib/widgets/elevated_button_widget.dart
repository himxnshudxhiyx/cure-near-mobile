import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final Color? bgColor;
  final double? fontSize;
  final double? width;
  final double? height;

  const ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontSize,
    this.textColor,
    this.bgColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? media.width * 0.8,
      height: height?? media.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: color ?? Colors.white, backgroundColor: bgColor ?? Theme.of(context).primaryColor, elevation: 0,
        ),
        child: TextView(
          text: text,
          fontColor: textColor ?? Colors.white,
          // style: TextStyle(color: textColor ?? Colors.white, fontSize: fontSize.sp ?? 22.sp),
        ),
      ),
    );
  }
}