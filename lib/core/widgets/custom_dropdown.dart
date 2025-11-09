import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final T? value;
  final List<DropdownItem<T>> items;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final bool enabled;
  final Color? labelColor;
  final double? fontSize;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.enabled = true,
    this.labelColor,
    this.fontSize,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _updateController();
  }

  @override
  void didUpdateWidget(CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateController();
      });
    }
  }

  void _updateController() {
    if (widget.value != null) {
      final item = widget.items.firstWhere(
            (item) => item.value == widget.value,
        orElse: () => DropdownItem(value: widget.value as T, label: ''),
      );
      if (_controller.text != item.label) {
        _controller.text = item.label;
      }
    } else {
      if (_controller.text.isNotEmpty) {
        _controller.clear();
      }
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (mounted && !context.debugDoingBuild) {
      try {
        setState(() {
          _isOpen = false;
        });
      } catch (e) {
        _isOpen = false;
      }
    } else {
      _isOpen = false;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, 50),
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200.h,
              ),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
                border: Border.all(
                  color: widget.borderColor ?? Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = widget.value == item.value;

                  return InkWell(
                    onTap: () {
                      widget.onChanged?.call(item.value);
                      _removeOverlay();
                    },
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: index == 0
                            ? BorderRadius.only(
                          topLeft: Radius.circular(widget.borderRadius ?? 12.0),
                          topRight: Radius.circular(widget.borderRadius ?? 12.0),
                        )
                            : index == widget.items.length - 1
                            ? BorderRadius.only(
                          bottomLeft: Radius.circular(widget.borderRadius ?? 12.0),
                          bottomRight: Radius.circular(widget.borderRadius ?? 12.0),
                        )
                            : BorderRadius.zero,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: widget.fontSize ?? 16.sp,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
      borderSide: BorderSide(
        color: widget.borderColor ?? Colors.grey[300]!,
        width: 1.0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),

        SizedBox(
          height: 50.h,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: TextFormField(
              controller: _controller,
              readOnly: true,
              onTap: widget.enabled ? _toggleDropdown : null,
              validator: (value) {
                if (widget.validator != null) {
                  return widget.validator!(widget.value);
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(
                fontSize: widget.fontSize ?? 16.sp,
                fontWeight: FontWeight.w400,
                color: widget.enabled ? Colors.black87 : Colors.grey[600],
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.backgroundColor ?? Colors.grey[50],
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),
                enabledBorder: outlineBorder,
                focusedBorder: outlineBorder,
                disabledBorder: outlineBorder,
                errorBorder: outlineBorder,
                focusedErrorBorder: outlineBorder,
                border: outlineBorder,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: widget.fontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: AnimatedRotation(
                    turns: _isOpen ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.enabled ? Colors.grey[600] : Colors.grey[400],
                      size: 24.sp,
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  maxWidth: 50.w,
                  maxHeight: 24.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Helper class for dropdown items
class DropdownItem<T> {
  final T value;
  final String label;

  const DropdownItem({
    required this.value,
    required this.label,
  });
}