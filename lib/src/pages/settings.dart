import 'package:flutter/material.dart';
import 'package:markets/src/controllers/profile_controller.dart';
import 'package:markets/src/elements/PermissionDeniedWidget.dart';
import 'package:markets/src/pages/map.dart';
import 'package:markets/src/pages/profile_edit.dart';
import 'package:markets/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../repository/user_repository.dart';
import 'connection.dart';
import 'package:markets/src/pages/favorites.dart';

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
    print('Girdim');
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
                color: Theme
                    .of(context)
                    .focusColor
                    .withOpacity(0.3),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Hesabım",
            style: Theme
                .of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 4,
              color: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfileEditPage(
                          user: currentUser, effectFunc: _effect,),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme
                              .of(context)
                              .focusColor
                              .withOpacity(0.15),
                          offset: Offset(0, 2),
                          blurRadius: 5.0)
                    ]),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline3,
                          ),
                          Text(
                            currentUser.value.email,
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                          Text(
                            currentUser.value.phone,
                            textAlign: TextAlign.left,
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                        width: 55,
                        height: 55,
                        child: CircleAvatar(
                          backgroundImage:
                          NetworkImage(currentUser.value.image.thumb),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 14,
              color: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Theme
                        .of(context)
                        .focusColor
                        .withOpacity(0.15),
                    offset: Offset(0, 2),
                    blurRadius: 5.0)
              ]),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/DeliveryAddresses');
                    },
                    title: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color:
                          Theme
                              .of(context)
                              .focusColor
                              .withOpacity(1),
                        ),
                        SizedBox(width: 16),
                        Text(
                          S
                              .of(context)
                              .delivery_addresses,
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24,
                      color: Theme
                          .of(context)
                          .focusColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    height: 0.8,
                    color: Color.fromRGBO(223, 225, 229, 1),
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24,
                      color: Theme
                          .of(context)
                          .focusColor,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FavoritesWidget(),),);
                    },
                    title: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color:
                          Theme
                              .of(context)
                              .focusColor
                              .withOpacity(1),
                        ),
                        SizedBox(width: 16),
                        Text(
                          S
                              .of(context)
                              .favorite_products,
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    height: 0.8,
                    color: Color.fromRGBO(223, 225, 229, 1),
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24,
                      color: Theme
                          .of(context)
                          .focusColor,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/Pages', arguments: 1);
                    },
                    title: Row(
                      children: [
                        Icon(
                          Icons.local_mall,
                          color:
                          Theme
                              .of(context)
                              .focusColor
                              .withOpacity(1),
                        ),
                        SizedBox(width: 16),
                        Text(
                          S
                              .of(context)
                              .my_orders,
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    height: 0.8,
                    color: Color.fromRGBO(223, 225, 229, 1),
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24,
                      color: Theme
                          .of(context)
                          .focusColor,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MapWidget(),
                        ),
                      );
                    },
                    title: Row(
                      children: [
                        Icon(
                          Icons.store_mall_directory,
                          color:
                          Theme
                              .of(context)
                              .focusColor
                              .withOpacity(1),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Marketler",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    height: 0.8,
                    color: Color.fromRGBO(223, 225, 229, 1),
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24,
                      color: Theme
                          .of(context)
                          .focusColor,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/Help');
                    },
                    title: Row(
                      children: [
                        Icon(
                          Icons.help,
                          color:
                          Theme
                              .of(context)
                              .focusColor
                              .withOpacity(1),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'SSS',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    height: 0.8,
                    color: Color.fromRGBO(223, 225, 229, 1),
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24,
                      color: Theme
                          .of(context)
                          .focusColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConnectionPage(),
                        ),
                      );
                    },
                    title: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color:
                          Theme
                              .of(context)
                              .focusColor
                              .withOpacity(1),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "İletişim",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            ListTile(
              dense: true,
              title: Text(
                S
                    .of(context)
                    .languages,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Theme
                        .of(context)
                        .focusColor
                        .withOpacity(0.15),
                    offset: Offset(0, 2),
                    blurRadius: 5.0)
              ]),
              child: ListTile(
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: 24,
                  color: Theme
                      .of(context)
                      .focusColor,
                ),
                onTap: () {
                  if (currentUser.value.apiToken != null) {
                    Navigator.of(context).pushNamed('/Languages');
                  } else {
                    Navigator.of(context).pushReplacementNamed('/Login');
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
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
                    color: Theme
                        .of(context)
                        .focusColor
                        .withOpacity(0.15),
                    offset: Offset(0, 2),
                    blurRadius: 5.0)
              ]),
              child: ListTile(
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: 24,
                  color: Theme
                      .of(context)
                      .focusColor,
                ),
                onTap: () {
                  if (currentUser.value.apiToken != null) {
                    logout().then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/Pages', (Route<dynamic> route) => false,
                          arguments: 2);
                    });
                  } else {
                    Navigator.of(context).pushNamed('/Login');
                  }
                },
                title: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme
                          .of(context)
                          .focusColor
                          .withOpacity(1),
                    ),
                    SizedBox(width: 16),
                    Text(
                      currentUser.value.apiToken != null
                          ? S
                          .of(context)
                          .log_out
                          : S
                          .of(context)
                          .login,
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            currentUser.value.apiToken == null
                ? ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/SignUp');
              },
              title: Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color:
                    Theme
                        .of(context)
                        .focusColor
                        .withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    S
                        .of(context)
                        .register,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1,
                  ),
                ],
              ),
            )
                : SizedBox(height: 0),
            setting.value.enableVersion
                ? ListTile(
              dense: true,
              title: Text(
                S
                    .of(context)
                    .version +
                    " " +
                    setting.value.appVersion,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
              ),
              trailing: Icon(
                Icons.remove,
                color:
                Theme
                    .of(context)
                    .focusColor
                    .withOpacity(0.3),
              ),
            )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
