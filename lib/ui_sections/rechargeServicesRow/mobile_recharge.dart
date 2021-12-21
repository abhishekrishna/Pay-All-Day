import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/custom_model/contacts_model.dart';
import 'package:active_ecommerce_flutter/data_model/operator_data_response.dart';
import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/repositories/operator_repository.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/mobile_recharge_amount.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/select_operator.dart';
import 'package:contacts_service/contacts_service.dart';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

enum MobileRechargeType { Prepaid, Postpaid }

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({Key key}) : super(key: key);

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final _formKey = GlobalKey<FormState>();
// enum types for recharge
  MobileRechargeType _changeType = MobileRechargeType.Prepaid;
  String _contact;
  Image _contactPhoto;
  // Boolean for Loader to Check operators
  bool isFetchingOperators = false;

  List planData = [];
  List _listOpData = [];
  FindMobileOperator operatorData = FindMobileOperator();
// Initialize Controller to auto hit api
  final TextEditingController searchController = TextEditingController();
  List<AppContact> contacts = [];
  List<AppContact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  AppContact contact = AppContact();
  // TextEditingController searchController = new TextEditingController();
  bool contactsLoaded = false;

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchController.dispose();
    super.dispose();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    List<AppContact> _contacts =
        (await ContactsService.getContacts()).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      return new AppContact(info: contact, color: baseColor);
    }).toList();
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  filterContacts() {
    List<AppContact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.info.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.info.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  _checkNumberValidation() {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      _sendDataToSecondScreen(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter Valid Number')),
      );
    }
    // _sendDataToSecondScreen(context)
  }

  _moveToPlansScreen() {
    String operatorLogo = operatorData.operatorIcon.toString();
    String operatorName = operatorData.operatorMatchedData.operatorName;
    String matchedMobile = searchController.text.toString();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MobileRechargeAmount(
                  text: matchedMobile,
                  operatorIcon: operatorLogo,
                  // operatorName: operatorName,
                )));
  }

  _moveToOperatorSelection() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => SelectMOperator(
                  number: searchController.text,
                )));
  }

  _findMobileOperator() async {
    // _checkNumberValidation();

    isFetchingOperators = true;
    var phoneNumber = searchController.text.toString();
    var rechargeService = "2";
    var rechargeServiceType = "3";
    var operatorResponse = await OperatorRepository().getOpeartorDataResponse(
        phoneNumber, rechargeService, rechargeServiceType);
    setState(() {
      operatorData = operatorResponse;
      isFetchingOperators = false;
      print(operatorData.toString());
    });

    if (operatorData.operatorIsMatched == true) {
      _moveToPlansScreen();
      // ToastComponent.showDialog(
      //     operatorResponse.data[0].operatorIsMatched.toString(), context,
      //     gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    } else if (operatorData.operatorIsMatched == false) {
      // _moveToPlansScreen();
      _moveToOperatorSelection();
      ToastComponent.showDialog(
          operatorResponse.data[1].operatorIsMatched.toString(), context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (ctx) => MobileRechargeAmount()));
    }
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.limited;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist =
        ((isSearching == true && contactsFiltered.length > 0) ||
            (isSearching != true && contacts.length > 0));
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xFF0288D1), Color(0xFF0D47A1)])),
          child: Row(
            children: [
              SizedBox(
                width: mediaQuery.width * 0.02,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mediaQuery.width * 0.25,
              ),
              Center(
                  child: Text(
                "Mobile Recharge",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.5),
              )),
            ],
          ),
          // automaticallyImplyLeading: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Radio(
                    value: MobileRechargeType.Prepaid,
                    groupValue: _changeType,
                    onChanged: (MobileRechargeType value) {
                      setState(() {
                        _changeType = value;
                      });
                    },
                  ),
                  Text("Prepaid"),
                  SizedBox(
                    width: mediaQuery.width * 0.10,
                  ),
                  Radio(
                    value: MobileRechargeType.Postpaid,
                    groupValue: _changeType,
                    onChanged: (MobileRechargeType value) {
                      setState(() {
                        _changeType = value;
                      });
                    },
                  ),
                  Text("Postpaid")
                ],
              ),
              SizedBox(height: mediaQuery.height * 0.02),
              isFetchingOperators
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 10,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 5,
                          ),
                          Text(
                            "Loading Plans",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // TextFormField(
                            //   // validator: (text) {
                            //   //   if (text == null || text.isEmpty) {
                            //   //     return 'Please enter your number';
                            //   //   }
                            //   //   return null;
                            //   // },
                            //   onChanged: (text) {
                            //     if (text.isEmpty) {
                            //       Toast.show("Enter Valid Number", context);
                            //     }
                            //     if (text.length == 10) {
                            //       _findMobileOperator();
                            //     }
                            //   },
                            //   inputFormatters: [
                            //     FilteringTextInputFormatter.digitsOnly
                            //   ],
                            //   validator: validateMobile,
                            //   keyboardType: TextInputType.number,
                            //   cursorHeight: 20,
                            //   controller: searchController,
                            //   decoration: InputDecoration(
                            //       // errorText: validateNumber(searchController.text),
                            //       // suffixIcon: InkWell(
                            //       //     onTap: () async {
                            //       //       // try {
                            //       //       //   Contact contact = await ContactsService
                            //       //       //       .openContactForm();
                            //       //       //   if (contact == null) {
                            //       //       //     getAllContacts();
                            //       //       //   }
                            //       //       // } on FormOperationException catch (e) {
                            //       //       //   switch (e.errorCode) {
                            //       //       //     case FormOperationErrorCode
                            //       //       //         .FORM_OPERATION_CANCELED:
                            //       //       //     case FormOperationErrorCode
                            //       //       //         .FORM_COULD_NOT_BE_OPEN:
                            //       //       //     case FormOperationErrorCode
                            //       //       //         .FORM_OPERATION_UNKNOWN_ERROR:
                            //       //       //       print(e.toString());
                            //       //       //   }
                            //       //       // }
                            //       //     },
                            //       //     child: Icon(
                            //       //       Icons.contact_phone,
                            //       //       color: MyTheme.soft_accent_color,
                            //       //     )),
                            //       // errorText: validateNumber(searchController.text),
                            //       hintText: 'Enter Mobile Number',
                            //       hintStyle: TextStyle(fontSize: 15),
                            //       border: OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //       )),
                            // ),

                            TextFormField(
                              onChanged: (text) {
                                if (text.isEmpty && text.length < 10) {
                                  Toast.show("Enter Valid Number", context);
                                }
                                if (text.length == 10) {
                                  _findMobileOperator();
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: validateMobile,
                              controller: searchController,
                              decoration: InputDecoration(
                                  hintText: "Enter Name or Mobile Number",
                                  // labelText: 'Search You Number',
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  prefixIcon: Icon(Icons.search,
                                      color: Theme.of(context).primaryColor)),
                            ),
                            SizedBox(height: mediaQuery.height * 0.04),
                            Text(
                              "Your Contacts",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(height: mediaQuery.height * 0.04),
                            SizedBox(height: mediaQuery.height * 0.04),
                            contactsLoaded == true
                                ? // if the contacts have not been loaded yet
                                listItemsExist == true
                                    ? // if we have contacts to show
                                    ContactsList(
                                        reloadContacts: () {
                                          getAllContacts();
                                        },
                                        contacts: isSearching == true
                                            ? contactsFiltered
                                            : contacts,
                                        searchController: searchController,
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(top: 40),
                                        child: Text(
                                          isSearching
                                              ? 'No search results to show'
                                              : 'No contacts exist',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 20),
                                        ))
                                : Container(
                                    // still loading contacts
                                    padding: EdgeInsets.only(top: 40),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                          ]))
            ]),
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.centerLeft,
      //           end: Alignment.centerRight,
      //           colors: <Color>[Color(0xFF0288D1), Color(0xFF0D47A1)]),
      //     ),
      //     child: MaterialButton(
      //       onPressed: () => {
      //         // _sendDataToSecondScreen(context),
      //         if (_formKey.currentState.validate())
      //           {
      //             // If the form is valid, display a snackbar. In the real world,
      //             // you'd often call a server or save the information in a database.
      //             _sendDataToSecondScreen(context),
      //           }
      //         else
      //           {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               const SnackBar(content: Text('Enter Valid Number')),
      //             )
      //           },
      //         // _sendDataToSecondScreen(context)
      //       },
      //       child: Text(
      //         "Continue",
      //         style: TextStyle(color: Colors.white, fontSize: 18),
      //       ),
      //     ),
      //   ),
      // ),
    ));
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  void _sendDataToSecondScreen(BuildContext context) {
    // String sendOperatorName = operatorData.operatorMatchedData.operatorName;

    String mobileNumber = searchController.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MobileRechargeAmount(
                  operatorId:
                      operatorData.operatorMatchedData.operatorId.toString(),
                  // operatorName: operatorData.operatorMatchedData.operatorName,
                  // keys: _formKey,
                  text: mobileNumber,
                  // operatorIcon:
                  //     operatorData.operatorMatchedData.operatorIcon.toString(),
                )));
  }
}

