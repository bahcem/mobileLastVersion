import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as repository;
import '../../generated/l10n.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';

class ProfileController extends ControllerMVC {
  List<Order> recentOrders = [];
  GlobalKey<ScaffoldState> scaffoldKey;

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForRecentOrders();
  }

  void listenForRecentOrders({String message}) async {
    final Stream<Order> stream = await getRecentOrders();
    stream.listen((Order _order) {
      setState(() {
        recentOrders.add(_order);
      });
    }, onError: (a) {
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void update(User user) async {


    user.deviceToken = null;
    repository.update(user).then((value) {
      setState(() {});
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).profile_settings_updated_successfully),
      ));
    });
  }

  Future<void> refreshProfile() async {
    recentOrders.clear();
    listenForRecentOrders(message: S.of(context).orders_refreshed_successfuly);
  }
}
