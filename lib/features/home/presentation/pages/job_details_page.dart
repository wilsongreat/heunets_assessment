import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/gap.dart';
import 'package:heunets_assessment_app/core/utils/screen_utils.dart';
import 'package:heunets_assessment_app/core/widgets/Container_wrapper.dart';
import 'package:heunets_assessment_app/core/widgets/custon_btn.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';
import 'package:heunets_assessment_app/features/home/presentation/widgets/job_application_dialog.dart';
import 'package:heunets_assessment_app/features/job/data/model/job_model.dart';
import 'package:heunets_assessment_app/features/job/presentation/widgets/job_info_chip.dart';
import 'package:provider/provider.dart';

class JobDetailsPage extends StatefulWidget {
  final Job jobInfo;
  const JobDetailsPage({super.key, required this.jobInfo});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {

  void _showApplicationDialog() {
    final homeController = context.read<HomeController>();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return JobApplicationDialog(
          job: widget.jobInfo,
          homeController:homeController ,
          onSubmit: () {
            debugPrint('Application submitted!');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Job Details',
          style: TextStyle(color: AppColors.white),
        ),
        actions: [Icon(Icons.share_outlined)],
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Gap(20),
              Wrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.jobInfo.companyInitial,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // ✅ Added this
                            children: [
                              Text(
                                widget.jobInfo.title,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                widget.jobInfo.company,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey,
                                ),
                              ),
                              Gap(10),

                            ],
                          ),
                        )
                      ],
                    ),
                    Gap(10),
                    Wrap(
                      spacing: 5,
                      runSpacing: 10,
                      children: [
                        JobInfoChip(
                          icon: Hicons.workLightOutline,
                          info: widget.jobInfo.location,
                        ),
                        Gap(10),
                        JobInfoChip(
                          icon: Hicons.workLightOutline,
                          info: widget.jobInfo.jobType,
                        ), Gap(10),
                        JobInfoChip(
                          icon: Hicons.timeCircle1LightOutline,
                          info: widget.jobInfo.timePosted,
                        ),
                      ],
                    ),
                    Gap(10),
                    Gap(10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.jobInfo.salaryRange,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Gap(10),
                    CustomBtn(onTap: (){
                      _showApplicationDialog();
                    }, text: 'Apply Now')
                  ],
                ),
              ),
              Gap(15),
              Wrapper(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Account Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Gap(10),
                  Text(widget.jobInfo.aboutRole, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: AppColors.grey ),),
              ],)),
              Gap(15),
              Wrapper(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Requirements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                Gap(10),

                  ...widget.jobInfo.requirements.map((e) =>SizedBox(
                    width: fullWidth(context),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 3,backgroundColor: AppColors.primaryColor,),
                        Gap(10),
                        SizedBox(width: fullWidth(context) * .8,child: Text(e, style: TextStyle(fontSize: 13.sp,color: AppColors.grey, fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)),
                      ],
                    ),
                  ))


              ],)),
              Gap(15),
              Wrapper(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Benefits', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 10.0,
                    spacing: 5,
                    children: widget.jobInfo.benefits.map((e) => JobInfoChip( info: e),).toList()
                  )

              ],))

            ],
          ),
        ),
      ),
    );
  }
}