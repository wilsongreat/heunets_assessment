import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/gap.dart';
import 'package:heunets_assessment_app/core/utils/screen_utils.dart';
import 'package:heunets_assessment_app/core/widgets/custom_textfield.dart';
import 'package:heunets_assessment_app/core/widgets/custon_btn.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();

  void initializeControllers() {
    fullNameController.text = 'John Doe';
    emailController.text = 'john.doe@example.com';
    phoneController.text = "+1 (555) 123-4567";
    locationController.text = "San Francisco, CA";
    jobTitleController.text = "Frontend Developer";
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Saved profile details'),
        backgroundColor: AppColors.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,

        title: Text('Profile', style: TextStyle(color: AppColors.white),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20),
               Container(
                 width: double.infinity,
                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                 decoration: BoxDecoration(
                   color: AppColors.white,
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(
                     color: AppColors.grey.withValues(alpha: .2),
                     width: 1,
                   ),
                   boxShadow: [
                     BoxShadow(
                       color: AppColors.black.withValues(alpha: 0.03),
                       spreadRadius: 4,
                       blurRadius: 10,
                     ),
                   ],
                 ),
                 child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: AppColors.primaryColor,
                        child: Text('JD', style: TextStyle(color: AppColors.white, fontSize: 30),),
                      ),
                      Gap(10),
                      Text('John Doe', style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),),
                      Text('Frontend Developer', style: TextStyle(color: AppColors.grey, fontSize: 16.sp),),
                      Gap(20),
                      
                      CustomTextField(controller: fullNameController ,label: 'Full Name',iconData: Hicons.profile1LightOutline,),
                      Gap(10),
            
                      CustomTextField(controller: emailController ,label: 'Email',iconData: Icons.mail_outline, ),
                      Gap(10),
            
                      CustomTextField(controller: phoneController ,label: 'Phone',iconData: Hicons.callLightOutline,),
                      Gap(10),
            
                      CustomTextField(controller: locationController ,label: 'Location',iconData: Hicons.locationLightOutline,),
                      Gap(10),
            
                      CustomTextField(controller: jobTitleController ,label: 'Job Title',iconData: Hicons.bag2LightOutline,),
                      Gap(20),
                      CustomBtn(onTap: _saveProfile, text: "Save Changes")
            
                    ],
                  ),
                ),
                Gap(20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.grey.withValues(alpha: .2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        spreadRadius: 4,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                      Gap(15),
                      profileActionChip(label: 'Change Password'),
                      Gap(10),
                      profileActionChip(label: 'Notification Settings'),
                      Gap(10),
                      profileActionChip(label: 'Delete Account',color: AppColors.red),
                      Gap(10),
                    ],
                  ),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget profileActionChip({String? label, Color? color }){
    return Container(
      width: fullWidth(context),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.grey.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.grey.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: Text(label!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color ?? AppColors.black),),
    );
  }
}
