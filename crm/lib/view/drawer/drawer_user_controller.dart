import 'package:crm/utils/app_string_constant.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import 'home_drawer.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController(
      {Key? key,
      this.drawerWidth = 250,
      required this.onDrawerCall,
      required this.screenView,
      this.animatedIconData = AnimatedIcons.arrow_menu,
      required this.screenIndex})
      : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex) onDrawerCall;
  final Widget screenView;
  final AnimatedIconData animatedIconData;
  final DrawerIndex screenIndex;

  @override
  State<DrawerUserController> createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  late ScrollController scrollController;
  late AnimationController iconAnimationController;
  late AnimationController animationController;

  final Cubic scrollCurve = Curves.fastOutSlowIn;
  final Duration scrollDuration = const Duration(milliseconds: 400);
  double scrollOffSet = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.linear);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        if (scrollOffSet != 1.0) {
          setState(() {
            scrollOffSet = 1.0;
          });
        }
        iconAnimationController.animateTo(0.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else if (scrollController.offset > 0 &&
          scrollController.offset < widget.drawerWidth.floor()) {
        iconAnimationController.animateTo(
            (scrollController.offset * 100 / (widget.drawerWidth)) / 100,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else {
        if (scrollOffSet != 0.0) {
          setState(() {
            scrollOffSet = 0.0;
          });
        }
        iconAnimationController.animateTo(1.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          //we use with as screen width and add drawerWidth (from navigation_home_screen)
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.drawerWidth,
                //we divided first drawer Width with HomeDrawer and second full-screen Width with all home screen, we called screen View
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      //transform we use for the stable drawer  we, not need to move with scroll view
                      transform: Matrix4.translationValues(
                          scrollController.offset, 0.0, 0.0),
                      child: HomeDrawer(
                        screenIndex: widget.screenIndex,
                        iconAnimationController: iconAnimationController,
                        callBackIndex: (DrawerIndex indexType) {
                          onDrawerClick();
                          try {
                            widget.onDrawerCall(indexType);
                          } catch (e) {
                            showToastError(context, e.toString());
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //full-screen Width with widget.screenView
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.6),
                          blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      //this IgnorePointer we use as touch(user Interface) widget.screen View, for example scrolloffset == 1 means drawer is close we just allow touching all widget.screen View
                      IgnorePointer(
                        ignoring: scrollOffSet == 1 || false,
                        child: widget.screenView,
                      ),
                      //alternative touch(user Interface) for widget.screen, for example, drawer is close we need to tap on a few home screen area and close the drawer
                      if (scrollOffSet == 1.0)
                        InkWell(
                          onTap: () {
                            onDrawerClick();
                          },
                        ),
                      // this just menu and arrow icon animation
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top +
                                AppTheme.paddingInt,
                            left: AppTheme.paddingDouble),
                        child: SizedBox(
                          width: AppBar().preferredSize.height -
                              AppTheme.paddingInt,
                          height: AppBar().preferredSize.height -
                              AppTheme.paddingInt,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              // child: const Text('ICON HERE'),
                              child: Center(
                                child: //Icon(widget.icon),
                                    AnimatedIcon(
                                        icon: widget.animatedIconData,
                                        progress: iconAnimationController,
                                        color: Colors.white,),
                              ),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                onDrawerClick();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDrawerClick() {
    if (scrollController.offset != widget.drawerWidth) {
      scrollController.animateTo(widget.drawerWidth,
          duration: scrollDuration, curve: scrollCurve);
    } else {
      scrollController.animateTo(0.0,
          duration: scrollDuration, curve: scrollCurve);
    }
  }
}
