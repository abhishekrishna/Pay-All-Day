import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/providers/apiv3/sendMoneyRow/to_wallet.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/screens/flash_deal_list.dart';
import 'package:active_ecommerce_flutter/screens/todays_deal_products.dart';
import 'package:active_ecommerce_flutter/screens/top_selling_products.dart';
import 'package:active_ecommerce_flutter/screens/category_products.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/ui_sections/drawer.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/electric_bill.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/mobile_recharge.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/all_services.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/mobile_recharge.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/my_wallet.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/passbook.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/send_to_contact.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_account.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_merchant.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_self.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:active_ecommerce_flutter/repositories/sliders_repository.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:shimmer/shimmer.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/ui_elements/product_card.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      "Add Money to Wallet\n     Get 50 to 100\n Free Shopping Coins",
      "      Get Cashback\nUpto 10% OR Rs. 500\n   On Adding Balance",
      "Convert Shooping\n       Coins\n     Into Wallet",
      "Cashback Wallet",
      "Voucher Wallet",
      "ADAIO \nCoin Wallet",
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
              context, MaterialPageRoute(builder: (ctx) => RechargeScreen()));
        case 1:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ElectricBill()));
        case 2:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToContactSend()));
        case 4:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToSelfScreen()));
        case 5:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToAccount()));
        case 6:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToWallet()));
        case 7:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ToMerchant()));
        case 8:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Passbook()));
        case 9:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => MyWallet()));

        default:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => AllServices()));
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
        // case 2:
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => ToContactSend()));
        // case 4:
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => ToSelfScreen()));
        // case 5:
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => ToAccount()));
        // case 6:
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => ToWallet()));
        // case 7:
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => ToMerchant()));
        // case 8:
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => Passbook()));
        // case 9:
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (ctx) => MyWallet()));

        default:
          return Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => AllServices()));
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
    //                 color: MyTheme.accent_color,
    //                 backgroundColor: Colors.white,
    //                 onRefresh: _onRefresh,
    //                 displacement: 0,
    //                 child: CustomScrollView(
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
        key: _scaffoldKey,
        drawer: MainDrawer(),
        appBar: buildAppBar(50, context),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              padding: const EdgeInsets.only(left: 20, right: 20),
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
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: mediaQuery.height * 0.12,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            // Create a grid with 2 columns. If you change the scrollDirection to
                            // horizontal, this produces 2 rows.
                            itemCount: iconImages.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 0.2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: InkWell(
                                  onTap: () => onTapSendMoney(index),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        iconImages[index],
                                        height: 55,
                                      ),
                                      Text(
                                        iconNames[index],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
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
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: mediaQuery.height * 0.16,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            // Create a grid with 2 columns. If you change the scrollDirection to
                            // horizontal, this produces 2 rows.
                            itemCount: iconImages2.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    iconImages2[index],
                                    height: 55,
                                  ),
                                  Text(
                                    iconNames2[index],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.height * 0.01,
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left: 20, top: 12),
                child: Text(
                  "Recharge and Bill Payment",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(500),
                        bottomRight: Radius.circular(500))),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SizedBox(
                        height: mediaQuery.height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages3.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
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
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: mediaQuery.height * 0.02,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.12,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(500),
                        bottomRight: Radius.circular(500))),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 20, top: 12),
                        child: Text(
                          "Brand Vouchers & Subscriptions",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SizedBox(
                        height: mediaQuery.height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages6.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      iconImages6[index],
                                      height: 55,
                                    ),
                                    Text(
                                      iconNames6[index],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.05,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.12,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(500),
                        bottomRight: Radius.circular(500))),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 20, top: 12),
                        child: Text(
                          "Investments & Financial Services",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SizedBox(
                        height: mediaQuery.height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages4.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      iconImages4[index],
                                      height: 55,
                                    ),
                                    Text(
                                      iconNames4[index],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SizedBox(
                        height: mediaQuery.height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages5.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      iconImages5[index],
                                      height: 55,
                                    ),
                                    Text(
                                      iconNames5[index],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 20),
                      child: SizedBox(
                        height: mediaQuery.height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages7.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      iconImages7[index],
                                      height: 55,
                                    ),
                                    Text(
                                      iconNames7[index],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQuery.height * 0.15)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(500),
                        bottomRight: Radius.circular(500))),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 20, top: 12),
                        child: Text(
                          "Travel & Transport Services",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SizedBox(
                        height: mediaQuery.height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages8.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      iconImages8[index],
                                      height: 55,
                                    ),
                                    Text(
                                      iconNames8[index],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: 20, top: 12),
                        child: Text(
                          "Booking Services",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SizedBox(
                        height: mediaQuery.height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages8.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      iconImages9[index],
                                      height: 55,
                                    ),
                                    Text(
                                      iconNames9[index],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height * 0.02,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: 20, top: 12),
                        child: Text(
                          "National",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SizedBox(
                        height: mediaQuery.height * 0.25,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: iconImages8.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [],
                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.12,
                    ),
                    //           Text(
                    //             AppLocalizations.of(context)
                    //                 .home_screen_featured_categories,
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ]),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(
                    //       16.0,
                    //       16.0,
                    //       0.0,
                    //       0.0,
                    //     ),
                    //     child: SizedBox(
                    //       height: 154,
                    //       child: buildHomeFeaturedCategories(context),
                    //     ),
                    //   ),
                    // ),
                    // SliverList(
                    //   delegate: SliverChildListDelegate([
                    //     Padding(
                    //       padding: const EdgeInsets.fromLTRB(
                    //         16.0,
                    //         16.0,
                    //         16.0,
                    //         0.0,
                    //       ),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             AppLocalizations.of(context)
                    //                 .home_screen_featured_products,
                    //             style: TextStyle(fontSize: 16),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     SingleChildScrollView(
                    //       child: Column(
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.fromLTRB(
                    //               4.0,
                    //               16.0,
                    //               8.0,
                    //               0.0,
                    //             ),
                    //             child: buildHomeFeaturedProducts(context),
                    //           ),
                  ],
                ),
              ),
              // Container(
              //   height: 80,
              // )
            )
          ]),
        ),
      ),
    );
    //                 ],
    //               ),
    //             ),
    //             Align(
    //                 alignment: Alignment.center,
    //                 child: buildProductLoadingContainer())
    //           ],
    //         )),
    //   ]),
    // )));
  }

  buildHomeFeaturedProducts(context) {
    if (_isProductInitial && _featuredProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: _featuredProductScrollController));
    } else if (_featuredProductList.length > 0) {
      //snapshot.hasData

      return GridView.builder(
        // 2
        //addAutomaticKeepAlives: true,
        itemCount: _featuredProductList.length,
        controller: _featuredProductScrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.618),
        padding: EdgeInsets.all(8),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // 3
          return ProductCard(
              id: _featuredProductList[index].id,
              image: _featuredProductList[index].thumbnail_image,
              name: _featuredProductList[index].name,
              main_price: _featuredProductList[index].main_price,
              stroked_price: _featuredProductList[index].stroked_price,
              has_discount: _featuredProductList[index].has_discount);
        },
      );
    } else if (_totalProductData == 0) {
      return Center(
          child: Text(
              AppLocalizations.of(context).common_no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
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
                    side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                  bottom: Radius.zero),
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
                                fontSize: 11, color: MyTheme.font_grey),
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

  buildHomeMenuRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CategoryList(
                is_top_category: true,
              );
            }));
          },
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/top_categories.png"),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    AppLocalizations.of(context).home_screen_top_categories,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(132, 132, 132, 1),
                        fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Filter(
                selected_filter: "brands",
              );
            }));
          },
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/brands.png"),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(AppLocalizations.of(context).home_screen_brands,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TopSellingProducts();
            }));
          },
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/top_sellers.png"),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                        AppLocalizations.of(context).home_screen_top_sellers,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TodaysDealProducts();
            }));
          },
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/todays_deal.png"),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                        AppLocalizations.of(context).home_screen_todays_deal,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FlashDealList();
            }));
          },
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 5 - 4,
            child: Column(
              children: [
                Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: MyTheme.light_grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/flash_deal.png"),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                        AppLocalizations.of(context).home_screen_flash_deal,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300))),
              ],
            ),
          ),
        )
      ],
    );
  }

  buildHomeCarouselSlider(context) {
    if (_isCarouselInitial && _carouselImageList.length == 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Shimmer.fromColors(
          baseColor: MyTheme.shimmer_base,
          highlightColor: MyTheme.shimmer_highlighted,
          child: Container(
            height: 120,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
      );
    } else if (_carouselImageList.length > 0) {
      return CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 2.67,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInCubic,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current_slider = index;
              });
            }),
        items: _carouselImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Stack(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder_rectangle.png',
                            image: AppConfig.BASE_PATH + i,
                            fit: BoxFit.fill,
                          ))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _carouselImageList.map((url) {
                        int index = _carouselImageList.indexOf(url);
                        return Container(
                          width: 7.0,
                          height: 7.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current_slider == index
                                ? MyTheme.white
                                : Color.fromRGBO(112, 112, 112, .3),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      );
    } else if (!_isCarouselInitial && _carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).home_screen_no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  PreferredSize buildAppBar(double statusBarHeight, BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        backgroundColor: Colors.white,
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
            height: 35,
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

  buildHomeSearchBox(BuildContext context) {
    return TextField(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Filter();
        }));
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context).home_screen_search,
          hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyTheme.textfield_grey, width: 0.5),
            borderRadius: const BorderRadius.all(
              const Radius.circular(16.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyTheme.textfield_grey, width: 1.0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(16.0),
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: MyTheme.textfield_grey,
              size: 20,
            ),
          ),
          contentPadding: EdgeInsets.all(0.0)),
    );
  }

  Container buildProductLoadingContainer() {
    return Container(
      height: _showProductLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalProductData == _featuredProductList.length
            ? AppLocalizations.of(context).common_no_more_products
            : AppLocalizations.of(context).common_loading_more_products),
      ),
    );
  }
}
