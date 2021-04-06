import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../pages/politycs.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends StateMVC<SignUpWidget> {
  UserController _con;
  TextEditingController phoneCont = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool opacity = false;

  bool validate = true;

  _SignUpWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        key: _con.scaffoldKey,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(29.5),
                decoration: BoxDecoration(color: Theme.of(context).accentColor),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(29.5) - 120,
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(29.5),
                child: Text(
                  S.of(context).lets_start_with_register,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(29.5) - 80,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.35,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      )
                    ]),

                padding: EdgeInsets.symmetric(vertical: 20),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.35,
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _con.loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (input) => _con.user.name = input,
                                validator: (input) => input.length < 3
                                    ? S
                                        .of(context)
                                        .should_be_more_than_3_letters
                                    : null,
                                decoration: InputDecoration(
                                  labelText: S.of(context).full_name,
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: S.of(context).john_doe,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.person_outline,
                                      color: Theme.of(context).accentColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                ),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (input) => _con.user.email = input,
                                validator: (input) => !input.contains('@')
                                    ? S.of(context).should_be_a_valid_email
                                    : null,
                                decoration: InputDecoration(
                                  labelText: S.of(context).email,
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: 'johndoe@gmail.com',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.alternate_email,
                                      color: Theme.of(context).accentColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                ),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (input) => _con.user.phone = input,
                                validator: (input) => input.length < 11
                                    ? S.of(context).not_a_valid_phone
                                    : null,
                                decoration: InputDecoration(
                                  labelText: S.of(context).phone,
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: '0 555 555 55 55',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.phone,
                                      color: Theme.of(context).accentColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                ),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                onTap: () {
                                  setState(() {
                                    _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 500),
                                    );
                                  });
                                },
                                onFieldSubmitted: (val) {
                                  setState(() {
                                    _scrollController.animateTo(
                                      _scrollController
                                          .position.minScrollExtent,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 500),
                                    );
                                  });
                                },
                                obscureText: _con.hidePassword,
                                onSaved: (input) => _con.user.password = input,
                                validator: (input) => input.length < 6
                                    ? S
                                        .of(context)
                                        .should_be_more_than_6_letters
                                    : null,
                                decoration: InputDecoration(
                                  labelText: S.of(context).password,
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: '••••••••••••',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  prefixIcon: Icon(Icons.lock_outline,
                                      color: Theme.of(context).accentColor),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _con.hidePassword = !_con.hidePassword;
                                      });
                                    },
                                    color: Theme.of(context).focusColor,
                                    icon: Icon(_con.hidePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                ),
                              ),
                              SizedBox(height: 30),
                              BlockButtonWidget(
                                text: Text(
                                  S.of(context).register,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  if (opacity == false) {
                                    setState(() {
                                      validate = false;
                                      _con.scaffoldKey.currentState
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                              'Kayıt olmak için üyelik sözleşmesini kabul edin.'),
                                        ),
                                      );
                                    });
                                  } else {
                                    setState(() {
                                      validate = true;
                                    });
                                    _con.register();
                                  }
                                },
                              ),
                              SizedBox(height: 25),
                              Container(
                                height: 40,
                                child: Row(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          opacity = !opacity;
                                          if (opacity == true) {
                                            validate == true;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: opacity == false
                                              ? Colors.transparent
                                              : Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: validate == true
                                                  ? Theme.of(context).focusColor
                                                  : Colors.red),
                                        ),
                                        child: opacity == false
                                            ? Container()
                                            : Icon(
                                                Icons.done,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          130,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Theme.of(context).focusColor),
                                          text: 'Bu uygulamaya kayıt olarak ',
                                          children: <TextSpan>[
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Politikalar(
                                                              url:
                                                                  'kullanici-sozlesmesi',
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline),
                                                text: 'üyelik sözleşmesi'),
                                            TextSpan(text: ', '),
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Politikalar(
                                                              url:
                                                                  'kvkk-politikamiz',
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline),
                                                text: 'aydınlatma metni'),
                                            TextSpan(text: ' ve '),
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Politikalar(
                                                              url:
                                                                  'acik-riza-beyani',
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline),
                                                text: 'açık rıza beyanını'),
                                            TextSpan(
                                                text:
                                                    ' okudum kabul ediyorum.'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LoginWidget(),
                                    ),
                                  );
                                },
                                textColor: Theme.of(context).hintColor,
                                child: Text(
                                    S.of(context).i_have_account_back_to_login),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