class ContactsList extends StatefulWidget {
  final TextEditingController searchController;
  final List<AppContact> contacts;
  Function() reloadContacts;
  ContactsList(
      {Key key, this.contacts, this.reloadContacts, this.searchController})
      : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) {
        AppContact contact = widget.contacts[index];

        return ListTile(
            onTap: () {
              //  searchController.text = contact.info.phones;
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => ContactDetails(
              //           contact,
              //           onContactDelete: (AppContact _contact) {
              //             reloadContacts();
              //             Navigator.of(context).pop();
              //           },
              //           onContactUpdate: (AppContact _contact) {
              //             reloadContacts();
              //           },
              //         )));
            },
            title: Text(contact.info.displayName),
            subtitle: Text(contact.info.phones.length > 0
                ? contact.info.phones.elementAt(0).value
                : ''),
            leading: ContactAvatar(contact, 36));
      },
    );
  }
}

class ContactAvatar extends StatelessWidget {
  ContactAvatar(this.contact, this.size);
  final AppContact contact;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle, gradient: getColorGradient(contact.color)),
        child: (contact.info.avatar != null && contact.info.avatar.length > 0)
            ? CircleAvatar(
                backgroundImage: MemoryImage(contact.info.avatar),
              )
            : CircleAvatar(
                child: Text(contact.info.initials(),
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.transparent));
  }
}

