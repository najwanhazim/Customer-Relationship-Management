import 'package:crm/view/contact/contact_home_page.dart';
import 'package:crm/view/dashboard/dashboard_individual.dart';
import 'package:crm/view/leads/leads_home_page.dart';
import 'package:crm/view/team_management.dart/team_management_home_page.dart';
import 'package:flutter/material.dart';

import '../diary/diary_home_page.dart';
import 'drawer_user_controller.dart';
import 'home_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  late Widget screenView;
  late DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.home;
    screenView = const DashboardIndividual();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexData) {
              changeIndex(drawerIndexData);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexData) {
    screenView = const DashboardIndividual();
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
      switch (drawerIndexData) {
        case DrawerIndex.home:
          setState(() => screenView = const DashboardIndividual());
          break;
        case DrawerIndex.teamManagement:
          setState(() => screenView = const TeamManagementHomePage());
          break;
        case DrawerIndex.contacts:
          setState(() => screenView = const ContactHomePage());
          break;
        case DrawerIndex.leads:
          setState(() => screenView = const LeadsHomePage());
          break;
        case DrawerIndex.diary:
          setState(() => screenView = const DiaryHomePage());
          break;
      }
    }
  }
}
