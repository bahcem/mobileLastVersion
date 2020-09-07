import 'package:flutter/material.dart';
import '../elements/ProfileSettingsDialog.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/profile_controller.dart';
import '../elements/DrawerWidget.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/ProfileAvatarWidget.dart';
import '../repository/user_repository.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProfileWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends StateMVC<ProfileWidget> {
  ProfileController _con;

  _ProfileWidgetState() : super(ProfileController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).primaryColor),
          onPressed: () => _con.scaffoldKey?.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).profile,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(
              letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: ProfileSettingsDialog(
              color: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              user: currentUser.value,
              onChanged: () {
                _con.update(currentUser.value);
                //setState(() {});
              },
            ),
          ),
        ],
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : SingleChildScrollView(
//              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            ProfileAvatarWidget(user: currentUser.value),
            //  ListTile(
            //                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //                    title: Text(
            //                      S.of(context).about,
            //                      style: Theme.of(context).textTheme.headline4,
            //                    ),
            //                  ),
            //  Padding(
            //                    padding: const EdgeInsets.symmetric(horizontal: 20),
            //                    child: Text(
            //                      currentUser.value?.bio ?? "",
            //                      style: Theme.of(context).textTheme.bodyText2,
            //                    ),
            //                  ),
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                S.of(context).recent_orders,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            _con.recentOrders.isEmpty
                ? EmptyOrdersWidget()
                : ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: _con.recentOrders.length,
              itemBuilder: (context, index) {
                var _order = _con.recentOrders.elementAt(index);
                return OrderItemWidget(
                    expanded: index == 0 ? true : false,
                    order: _order);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
            ),
          ],
        ),
      ),
    );
  }
}
