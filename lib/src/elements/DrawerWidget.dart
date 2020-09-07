import 'package:flutter/material.dart';
import '../pages/connection.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/profile_controller.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  //ProfileController _con;

  _DrawerWidgetState() : super(ProfileController()) {
    //_con = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                currentUser.value.apiToken != null
                    ? Navigator.of(context).pushNamed('/Profile')
                    : Navigator.of(context).pushNamed('/Login');
              },
              child: currentUser.value.apiToken != null
                  ? Container(
                height: MediaQuery.of(context).size.height / 9,
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                ),
                // accountName: Text(
                //                      currentUser.value.name,
                //                      style: Theme.of(context).textTheme.headline6,
                //                    ),
                //                    accountEmail: Text(
                //                      currentUser.value.email,
                //                      style: Theme.of(context).textTheme.caption,
                //                    ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      margin: EdgeInsets.only(
                          left: 16, bottom: 4, top: 4, right: 0),
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(100)),
                          child: Image.network(
                              currentUser.value.image.thumb)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      margin: EdgeInsets.only(
                          right: 4,left: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser.value.name,
                            style: TextStyle(
                                color: Theme.of(context).accentColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            currentUser.value.email,
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  : Container(
                padding:
                EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 32,
                      color: Theme.of(context).accentColor.withOpacity(1),
                    ),
                    SizedBox(width: 30),
                    Text(
                      S.of(context).guest,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
            //ListTile(
            //            onTap: () {
            //              Navigator.of(context).pushNamed('/Pages', arguments: 2);
            //            },
            //            leading: Icon(
            //              Icons.home,
            //              color: Theme.of(context).focusColor.withOpacity(1),
            //            ),
            //            title: Text(
            //              S.of(context).home,
            //              style: Theme.of(context).textTheme.subtitle1,
            //            ),
            //          ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 2);
              },
              title: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    S.of(context).home,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 0);
              },
              title: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    S.of(context).notifications,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),

            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 3);
              },
              title: Row(
                children: [
                  Icon(
                    Icons.local_mall,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    S.of(context).my_orders,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 4);
              },
              title: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    S.of(context).favorite_products,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/DeliveryAddresses');
              },
              title: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    S.of(context).delivery_addresses,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),

//          ListTile(
//            dense: true,
//            title: Text(
//              S.of(context).application_preferences,
//              style: Theme.of(context).textTheme.bodyText2,
//            ),
//            trailing: Icon(
//              Icons.remove,
//              color: Theme.of(context).focusColor.withOpacity(0.3),
//            ),
//          )

            ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/Settings');
                } else {
                  Navigator.of(context).pushReplacementNamed('/Login');
                }
              },
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    S.of(context).settings,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),

            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Help');
              },
              title: Row(
                children: [
                  Icon(
                    Icons.help,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'SSS',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),

            ListTile(
              onTap: () {
                if (Theme.of(context).brightness == Brightness.dark) {
                  setBrightness(Brightness.light);
                  setting.value.brightness.value = Brightness.light;
                } else {
                  setting.value.brightness.value = Brightness.dark;
                  setBrightness(Brightness.dark);
                }
                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                setting.notifyListeners();
              },
              title: Row(
                children: [
                  Icon(
                    Icons.brightness_6,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    Theme.of(context).brightness == Brightness.dark
                        ? S.of(context).light_mode
                        : S.of(context).dark_mode,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),

            ListTile(
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
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "İletişim",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            ListTile(
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

            currentUser.value.apiToken == null
                ? ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/SignUp');
              },
              title: Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Theme.of(context).focusColor.withOpacity(1),
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
            setting.value.enableVersion
                ? ListTile(
              dense: true,
              title: Text(
                S.of(context).version + " " + setting.value.appVersion,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Icon(
                Icons.remove,
                color: Theme.of(context).focusColor.withOpacity(0.3),
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
