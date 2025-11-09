import 'package:flutter/material.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/screen_utils.dart';


class Wrapper extends StatelessWidget {
  final Widget child;
  const Wrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth(context),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.grey.withValues(alpha: .2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .03),
            spreadRadius: 4,
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );

  }
}