LinearGradient getColorGradient(Color color) {
  var baseColor = color as dynamic;
  Color color1 = baseColor[800];
  Color color2 = baseColor[400];
  return LinearGradient(colors: [
    color1,
    color2,
  ], begin: Alignment.bottomLeft, end: Alignment.topRight);
}

class ContactDetails extends StatefulWidget {
  ContactDetails(this.contact, {this.onContactUpdate, this.onContactDelete});

  final AppContact contact;
  final Function(AppContact) onContactUpdate;
  final Function(AppContact) onContactDelete;
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    List<String> actions = <String>['Edit', 'Delete'];

    showDeleteConfirmation() {
      Widget cancelButton = FlatButton(
        child: Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget deleteButton = FlatButton(
        color: Colors.red,
        child: Text('Delete'),
        onPressed: () async {
          await ContactsService.deleteContact(widget.contact.info);
          widget.onContactDelete(widget.contact);
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text('Delete contact?'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: <Widget>[cancelButton, deleteButton],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }

    onAction(String action) async {
      switch (action) {
        case 'Edit':
          try {
            Contact updatedContact =
                await ContactsService.openExistingContact(widget.contact.info);
            setState(() {
              widget.contact.info = updatedContact;
            });
            widget.onContactUpdate(widget.contact);
          } on FormOperationException catch (e) {
            switch (e.errorCode) {
              case FormOperationErrorCode.FORM_OPERATION_CANCELED:
              case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
              case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
                print(e.toString());
            }
          }
          break;
        case 'Delete':
          showDeleteConfirmation();
          break;
      }
      print(action);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Center(child: ContactAvatar(widget.contact, 100)),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton(
                        onSelected: onAction,
                        itemBuilder: (BuildContext context) {
                          return actions.map((String action) {
                            return PopupMenuItem(
                              value: action,
                              child: Text(action),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(shrinkWrap: true, children: <Widget>[
                ListTile(
                  title: Text("Name"),
                  trailing: Text(widget.contact.info.givenName ?? ""),
                ),
                ListTile(
                  title: Text("Family name"),
                  trailing: Text(widget.contact.info.familyName ?? ""),
                ),
                Column(
                  children: <Widget>[
                    ListTile(title: Text("Phones")),
                    Column(
                      children: widget.contact.info.phones
                          .map(
                            (i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListTile(
                                title: Text(i.label ?? ""),
                                trailing: Text(i.value ?? ""),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
