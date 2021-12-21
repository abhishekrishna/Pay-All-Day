import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
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
  int _currentIndex = 0;
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
                bottomNavigationBar: BottomAppBar(
                  // elevation: 0,
                  notchMargin: 10.0,
                  clipBehavior: Clip.antiAlias,
                  child: Stack(children: [
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: CustomPaint(
                        size: Size(SizeConfig.blockSizeHorizontal, 80),
                        painter: BNBCustomPainter(),
                      ),
                    ),
                    Center(
                      heightFactor: 0.01,
                      child: FloatingActionButton(
                          disabledElevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.shopping_basket),
                          elevation: 0.1,
                          onPressed: () {}),
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.home,
                                    size: 35,
                                    color: _currentIndex == 0
                                        ? Colors.indigo
                                        : Colors.grey.shade400,
                                  ),
                                  onPressed: () {
                                    onTapped(0);
                                  },
                                  splashColor: Colors.white,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      size: 35,
                                      color: _currentIndex == 1
                                          ? Colors.indigo
                                          : Colors.grey.shade400,
                                    ),
                                    onPressed: () {
                                      // onTapped(1);
                                    }),
                                Text(
                                  "More",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 0.20,
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.bookmark,
                                      size: 35,
                                      color: _currentIndex == 2
                                          ? Colors.indigo
                                          : Colors.grey.shade400,
                                    ),
                                    onPressed: () {
                                      onTapped(2);
                                    }),
                                Text(
                                  "Orders",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.list,
                                      size: 35,
                                      color: _currentIndex == 3
                                          ? Colors.indigo
                                          : Colors.grey.shade400,
                                    ),
                                    onPressed: () {
                                      onTapped(3);
                                    }),
                                Text(
                                  "Others",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ]),
                ))));
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

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
// © 2021 GitHub, Inc.
// Terms