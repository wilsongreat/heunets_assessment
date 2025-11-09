import 'package:flutter/material.dart' ;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/gap.dart';
import 'package:heunets_assessment_app/core/utils/screen_utils.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';
import 'package:heunets_assessment_app/features/job/data/model/job_application_model.dart';
import 'package:heunets_assessment_app/features/job/presentation/widgets/applied_job_widget.dart';
import 'package:provider/provider.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {

  String tabLabel = 'All';

  @override
  Widget build(BuildContext context) {

    HomeController homeController = context.read<HomeController>();

    List<JobApplication> pendingJobs = homeController.sampleApplications
        .where((application) => application.status.name == ApplicationStatus.pending.name)
        .toList();

    List<JobApplication> completedJobs = homeController.sampleApplications
        .where((application) => application.status.name != ApplicationStatus.pending.name)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text('My Applications', style: TextStyle(color: AppColors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10),
              Container(
                height: 45,
                width: fullWidth(context),
                padding: EdgeInsets.symmetric(vertical:2,horizontal:2),
                decoration: BoxDecoration(color: AppColors.grey.withValues(alpha: .1), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tabChip('All'),
                    tabChip('Pending'),
                    tabChip('Completed'),
                  ],
                ),
              ),
              Gap(10),
              if(tabLabel.toLowerCase() == 'all')
              ...homeController.sampleApplications.map((e){
                return AppliedJobWidget(appliedJob: e,);
              }),
              if(tabLabel.toLowerCase() == ApplicationStatus.pending.name)
              ...pendingJobs.map((e){
                return AppliedJobWidget(appliedJob: e,);
              }),
              if(tabLabel.toLowerCase() ==  ApplicationStatus.completed.name)
                ...completedJobs.map((e){
                  return AppliedJobWidget(appliedJob: e,);
                })
            ],
          ),
        ),
      ),
    );
  }

  Widget tabChip(String? label){
    return  GestureDetector(
      onTap: (){
        setState(() {
          tabLabel = label;
        });
      },
      child: Container(
        height:43,
        width: 100.w,
        decoration:BoxDecoration(
            color: tabLabel == label ?  AppColors.white : null,
            borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.center,
        child: Text(label!,style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),),
      ),
    );
  }
}
