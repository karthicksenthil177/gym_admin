import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/assign/assign.dart';
import 'package:gym_admin/dashboard/attendance/attendance.dart';
import 'package:gym_admin/dashboard/bottom_navigation_bar/fab_bar_item.dart';
import 'package:gym_admin/dashboard/bottom_navigation_bar/gbutton.dart';
import 'package:gym_admin/dashboard/bottom_navigation_bar/gnav.dart';
import 'package:gym_admin/dashboard/user_upload/home.dart';
import 'package:gym_admin/dashboard/settings/settings.dart';
import 'package:gym_admin/util.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _selectedIndex = 0;
  final items = [
    FABBottomAppBarItem(iconData: Icons.set_meal, text: "Meal"),
    FABBottomAppBarItem(iconData: Icons.fitness_center, text: "Workout"),
    FABBottomAppBarItem(iconData: Icons.assessment, text: "Assessment"),
    FABBottomAppBarItem(iconData: Icons.calendar_today, text: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPaddingSize,
                    vertical: defaultPaddingSize / 1.5),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.grey,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.checklist_rtl_rounded,
                    text: 'Attendances',
                  ),
                  GButton(
                    icon: Icons.add_task,
                    text: 'Assign',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: dependsOnScreen());
  }

  Widget bottomBar() {
    return FABBottomAppBar(
      items: items,
      notchedShape: const CircularNotchedRectangle(),
      onTabSelected: (int value) {},
    );
  }

  dependsOnScreen() {
    Widget widget;
    switch (_selectedIndex) {
      case 0:
        widget = const Home();
        break;
      case 1:
        widget = const Attendance();
        break;
      case 2:
        widget = const Assign();
        break;
      case 3:
        widget = const Settings();
        break;
      default:
        widget = const Home();
    }
    return widget;
  }
}
