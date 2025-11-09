import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heunets_assessment_app/core/resources/styles/app_colors.dart';
import 'package:heunets_assessment_app/core/resources/styles/padding.dart';
import 'package:heunets_assessment_app/features/dashboard/data/model/dashboard_model.dart';


class DashboardView extends StatefulWidget {
  const DashboardView({
    super.key,
    this.selectedIndex = 0,
    required this.screens,
    required this.navigationBarItems,
  });

  final int selectedIndex;
  final List<Widget> screens;
  final List<DashboardModel> navigationBarItems;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late int _selectedIndex = widget.selectedIndex;
  late List<DashboardModel> navigationBarItems;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    navigationBarItems = widget.navigationBarItems;
    screens = widget.screens;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedFontSize: ScreenUtil().scaleWidth > 0 ? 10.sp : 10,
        unselectedFontSize: ScreenUtil().scaleWidth > 0 ? 10.sp : 10,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grey,
        items: List.generate(
          navigationBarItems.length,
          (index) {
            final item = navigationBarItems[index];
            return _navigationBarItem(
              icon: item.icon,
              label: item.label,
            );
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _navigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.vertical * 0.3),
        child: Icon(
          icon,
         size: 30,
          color: AppColors.black,
        ),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.vertical * 0.3),
        child: Icon(
          icon,
          size: 30,
          color: AppColors.primaryColor,
        ),
      ),
      label: label,
    );
  }
}
