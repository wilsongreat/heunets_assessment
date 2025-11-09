import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/gap.dart';
import 'package:heunets_assessment_app/core/utils/screen_utils.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';
import 'package:heunets_assessment_app/features/home/presentation/pages/job_details_page.dart';
import 'package:heunets_assessment_app/features/home/presentation/widgets/search_input.dart';
import 'package:heunets_assessment_app/features/job/presentation/widgets/job_card_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: fullWidth(context) * .45,
            width: fullWidth(context),
            color: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Your Dream Job',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(10),
                  SearchInput(),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Consumer<HomeController>(
                builder: (context, homeController, child) {
                  final filteredJobs = homeController.filteredJobs;
                  final searchQuery = homeController.searchQuery;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        searchQuery.isEmpty
                            ? 'Latest Opportunities'
                            : 'Search Results',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${filteredJobs.length} jobs available',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Gap(20),
                      if (filteredJobs.isEmpty && searchQuery.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              Gap(16),
                              Text(
                                'No jobs found',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Gap(8),
                              Text(
                                'Try adjusting your search terms',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ListView.separated(
                        padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            final job = filteredJobs[i];
                            return JobCardWidget(
                              job: job,
                              callback: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => JobDetailsPage(jobInfo: job),
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (c, i) => Gap(10),
                          itemCount: filteredJobs.length,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}