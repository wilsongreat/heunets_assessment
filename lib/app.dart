import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/config/app/app_providers_wrapper.dart';
import 'package:heunets_assessment_app/features/dashboard/presentation/views/dashboard_screen.dart';

class HeunetsJobApp extends StatelessWidget {
  const HeunetsJobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppProvidersWrapper(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (BuildContext context, _) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            child: MaterialApp(
              title: 'heunets',
              debugShowCheckedModeBanner: false,
              home: DashboardScreen(selectedIndex: 0,),
            ),
          );
        },
      ),
    );
  }
}
