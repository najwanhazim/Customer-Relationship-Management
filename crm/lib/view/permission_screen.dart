import 'package:crm/view/drawer/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../db/permission_list.dart';
import '../function/bloc/permission_bloc.dart';
import '../function/repository/app_permission.dart';
import '../utils/app_string_constant.dart';
import '../utils/app_theme_constant.dart';
import '../utils/app_widget_constant.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage>
    with SingleTickerProviderStateMixin {
  RoundedLoadingButtonController submitButtonController =
      RoundedLoadingButtonController();
  List<PermissionList>? _permissionList;
  bool permissionState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.grey,
        appBar: permissionAppBar("Application Permissions"),
        body: FocusDetector(
          onFocusGained: () => refreshPermissionList(null),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: AppTheme.padding16,
                  child: Text(AppString.permissionPageDescription,
                      style: AppTheme.bodyFontPrimary),
                ),
                permissionMainWidget(context),
              ],
            ),
          ),
        ));
  }

  Widget permissionMainWidget(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            BlocProvider(
              create: (context) => PermissionBloc(),
              child: BlocConsumer<PermissionBloc, PermissionState>(
                listener: (listenerContext, state) {
                  if (state is PermissionError) {
                    showToastError(context, state.message);
                  } else if (state is PermissionLoaded) {
                    permissionStateChange(state.permissionList);
                  }
                },
                builder: (blocContext, state) {
                  Widget widgetSpace;
                  if (state is PermissionLoading) {
                    widgetSpace = const CircularProgressIndicator();
                  } else {
                    if (_permissionList != null) {
                      widgetSpace = permissionExpandList(_permissionList!);
                    } else {
                      widgetSpace = const CircularProgressIndicator();
                    }
                  }
                  return Column(
                    children: [
                      widgetSpace,
                      const SizedBox(height: AppTheme.double16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: permissionState
                            ? buttonSubmitSuccess(
                                submitButtonController, "Proceed", goToMainPage)
                            : buttonSubmitPrimaryNoAnimate(
                                submitButtonController,
                                "Request Permission",
                                () => requestPermissionList(blocContext)),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: AppTheme.double16),
            buttonSubmitSecondaryNoAnimate(submitButtonController,
                "App Settings", () => {openAppSettings()}),
          ],
        ),
      ),
    );
  }

  Widget permissionExpandList(List<PermissionList> permissionList) {
    return ExpansionPanelList(
      elevation: 0,
      dividerColor: AppTheme.nearlyBlack,
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (index, isExpanded) {
        setState(() {
          permissionList[index].isExpanded = !isExpanded;
        });
      },
      animationDuration: const Duration(milliseconds: 600),
      children: permissionList
          .map(
            (item) => ExpansionPanel(
              canTapOnHeader: true,
              backgroundColor:
                  item.isExpanded ? AppTheme.nearlyWhite : AppTheme.white,
              headerBuilder: (_, isExpanded) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SvgPicture.asset(item.icon,
                            width: AppTheme.sizeIconButton,
                            color: AppTheme.darkText),
                      ),
                      Expanded(
                        child: Text(item.headerText,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.visible,
                            style: AppTheme.titlePrimary),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: SvgPicture.asset(
                            item.permissionState == PermissionStatus.granted
                                ? AppString.iconCheckedSlim
                                : AppString.iconCrossSlim,
                            width: AppTheme.sizeIconNav,
                            color:
                                item.permissionState == PermissionStatus.granted
                                    ? Colors.green
                                    : Colors.red),
                      ),
                    ],
                  ),
                );
              },
              body: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(item.descriptionText,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.visible,
                    style: AppTheme.bodyFontPrimary),
              ),
              isExpanded: item.isExpanded,
            ),
          )
          .toList(),
    );
  }

  void refreshPermissionList(BuildContext? blocContext) async {
    if (blocContext != null) {
      final permissionBloc = BlocProvider.of<PermissionBloc>(blocContext);
      permissionBloc.add(PermissionListener(_permissionList));
    } else {
      List<PermissionList> permissionList =
          await PermissionList.generatePermissionList();
      permissionStateChange(permissionList);
    }
  }

  bool determinePermissionState(List<PermissionList> permissionList) {
    for (PermissionList element in permissionList) {
      if (element.permissionState != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void permissionStateChange(List<PermissionList>? permissionList) {
    setState(() {
      _permissionList = permissionList;
      if (permissionList != null) {
        permissionState = determinePermissionState(permissionList);
      }
    });
  }

  void goToMainPage() {
    Navigator.pushAndRemoveUntil(
        context,
        pageTransitionFadeThrough(const NavigationHomeScreen()),
        (route) => false);
  }

  void requestPermissionList(BuildContext blocContext) async {
    print('test');
    List<Permission> permissionList = await getPermissionList();

    await permissionList.request();

    refreshPermissionList(blocContext);
  }
}
