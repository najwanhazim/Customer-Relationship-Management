import 'package:animations/animations.dart';
import 'package:crm/utils/app_theme_constant.dart';
import 'package:crm/view/dashboard/dashboard_individual.dart';
import 'package:crm/view/drawer/navigation_home_screen.dart';
import 'package:crm/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:crm/function/repository/async_helper.dart';

import 'function/repository/app_route.dart';
import 'utils/app_string_constant.dart';
import 'view/permission_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeDateFormatting('en_GB');

  //check login status and default URL
  final prefs = await getSharedPreference();
  final bool checkLogin = prefs.containsKey(AppString.prefAccessToken);
  final bool checkURL = prefs.containsKey(AppString.prefServerAddress);
  final currentServerAddress = checkURL
      ? prefs.getString(AppString.prefServerAddress).toString()
      : AppString.defaultServer;

  //check permession
  final bool checkPermission = await checkPermissionList();
  runApp(MyApp(checkLogin, checkPermission, currentServerAddress));
}

class MyApp extends StatelessWidget {
  const MyApp(this.checkLogin, this.checkPermission, this.currentServerAddress, {Key? key})
      : super(key: key);

  final bool checkLogin;
  final bool checkPermission;
  final String currentServerAddress;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dale',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[500],
        platform: TargetPlatform.android,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
          },
        ),
        disabledColor: AppTheme.lightText,
      ),
      supportedLocales: const [
        Locale('en'),
      ],
      // localizationsDelegates: const [
      //     FormBuilderLocalizations.delegate,
      //   ],
      navigatorObservers: <NavigatorObserver>[routeObserver],
      home: !checkLogin
          ? const Login()
          : !checkPermission
              ? const PermissionPage()
              : const NavigationHomeScreen(),
    );
  }
}
