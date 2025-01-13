import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leadingIcon;
  final double elevation;
  final double scrolledUnderElevation;
  final bool centerTitle;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leadingIcon,
    this.elevation = 0.0,
    this.scrolledUnderElevation = 0.0,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      title: TextView(
        text: title,
        fontSize: 18,
      ),
      leading: leadingIcon != null
          ? Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: leadingIcon,
            )
          : null,
      centerTitle: centerTitle,
      leadingWidth: 30.w,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
