import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:heunets_assessment_app/features/dashboard/data/model/dashboard_model.dart';
import 'package:heunets_assessment_app/features/dashboard/presentation/widgets/dashboard_view.dart';
import 'package:heunets_assessment_app/features/home/presentation/pages/home_page.dart';
import 'package:heunets_assessment_app/features/job/presentation/pages/applied_jobs_page.dart';
import 'package:heunets_assessment_app/features/job/presentation/pages/post_job_page.dart';
import 'package:heunets_assessment_app/features/job/presentation/pages/profile_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
  }

  late final int _selectedIndex = widget.selectedIndex;
  List<DashboardModel> navigationBarItems = [
      DashboardModel(label: 'Home', icon: Hicons.home2LightOutline),
      DashboardModel(label: 'Post Job', icon: Hicons.addSquareLightOutline),
      DashboardModel(label: 'My Jobs', icon: Hicons.bag2LightOutline),
      DashboardModel(label: 'Profile', icon: Hicons.profile1LightOutline),
  ];

  final List<Widget> screens = <Widget>[
    HomePage(),
    PostJobPage(),
    MyJobsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardView(
      selectedIndex: _selectedIndex,
      screens: screens,
      navigationBarItems: navigationBarItems,
    );
  }
}
