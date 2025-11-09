import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? iconData;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;

  const CustomTextField({
    Key? key,
    required this.label,
    this.iconData,
    this.hintText,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.height,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fixed: Use Expanded to prevent overflow
        Row(
          children: [
            if (widget.iconData != null) ...[
              Icon(widget.iconData, size: 20),
              SizedBox(width: 8.w), // Add spacing between icon and text
            ],
            Expanded( // Wrap text in Expanded to prevent overflow
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis, // Handle long labels
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          height: widget.height ?? 50.h,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.grey[50],
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
            border: Border.all(
              color: _isFocused
                  ? (widget.borderColor ?? AppColors.primaryColor)
                  : Colors.grey[300]!,
              width: _isFocused ? 2.0 : 1.0,
            ),
          ),
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            validator: widget.validator,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            textCapitalization: widget.textCapitalization,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h, // Add vertical padding for better text alignment
              ),
              counterText: '', // Hide character counter
            ),
          ),
        ),
      ],
    );
  }
}