import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../function/repository/user_repository.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../login/login.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key, required this.screenIndex, required this.iconAnimationController, required this.callBackIndex}) : super(key:key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.home,
        labelName: AppString.homePageTitle,
        icon: AppString.homeIcon,
      ),
      DrawerList(
        index: DrawerIndex.teamManagement,
        labelName: AppString.teamManagementPageTitle,
        icon: AppString.groupIcon,
      ),
      DrawerList(
        index: DrawerIndex.contacts,
        labelName: AppString.contactPageTitle,
        icon: AppString.contactIcon,
      ),
      DrawerList(
        index: DrawerIndex.leads,
        labelName: AppString.leadPageTitle,
        icon: AppString.flagIcon,
      ),
      DrawerList(
        index: DrawerIndex.diary,
        labelName: AppString.diaryPageTitle,
        icon: AppString.diaryIcon,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                    child: Row(
                      children:  [
                        // FutureBuilder(
                        //   future: db.getCurrentUser(),
                        //   builder: (BuildContext context,
                        //       AsyncSnapshot<UserData?> snapshot) {
                        //     if (snapshot.hasError) {
                        //       return const Text("No Username",
                        //           style: AppTheme.titleFont);
                        //     } else if (!snapshot.hasData) {
                        //       return placeholderText();
                        //     } else {
                        //       return Column(
                        //         children: [
                        //           Text(snapshot.requireData!.full_name!,
                        //           style: AppTheme.titleFont),
                        //         ],
                        //       );
                        //     }
                        //   },
                        // ),
                        const CircleAvatar(
                          radius: AppTheme.radius15,
                          backgroundImage: NetworkImage(
                              'https://www.google.com/imgres?q=profile&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F003%2F715%2F527%2Fnon_2x%2Fpicture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Fvector-art%2F3715527-picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector&docid=jV8noe8xdKAwbM&tbnid=3nPRi6_QfknfYM&vet=12ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA'),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pageTitle('Naiem'),
                            Text('Product Manager')
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          AppTheme.divider,
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList!.length,
              itemBuilder: (BuildContext context, int index) {
                return drawerListGenerator(drawerList![index]);
              },
            ),
          ),
          AppTheme.divider,
          Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: 'RaleWay',
                    fontWeight: FontWeight.w600,
                    fontSize: AppTheme.fontBody,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  showAppDialog(
                      context,
                      alertDialog(context, signOut, "Sign Out",
                          "Are you sure you want to sign out?"));
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void signOut() {
    try {
      UserRepository.logout(context);
      showToastSuccess(context, "You have successfully signed out");
      Navigator.pushAndRemoveUntil(context,
          pageTransitionFadeThrough(const Login()), (route) => false);
    } on Exception catch (e) {
      showToastError(context, e.toString());
    }
  }

  Widget drawerListGenerator(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationToScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.screenIndex == listData.index
                          ? AppTheme.redMaroon
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? SizedBox(
                          width: AppTheme.sizeIconNav,
                          height: AppTheme.sizeIconNav,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? AppTheme.redMaroon
                                  : AppTheme.nearlyBlack),
                        )
                      // : Icon(listData.icon.icon, color: widget.screenIndex == listData.index ? Colors.blue : AppTheme.nearlyBlack),
                      : SvgPicture.asset(listData.icon,
                          color: widget.screenIndex == listData.index
                              ? AppTheme.redMaroon
                              : AppTheme.nearlyBlack,
                          height: AppTheme.sizeIconNav),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: AppTheme.fontTitle,
                      color: widget.screenIndex == listData.index
                          ? AppTheme.redMaroon
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppTheme.redMaroon.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

   Future<void> navigationToScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

enum DrawerIndex { home, teamManagement, contacts, leads, diary }

class DrawerList {
  String labelName;
  String icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;

  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    required this.icon,
    required this.index,
    this.imageName = '',
  });
}
