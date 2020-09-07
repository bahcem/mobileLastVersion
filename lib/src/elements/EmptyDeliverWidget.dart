import 'dart:async';
import 'package:flutter/material.dart';

class EmptyDeliverWidget extends StatefulWidget {
  EmptyDeliverWidget({
    Key key,
  }) : super(key: key);

  @override
  _EmptyDeliverWidgetState createState() => _EmptyDeliverWidgetState();
}

class _EmptyDeliverWidgetState extends State<EmptyDeliverWidget> {
  bool loading = true;

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? SizedBox(
          height: 3,
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.2),
          ),
        )
            : SizedBox(),
        Container(),
      ],
    );
  }
}
