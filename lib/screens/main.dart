import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
// import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'home_eCommerce.dart';

class Main extends StatefulWidget {
  Main({Key key, go_back = true}) : super(key: key);

  bool go_back;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  var _bottomNavIndex = 0; //default index of a first screen
  final autoSizeGroup = AutoSizeGroup();
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  List<Widget> _children = [
    Home(),
    Home2(go_back: true, show_back_button: true, title: "Products"),
    CategoryList(
      is_base_category: true,
    ),
    OrderList(from_checkout: false),
  ];

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.search_outlined,
    Icons.shopping_bag_outlined,
    Icons.other_houses_outlined,
  ];

  final iconName = <String>["Home", "More", "Travels", "Others"];
  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  void initState() {
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    // _children = [
    //   Home(),
    //   Home2(),
    //   CategoryList(
    //     is_base_category: true,
    //   ),
    //   OrderList(from_checkout: false),
    // ];

    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
          return widget.go_back;
        },
        child: Directionality(
          textDirection:
              app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            // key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: IndexedStack(
              index: _currentIndex,
              children: _children,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            //specify the location of the FAB
            floatingActionButton: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom ==
                  0.0, // if the kyeboard is open then hide, else show
              child: FloatingActionButton(
                backgroundColor: MyTheme.accent_color,
                onPressed: () {},
                tooltip: "start FAB",
                child: Container(
                    margin: EdgeInsets.all(0.0),
                    child: IconButton(
                        icon: new Image.asset('assets/fingerprint.png'),
                        tooltip: 'Action',
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Filter(
                              selected_filter: "sellers",
                            );
                          }));
                        })),
                elevation: 0.0,
              ),
            ),
            // bottomNavigationBar: BottomAppBar(
            //   elevation: 10,
            //   notchMargin: 20,
            //   shape: AutomaticNotchedShape(RoundedRectangleBorder(),
            //       StadiumBorder(side: BorderSide(color: Colors.blue))),
            //   child: Container(
            //     height: SizeConfig.safeBlockVertical * 15,
            //     child: BottomNavigationBar(
            //       // color: Colors.white,
            //       // animationCurve: Curves.fastLinearToSlowEaseIn,
            //       items: [
            //         BottomNavigationBarItem(
            //             icon: Icon(Icons.home_outlined), label: "Home"),
            //         BottomNavigationBarItem(
            //             icon: Icon(Icons.search), label: "Search")
            //         // Column(
            //         //   mainAxisAlignment: MainAxisAlignment.end,
            //         //   children: [
            //         //     SizedBox(
            //         //       height: 10,
            //         //     ),
            //         //     Icon(Icons.home_outlined, size: 30),
            //         //     // SizedBox(
            //         //     //   height: 10,
            //         //     // ),
            //         //     // Text(
            //         //     //   "Home",
            //         //     //   style: TextStyle(color: Colors.black),
            //         //     // )
            //         //   ],
            //         // ),
            //         // Icon(
            //         //   Icons.list,
            //         //   size: 30,
            //         // ),
            //         // // Icon(Icons.compare_arrows, size: 30),
            //         // Icon(Icons.call_split, size: 30),
            //         // Icon(Icons.perm_identity, size: 30),
            //       ],
            //     ),
            //   ),
            // ),
            // bottomNavigationBar: BubbleBottomBar(
            //   opacity: .2,
            //   currentIndex: _currentIndex,
            //   // onTap: changePage,
            //   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            //   elevation: 8,
            //   fabLocation: BubbleBottomBarFabLocation.end, //new
            //   hasNotch: true, //new
            //   hasInk: true, //new, gives a cute ink effect
            //   inkColor:
            //       Colors.black12, //optional, uses theme color if not specified
            //   items: <BubbleBottomBarItem>[
            //     BubbleBottomBarItem(
            //         backgroundColor: Colors.red,
            //         icon: Icon(
            //           Icons.dashboard,
            //           color: Colors.black,
            //         ),
            //         activeIcon: Icon(
            //           Icons.dashboard,
            //           color: Colors.red,
            //         ),
            //         title: Text("Home")),
            //     BubbleBottomBarItem(
            //         backgroundColor: Colors.deepPurple,
            //         icon: Icon(
            //           Icons.access_time,
            //           color: Colors.black,
            //         ),
            //         activeIcon: Icon(
            //           Icons.access_time,
            //           color: Colors.deepPurple,
            //         ),
            //         title: Text("Logs")),
            //     BubbleBottomBarItem(
            //         backgroundColor: Colors.indigo,
            //         icon: Icon(
            //           Icons.folder_open,
            //           color: Colors.black,
            //         ),
            //         activeIcon: Icon(
            //           Icons.folder_open,
            //           color: Colors.indigo,
            //         ),
            //         title: Text("Folders")),
            //     BubbleBottomBarItem(
            //         backgroundColor: Colors.green,
            //         icon: Icon(
            //           Icons.menu,
            //           color: Colors.black,
            //         ),
            //         activeIcon: Icon(
            //           Icons.menu,
            //           color: Colors.green,
            //         ),
            //         title: Text("Menu"))
            //   ],
            // ),
            //     bottomNavigationBar: BubbleBottomBar(
            //   opacity: .2,
            //   currentIndex: currentIndex,
            //   onTap: changePage,
            //   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            //   elevation: 8,
            //   fabLocation: BubbleBottomBarFabLocation.end, //new
            //   hasNotch: true, //new
            //   hasInk: true //new, gives a cute ink effect
            //   inkColor: Colors.black12 //optional, uses theme color if not specified
            //   items: <BubbleBottomBarItem>[
            //       BubbleBottomBarItem(backgroundColor: Colors.red, icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.dashboard, color: Colors.red,), title: Text("Home")),
            //       BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.access_time, color: Colors.black,), activeIcon: Icon(Icons.access_time, color: Colors.deepPurple,), title: Text("Logs")),
            //       BubbleBottomBarItem(backgroundColor: Colors.indigo, icon: Icon(Icons.folder_open, color: Colors.black,), activeIcon: Icon(Icons.folder_open, color: Colors.indigo,), title: Text("Folders")),
            //       BubbleBottomBarItem(backgroundColor: Colors.green, icon: Icon(Icons.menu, color: Colors.black,), activeIcon: Icon(Icons.menu, color: Colors.green,), title: Text("Menu"))
            //   ],
            // ),
            bottomNavigationBar: ClipRRect(
              child: BottomAppBar(
                // elevation: 0,
                notchMargin: 10.0,
                clipBehavior: Clip.antiAlias,
                child: AnimatedBottomNavigationBar.builder(
                  height: 80,
                  // elevation: 10,
                  splashColor: Colors.indigo,
                  itemCount: iconList.length,
                  tabBuilder: (int index, bool isActive) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            iconList[index],
                            size: 34,
                            color: MyTheme.accent_color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AutoSizeText(
                            iconName[index],
                            maxLines: 1,
                            style: TextStyle(color: MyTheme.accent_color),
                            group: autoSizeGroup,
                          ),
                        )
                      ],
                    );
                  },
                  backgroundColor: Colors.indigo.shade100,

                  activeIndex: _currentIndex,
                  // notchAndCornersAnimation: animation,
                  splashSpeedInMilliseconds: 100,
                  notchSmoothness: NotchSmoothness.verySmoothEdge,
                  notchAndCornersAnimation: animation,
                  gapLocation: GapLocation.center,
                  leftCornerRadius: 32,
                  rightCornerRadius: 32,
                  onTap: (index) => setState(() => _currentIndex = index),
                ),
              ),
            ),
          ),
        ));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
