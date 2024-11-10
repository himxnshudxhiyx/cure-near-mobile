import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final Color? fontColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextView({
    super.key,
    required this.text,
    this.style,
    this.fontSize,
    this.fontColor,
    this.textAlign,
    this.fontWeight,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(
              fontSize: fontSize?.sp ?? 16.sp,
              color: fontColor ?? Colors.black,
              fontFamily: GoogleFonts.poppins()
                  .fontFamily,
              fontWeight: fontWeight ?? FontWeight.w500
          ),
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}