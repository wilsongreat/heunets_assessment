import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/utils/gap.dart';
import 'package:heunets_assessment_app/core/utils/screen_utils.dart';
import 'package:heunets_assessment_app/features/job/data/model/job_model.dart';

class JobCardWidget extends StatelessWidget {
  final VoidCallback callback;
  final Job  job;
  const JobCardWidget({super.key, required this.callback, required this.job});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: callback,
      child: Container(
        height: fullHeight(context) * .15,
        width: fullWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
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
            )
          ],
        ),
        child: Row(
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
                job.companyInitial,
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
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    job.company,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  Gap(8),
                  Flexible(
                    child: Row(
                      children: [
                        jobInfoChip(Hicons.workLightOutline, job.location),
                        Gap(6),
                        jobInfoChip(Hicons.workLightOutline, job.jobType),
                      ],
                    ),
                  ),
                  Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Icon(Hicons.timeCircle1LightOutline, size: 16),
                            Gap(3),
                            Expanded(
                              child: Text(
                                job.timePosted,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          job.salaryRange,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget jobInfoChip(IconData icon, String info) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.grey.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          Gap(4),
          Text(
              info,
              style: TextStyle(
              fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
        ],
      ),
    );
  }

}
