import 'package:flutter/material.dart';
import '../pages/delivery_addresses.dart';
import '../pages/help.dart';
import '../pages/languages.dart';
import '../pages/login.dart';
import '../pages/orders.dart';
import '../pages/signup.dart';
import '../controllers/profile_controller.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../pages/map.dart';
import '../pages/profile_edit.dart';
import '../repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../repository/user_repository.dart';
import 'campaign.dart';
import '../pages/favorites.dart';

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  ProfileController _con;

  _SettingsWidgetState() : super(ProfileController()) {
    _con = controller;
  }

  void _effect() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          leading: Container(),
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).focusColor.withOpacity(0.3),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Hesabım',
            style: TextStyle(
                color: Color.fromRGBO(255, 228, 121, 1), fontFamily: 'rbt'),
          ),
        ),
        body: currentUser.value.id == null
            ? PermissionDeniedWidget()
            : ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: false).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileEditPage(
                                  user: currentUser,
                                  effectFunc: _effect,
                                ),
                            fullscreenDialog: false),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.15),
                                offset: Offset(0, 2),
                                blurRadius: 5.0)
                          ]),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  currentUser.value.name,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Text(
                                  currentUser.value.email,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                //Text(
                                //                                   currentUser.value.phone,
                                //                                   textAlign: TextAlign.left,
                                //                                   style: Theme.of(context).textTheme.caption,
                                //                                 ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          SizedBox(
                              width: 55,
                              height: 55,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/img/empty_user.png'),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 14,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, 2),
                          blurRadius: 5.0)
                    ]),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DeliveryAddressesWidget(),
                                  fullscreenDialog: true),
                            );
                          },
                          title: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color:
                                    Theme.of(context).focusColor.withOpacity(1),
                              ),
                              SizedBox(width: 16),
                              Text(
                                S.of(context).delivery_addresses,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 0.8,
                          color: Color.fromRGBO(223, 225, 229, 1),
                        ),

                        ListTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Theme.of(context).focusColor,
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: false).push(
                              MaterialPageRoute(
                                  builder: (context) => CampaignScreen(),
                                  fullscreenDialog: false),
                            );
                          },
                          title: Row(
                            children: [
                              Icon(
                                Icons.stars,
                                color:
                                    Theme.of(context).focusColor.withOpacity(1),
                              ),
                              SizedBox(width: 16),
                              Text(
                                "Kampanyalarım",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 0.8,
                          color: Color.fromRGBO(223, 225, 229, 1),
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Theme.of(context).focusColor,
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: false).push(
                              MaterialPageRoute(
                                  builder: (context) => FavoritesWidget(),
                                  fullscreenDialog: false),
                            );
                          },
                          title: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color:
                                    Theme.of(context).focusColor.withOpacity(1),
                              ),
                              SizedBox(width: 16),
                              Text(
                                S.of(context).favorite_products,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 0.8,
                          color: Color.fromRGBO(223, 225, 229, 1),
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Theme.of(context).focusColor,
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: false).push(
                              MaterialPageRoute(
                                  builder: (context) => OrdersWidget(),
                                  fullscreenDialog: false),
                            );
                          },
                          title: Row(
                            children: [
                              Icon(
                                Icons.local_mall,
                                color:
                                    Theme.of(context).focusColor.withOpacity(1),
                              ),
                              SizedBox(width: 16),
                              Text(
                                S.of(context).my_orders,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 0.8,
                          color: Color.fromRGBO(223, 225, 229, 1),
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Theme.of(context).focusColor,
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => MapWidget(),
                                  fullscreenDialog: true),
                            );
                          },
                          title: Row(
                            children: [
                              Icon(
                                Icons.store_mall_directory,
                                color:
                                    Theme.of(context).focusColor.withOpacity(1),
                              ),
                              SizedBox(width: 16),
                              Text(
                                "Marketler",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 0.8,
                          color: Color.fromRGBO(223, 225, 229, 1),
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Theme.of(context).focusColor,
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: false).push(
                              MaterialPageRoute(
                                  builder: (context) => HelpWidget(),
                                  fullscreenDialog: false),
                            );
                          },
                          title: Row(
                            children: [
                              Icon(
                                Icons.help,
                                color:
                                    Theme.of(context).focusColor.withOpacity(1),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'SSS',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 0.8,
                          color: Color.fromRGBO(223, 225, 229, 1),
                        ),
                        //ListTile(
                        //                           trailing: Icon(
                        //                             Icons.keyboard_arrow_right,
                        //                             size: 24,
                        //                             color: Theme.of(context).focusColor,
                        //                           ),
                        //                           onTap: () {
                        //                             Navigator.push(
                        //                               context,
                        //                               MaterialPageRoute(
                        //                                 builder: (context) => ConnectionPage(),
                        //                               ),
                        //                             );
                        //                           },
                        //                           title: Row(
                        //                             children: [
                        //                               Icon(
                        //                                 Icons.phone,
                        //                                 color:
                        //                                     Theme.of(context).focusColor.withOpacity(1),
                        //                               ),
                        //                               SizedBox(width: 16),
                        //                               Text(
                        //                                 "İletişim",
                        //                                 style: Theme.of(context).textTheme.subtitle1,
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                         Container(
                        //                           width: MediaQuery.of(context).size.width - 40,
                        //                           height: 0.8,
                        //                           color: Color.fromRGBO(223, 225, 229, 1),
                        //                         ),
                        //ListTile(
                        //                           trailing: Icon(
                        //                             Icons.keyboard_arrow_right,
                        //                             size: 24,
                        //                             color: Theme.of(context).focusColor,
                        //                           ),
                        //                           onTap: () {},
                        //                           title: Row(
                        //                             children: [
                        //                               Icon(
                        //                                 Icons.star,
                        //                                 color:
                        //                                 Theme.of(context).focusColor.withOpacity(1),
                        //                               ),
                        //                               SizedBox(width: 16),
                        //                               Text(
                        //                                 "Değerlendir",
                        //                                 style: Theme.of(context).textTheme.subtitle1,
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      S.of(context).languages,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, 2),
                          blurRadius: 5.0)
                    ]),
                    child: ListTile(
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 24,
                        color: Theme.of(context).focusColor,
                      ),
                      onTap: () {
                        if (currentUser.value.apiToken != null) {
                          Navigator.of(context, rootNavigator: false).push(
                            MaterialPageRoute(
                                builder: (context) => LanguagesWidget(),
                                fullscreenDialog: false),
                          );
                        } else {
                          Navigator.of(context, rootNavigator: false)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginWidget(),
                                      fullscreenDialog: true),
                                  (route) => false);
                        }
                      },
                      title: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: Image(
                              image: AssetImage(setting
                                          .value.mobileLanguage.value
                                          .toString() ==
                                      "tr"
                                  ? "assets/img/tr.png"
                                  : "assets/img/united-states-of-america.png"),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            setting.value.mobileLanguage.value.toString() ==
                                    "tr"
                                ? "Türkçe"
                                : "English",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, 2),
                          blurRadius: 5.0)
                    ]),
                    child: ListTile(
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 24,
                        color: Theme.of(context).focusColor,
                      ),
                      onTap: () {
                        if (currentUser.value.apiToken != null) {
                          logout().then((value) {
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginWidget(),
                                        fullscreenDialog: true),
                                    (route) => false);
                          });
                        } else {
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginWidget(),
                                      fullscreenDialog: true),
                                  (route) => false);
                        }
                      },
                      title: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Theme.of(context).focusColor.withOpacity(1),
                          ),
                          SizedBox(width: 16),
                          Text(
                            currentUser.value.apiToken != null
                                ? S.of(context).log_out
                                : S.of(context).login,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  currentUser.value.apiToken == null
                      ? ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignUpWidget(),
                              ),
                            );
                          },
                          title: Row(
                            children: [
                              Icon(
                                Icons.person_add,
                                color:
                                    Theme.of(context).focusColor.withOpacity(1),
                              ),
                              SizedBox(width: 16),
                              Text(
                                S.of(context).register,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        )
                      : SizedBox(height: 0),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email: info@bizimkapici.com',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Whatsapp: 0 554 968 54 54',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ));
  }
}
