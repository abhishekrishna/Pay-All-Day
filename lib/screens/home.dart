import 'dart:ui';

import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/repositories/sliders_repository.dart';
import 'package:active_ecommerce_flutter/screens/qr_pay.dart';
import 'package:active_ecommerce_flutter/screens/wallet.dart';
import 'package:active_ecommerce_flutter/ui_sections/drawer.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/electric_bill.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/mobile_recharge.dart';
// import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/all_services.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/recharge.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/passbook.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/send_to_contact.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_account.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_self_screen.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_merchant.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_wallet.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/upi_pay.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

import '../app_config.dart';
import 'category_products.dart';
import 'home_eCommerce.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title, this.show_back_button = false, go_back = true})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  bool show_back_button;
  bool go_back;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _featuredProductScrollController;
  ScrollController _mainScrollController = ScrollController();

  var _carouselImageList = [];
  var _featuredCategoryList = [];
  var _featuredProductList = [];
  bool _isProductInitial = true;
  bool _isCategoryInitial = true;
  bool _isCarouselInitial = true;
  int _totalProductData = 0;
  int _productPage = 1;
  bool _showProductLoadingContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
    fetchAll();

    _mainScrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _productPage++;
        });
        _showProductLoadingContainer = true;
        fetchFeaturedProducts();
      }
    });
  }

  fetchAll() {
    fetchCarouselImages();
    fetchFeaturedCategories();
    fetchFeaturedProducts();
  }

  fetchCarouselImages() async {
    var carouselResponse = await SlidersRepository().getSliders();
    carouselResponse.sliders.forEach((slider) {
      _carouselImageList.add(slider.photo);
    });
    _isCarouselInitial = false;
    setState(() {});
  }

  fetchFeaturedCategories() async {
    var categoryResponse = await CategoryRepository().getFeturedCategories();
    _featuredCategoryList.addAll(categoryResponse.categories);
    _isCategoryInitial = false;
    setState(() {});
  }

  fetchFeaturedProducts() async {
    var productResponse = await ProductRepository().getFeaturedProducts(
      page: _productPage,
    );

    _featuredProductList.addAll(productResponse.products);
    _isProductInitial = false;
    _totalProductData = productResponse.meta.total;
    _showProductLoadingContainer = false;
    setState(() {});
  }

  reset() {
    _carouselImageList.clear();
    _featuredCategoryList.clear();
    _isCarouselInitial = true;
    _isCategoryInitial = true;

    setState(() {});

    resetProductList();
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  resetProductList() {
    _featuredProductList.clear();
    _isProductInitial = true;
    _totalProductData = 0;
    _productPage = 1;
    _showProductLoadingContainer = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mainScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> iconImages = [
      "assets/qrpay.png",
      "assets/upi.png",
      "assets/contact.png",
      "assets/self.png",
      "assets/tobank.png",
      "assets/wallet.png",
      "assets/merchant.png",
      "assets/passbook.png",
      "assets/mywallet.png",
      "assets/allservices.png"
    ];

    List<String> iconNames = [
      "Scan & Pay",
      "UPI",
      "To Contact",
      "To Self",
      "To Account",
      "To Wallet",
      "To Merchant",
      "Passbook",
      "My Wallet",
      "All Services"
    ];

    List<String> iconImages2 = [
      "assets/money2wallet.png",
      "assets/getcashback.png",
      "assets/shoppingcoins.png",
      "assets/cashbackwallet.png",
      "assets/voucherwallet.png",
      "assets/ADAIO.png",
      "assets/rehargewallet.png",
    ];
    List<String> iconNames2 = [
      "Add Money to Wallet Get 50 to 100 Free Shopping Coins",
      "Get Cashback Upto 10% OR Rs. 500 On Adding Balance",
      "Convert Shooping Coins Into Wallet",
      "Cashback Wallet",
      "Voucher Wallet",
      "ADAIO Coin Wallet",
      "Recharge Wallet",
    ];

    List<String> iconImages3 = [
      "assets/mobile.png",
      "assets/electricity.png",
      "assets/gas.png",
      "assets/dth.png",
      "assets/metro.png",
      "assets/loan.png",
      "assets/insurance.png",
      "assets/municipaltax.png",
      "assets/chalan.png",
      "assets/gas.png",
      "assets/cabletv.png"
    ];
    List<String> iconNames3 = [
      "Mobile\nReharge",
      "Electricity\nBill",
      "Gas\nCylinder",
      "DTH\nRecharge",
      "Metro\nRecharge",
      "Pay Loan\nEMI",
      "Pay Insurance\n   Premium",
      "Municipal\n   Tax",
      "    Pay\n Challan",
      "Piped\nGas",
      "Cable\nTV"
    ];
    List<String> iconImages4 = [
      "assets/emi.png",
      "assets/property.png",
      "assets/emi2.png",
      "assets/digitalgold.png",
      "assets/silver.png",
      "assets/stocks.png",
      "assets/forex.png",
      "assets/sip.png",
      "assets/ipo.png",
    ];

    List<String> iconNames4 = [
      "Bank EMI",
      "Property",
      "EMI",
      "Digital Gold",
      "Silver",
      "Stocks",
      "Forex",
      "SIP",
      "IPO",
    ];

    List<String> iconImages5 = [
      "assets/car.png",
      "assets/bike2.png",
      "assets/home.png",
      "assets/gold.png",
      "assets/property2.png",
      "assets/bondloan.png",
    ];

    List<String> iconNames5 = [
      "Car",
      "Bike",
      "Home",
      "Gold",
      "Property",
      "Bond Loan",
    ];

    List<String> iconImages6 = [
      "assets/flipkart.png",
      "assets/amazon.png",
      "assets/nykaa.png",
      "assets/myntra.png",
      "assets/biba.png",
      "assets/tanisq.png",
      "assets/kalyan.png",
      "assets/bigbazar.png",
      "assets/vmart.png",
      "assets/swiggy.png",
      "assets/zomato.png",
      "assets/foodpanda.png",
      "assets/prime.png",
      "assets/altbalaji.png",
      "assets/saavn.png",
      "assets/gaana.png",
      "assets/netflix.png",
    ];

    List<String> iconNames6 = [
      "Flipkart",
      "Amazon",
      "Nykaa",
      "Myntra",
      "BIBA",
      "Tanishq",
      "Kalyan",
      "Big Bazar",
      "V Mart",
      "Swiggy",
      "Zomato",
      "Food Panda",
      "Amazon Prime",
      "ALT Balaji",
      "Saavn",
      "Gaana",
      "Netflix",
    ];

    List<String> iconImages7 = [
      "assets/car2.png",
      "assets/bike3.png",
      "assets/personalacc.png",
      "assets/termlife.png",
      "assets/insurance2.png",
      "assets/renewal.png",
    ];

    List<String> iconNames7 = [
      "Car",
      "Bike",
      "Personal\nAccidental",
      "Term Life",
      "Insurance",
      "Renewal",
    ];

    List<String> iconImages8 = [
      "assets/bus.png",
      "assets/flight.png",
      "assets/cab.png",
      "assets/metro2.png",
      "assets/train.png",
    ];

    List<String> iconNames8 = [
      "Bus",
      "Flight",
      "Cab\nBooking",
      "Metro",
      "Train",
    ];

    List<String> iconImages9 = [
      "assets/tour.png",
      "assets/movie.png",
      "assets/event.png",
      "assets/fastag.png",
      "assets/fastag2.png",
    ];

    List<String> iconNames9 = [
      "Tour\nPackage",
      "Movie\nTicket",
      "Event\nTicket",
      "Fastag\nRecharge",
      "Buy\nFastag",
    ];

    Future onTapSendMoney(int index) {
      switch (index) {
        case 0:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => QRPay()));
        case 1:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => UPIScreen()));
        case 2:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToContactSend()));

        case 3:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToSelfScreen()));
        case 4:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToAccount()));
        case 5:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToWallet()));
        case 6:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToMerchant()));
        case 7:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Passbook()));
        case 8:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Wallet()));
        default:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToSelfScreen()));
      }
    }

    Future onTapRecharge(int index) {
      switch (index) {
        case 0:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => MobileRecharge()));
        case 1:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ElectricBill()));
        case 2:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToContactSend()));
        case 3:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToSelfScreen()));
        case 4:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToWallet()));
        case 5:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToWallet()));
        case 6:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToMerchant()));
        case 7:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Passbook()));
        case 8:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Wallet()));

        default:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToSelfScreen()));
      }
    }

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    //print(MediaQuery.of(context).viewPadding.top);

    final mediaQuery = MediaQuery.of(context).size;
    // return WillPopScope(
    //     onWillPop: () async {
    //       return widget.go_back;
    //     },
    //     child: Directionality(
    //         textDirection:
    //             app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
    //         child: Scaffold(
    //           key: _scaffoldKey,
    //           backgroundColor: Colors.white,
    //           appBar: buildAppBar(statusBarHeight, context),
    //           drawer: MainDrawer(),
    //           body: Stack(children: [
    //             RefreshIndicator(
    //               color: MyTheme.accent_color,
    //               backgroundColor: Colors.white,
    //               onRefresh: _onRefresh,
    //               displacement: 0,
    //               child: CustomScrollView(
    //                   controller: _mainScrollController,
    //                   physics: const BouncingScrollPhysics(
    //                       parent: AlwaysScrollableScrollPhysics()),
    //                   slivers: <Widget>[
    //                     SliverList(
    //                       delegate: SliverChildListDelegate(
    //                         [
    //                           Padding(
    //                             padding: const EdgeInsets.fromLTRB(
    //                               16.0,
    //                               16.0,
    //                               16.0,
    //                               0.0,
    //                             ),
    return SafeArea(
        child: Scaffold(
            // backgroundColor: Colors.blue.shade200,
            key: _scaffoldKey,
            drawer: MainDrawer(),
            appBar: buildAppBar(50, context),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                        height: mediaQuery.height * 0.12,
                        width: mediaQuery.width * 0.65,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xFF0288D1),
                                  Color(0xFF0D47A1)
                                ])),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Image.asset(
                              "assets/hsasset1.png",
                              height: 60,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              children: const [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Services Offers",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Recharge, Bills, Flights & \nMore",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 10,
                                        letterSpacing: 0.5))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.width * 0.10,
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: mediaQuery.height * 0.07,
                              width: mediaQuery.width * 0.12,
                              child: Image.asset("assets/hsasset2.png"),
                            ),
                          ),
                          SizedBox(
                            height: mediaQuery.height * 0.01,
                          ),
                          const Text(
                            "Add Funds",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: mediaQuery.height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        height: mediaQuery.height * 0.15,
                        width: mediaQuery.width * 0.65,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xFF00796B),
                                  Color(0xFF311B92)
                                ])),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/hsasset3.png",
                              height: 60,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              children: const [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Send Money \nEasily",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Easily transfer funds \nto other users",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontSize: 8,
                                        letterSpacing: 0.5))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.width * 0.10,
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: mediaQuery.height * 0.07,
                              width: mediaQuery.width * 0.12,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/hsasset6.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaQuery.height * 0.01,
                          ),
                          const Text(
                            "Rewards",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: mediaQuery.height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        height: mediaQuery.height * 0.12,
                        width: mediaQuery.width * 0.65,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xFF0288D1),
                                  Color(0xFF0D47A1)
                                ])),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/hsasset4.png",
                              height: 60,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              children: const [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Scan & Pay",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Pay to Friends, Vendors,\nShop & More",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 10,
                                        letterSpacing: 0.5))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.width * 0.10,
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: mediaQuery.height * 0.07,
                              width: mediaQuery.width * 0.12,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/rewards.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaQuery.height * 0.01,
                          ),
                          const Text(
                            "Payouts",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: mediaQuery.height * 0.06,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "SEND MONEY",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.01,
                            ),
                            const Text(
                              "From Your Bank A/C or Wallet",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.3),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.5 / 1.5,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames[index],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            const Text(
                              "Wallet Details",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.24,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages2.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 3.5 / 1.8,
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages2[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames2[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 0, top: 10),
                                child: Text(
                                  "Recharge and Bill Payment",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages3.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8 / 1.9,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapRecharge(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages3[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames3[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            Image.asset(
                              "assets/banner.jpg",
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 20, top: 12),
                                child: Text(
                                  "Brand Vouchers & Subscriptions",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages6.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8 / 1.9,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages6[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames6[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 20, top: 12),
                                child: Text(
                                  "Investments & Financial Services",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages4.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8 / 1.9,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages4[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames4[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Text(
                                  "Loan",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages5.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8 / 1.9,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages5[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames5[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Insurance",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages7.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8 / 1.9,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages7[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames7[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 20, top: 12),
                                child: Text(
                                  "Travel & Transport Services",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages8.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8 / 1.9,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages8[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames8[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 0, top: 12),
                                child: Text(
                                  "Booking Services",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )),
                            SizedBox(
                              height: mediaQuery.height * 0.02,
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.18,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // Create a grid with 2 columns. If you change the scrollDirection to
                                      // horizontal, this produces 2 rows.
                                      itemCount: iconImages9.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8 / 1.9,
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 0.2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () => onTapSendMoney(index),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  iconImages9[index],
                                                  height: 55,
                                                ),
                                                Text(
                                                  iconNames9[index],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .home_screen_shopping_categories,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: MyTheme.accent_color,
                                            shape: StadiumBorder()),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) => Home2()));
                                        },
                                        child: Text("View All +")),
                                  )
                                ],
                              ),
                            ),
                            ShapeOfView(
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 20,
                                  position: ArcPosition.Bottom),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 22),
                                child: SizedBox(
                                  height: mediaQuery.height * 0.20,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        // Create a grid with 2 columns. If you change the scrollDirection to
                                        // horizontal, this produces 2 rows.
                                        itemCount: _featuredCategoryList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                // crossAxisSpacing: 5,
                                                // mainAxisSpacing: 2.0,
                                                childAspectRatio: 3 / 2),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                child: ClipOval(
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        'assets/placeholder.png',
                                                    image: AppConfig.BASE_PATH +
                                                        _featuredCategoryList[
                                                                index]
                                                            .banner,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 8, 8, 4),
                                                child: Container(
                                                  height: 32,
                                                  child: Text(
                                                    _featuredCategoryList[index]
                                                        .name,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height * 0.12,
                            ),
                            Container(
                              height: 80,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: buildProductLoadingContainer())
                          ]))
                ]))));
  }

  buildHomeFeaturedCategories(context) {
    if (_isCategoryInitial && _featuredCategoryList.length == 0) {
      return Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
        ],
      );
    } else if (_featuredCategoryList.length > 0) {
      //snapshot.hasData
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _featuredCategoryList.length,
          itemExtent: 120,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CategoryProducts(
                      category_id: _featuredCategoryList[index].id,
                      category_name: _featuredCategoryList[index].name,
                    );
                  }));
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(
                        color: MyTheme.soft_accent_color, width: 1.0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 0.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          //width: 100,
                          height: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular((20)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/placeholder.png',
                                image: AppConfig.BASE_PATH +
                                    _featuredCategoryList[index].banner,
                                fit: BoxFit.cover,
                              ))),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Container(
                          height: 32,
                          child: Text(
                            _featuredCategoryList[index].name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: MyTheme.accent_color),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else if (!_isCategoryInitial && _featuredCategoryList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).home_screen_no_category_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Container buildProductLoadingContainer() {
    return Container(
      height: _showProductLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: MyTheme.grey_153,
      child: Center(
        child: Text(_totalProductData == _featuredProductList.length
            ? AppLocalizations.of(context).common_no_more_products
            : AppLocalizations.of(context).common_loading_more_products),
      ),
    );
  }

  PreferredSize buildAppBar(double statusBarHeight, BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        backgroundColor: MyTheme.white,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: widget.show_back_button
              ? Builder(
                  builder: (context) => IconButton(
                      icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                      onPressed: () {
                        if (!widget.go_back) {
                          return;
                        }
                        return Navigator.of(context).pop();
                      }),
                )
              : Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 0.0),
                    child: Container(
                      child: Image.asset(
                        'assets/hamburger.png',
                        height: 16,
                        //color: MyTheme.dark_grey,
                        color: MyTheme.dark_grey,
                      ),
                    ),
                  ),
                ),
        ),
        title: Container(
          child: Image.asset(
            "assets/logocol.png",
            height: 40,
          ),

          // height: kToolbarHeight +
          //     statusBarHeight -
          //     (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),
          // MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
          // child: Container(
          //   child: Padding(
          //       padding: app_language_rtl.$
          //           ? const EdgeInsets.only(top: 14.0, bottom: 14, left: 12)
          //           : const EdgeInsets.only(top: 14.0, bottom: 14, right: 12),
          //       // when notification bell will be shown , the right padding will cease to exist.
          //       child: GestureDetector(
          //           onTap: () {
          //             Navigator.push(context,
          //                 MaterialPageRoute(builder: (context) {
          //               return Filter();
          //             }));
          //           },
          //           child: buildHomeSearchBox(context))),
          // ),
        ),
        elevation: 2.0,
        titleSpacing: 0,
        actions: <Widget>[
          Visibility(
            visible: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 22,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Icon(
                Icons.search,
                size: 22,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Icon(
                Icons.qr_code,
                size: 22,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 22,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
