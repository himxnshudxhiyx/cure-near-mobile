import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? borderColor;
  final bool? filled;
  final bool? enabled;
  final FocusNode? focusNode;

  const AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.maxLines,
    this.prefixIcon,
    this.validator,
    this.fillColor,
    this.borderColor,
    this.filled,
    this.enabled,
    this.focusNode,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validate);
    _isObscured = widget.obscureText;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validate);
    super.dispose();
  }

  void _validate() {
    final error = widget.validator?.call(widget.controller.text);
    if (error != _errorText) {
      setState(() {
        _errorText = error;
      });
    }
  }

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled ?? true,
      focusNode: widget.focusNode ?? FocusNode(),
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      obscureText: _isObscured,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700, fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.w500),
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700, fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.w500),
        labelText: widget.labelText,
        fillColor: widget.fillColor ?? Colors.grey.shade200,
        filled: widget.filled ?? false,
        enabled: widget.enabled ?? true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.grey.shade400,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.grey.shade400,
          ),
        ),
        // suffixIcon: widget.suffixWidget,
        suffixIcon: (widget.obscureText == true)
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade700,
                ),
              )
            : widget.suffixWidget,
        prefixIcon: widget.prefixIcon,
        errorText: _errorText, // Display the error text
      ),
      onChanged: (value) {
        _validate();
      },
    );
  }
}
