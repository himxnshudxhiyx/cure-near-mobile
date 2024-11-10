import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final bool? filled;

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
    this.filled,
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
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      obscureText: _isObscured,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
        labelText: widget.labelText,
        fillColor: widget.fillColor ?? Colors.grey.shade200,
        filled: widget.filled ?? false,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.0,
            ),
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
