import 'package:crm/view/contact/contact_home_page.dart';
import 'package:crm/view/dashboard/dashboard_individual.dart';
import 'package:crm/view/leads/leads_home_page.dart';
import 'package:crm/view/team_management.dart/team_management_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_string_constant.dart';
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
  DrawerIndex drawerIndex = DrawerIndex.home;
  String accessToken = "";
  String userId = "";

  @override
  void initState() {
    super.initState();
    init();
    screenView = Placeholder();
  }

  Future<void> init() async {
    await initialData(); 
    setState(() {
      screenView = DashboardIndividual(userId: userId);
    });
  }

  Future<void> initialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(AppString.prefAccessToken)!;
    userId = prefs.getString(AppString.prefUserId)!;
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
    screenView = DashboardIndividual(userId: userId);
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
      switch (drawerIndexData) {
        case DrawerIndex.home:
          setState(() => screenView = DashboardIndividual(userId: userId));
          break;
        case DrawerIndex.teamManagement:
          setState(() => screenView = TeamManagementHomePage(userId: userId));
          break;
        case DrawerIndex.contacts:
          setState(() => screenView = ContactHomePage(userId: userId));
          break;
        case DrawerIndex.leads:
          setState(() => screenView = LeadsHomePage(userId: userId));
          break;
        case DrawerIndex.diary:
          setState(() => screenView = DiaryHomePage(userId: userId));
          break;
      }
    }
  }
}
