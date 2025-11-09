import 'package:flutter/material.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/screen_utils.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: fullWidth(context),
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(text,style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w600),),
      ),
    );
  }
}
