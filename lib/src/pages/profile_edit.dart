import 'package:flutter/material.dart';
import '../controllers/profile_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class ProfileEditPage extends StatefulWidget {
  final user;
  final Function effectFunc;

  const ProfileEditPage({Key key, this.user, this.effectFunc})
      : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends StateMVC<ProfileEditPage> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();
  ProfileController _con;

  _ProfileEditPageState() : super(ProfileController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      key: _con.scaffoldKey,
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Theme.of(context).focusColor.withOpacity(0.3),
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profili Düzenle',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 30,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.15),
                      offset: Offset(0, 2),
                      blurRadius: 5.0)
                ]),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 20),
            child: Form(
              key: _profileSettingsFormKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Theme.of(context).hintColor),
                    keyboardType: TextInputType.text,
                    decoration: getInputDecoration(
                        hintText: "Adı Soyadı", labelText: S.of(context).full_name),
                    initialValue: widget.user.value.name,
                    validator: (input) =>
                        input.trim().length < 3 ? S.of(context).not_a_valid_full_name : null,
                    onSaved: (input) => widget.user.value.name = input,
                  ),
                  TextFormField(
                    style: TextStyle(color: Theme.of(context).hintColor),
                    keyboardType: TextInputType.emailAddress,
                    decoration: getInputDecoration(
                        hintText: 'hello@bahcemapp.com',
                        labelText: S.of(context).email_address),
                    initialValue: widget.user.value.email,
                    validator: (input) =>
                        !input.contains('@') ? S.of(context).email : null,
                    onSaved: (input) => widget.user.value.email = input,
                  ),
                  TextFormField(
                    style: TextStyle(color: Theme.of(context).hintColor),
                    keyboardType: TextInputType.text,
                    decoration: getInputDecoration(
                        hintText: '0 555 555 55 55',
                        labelText: S.of(context).phone),
                    initialValue: widget.user.value.phone,
                    validator: (input) => input.trim().length < 3
                        ? S.of(context).not_a_valid_phone
                        : null,
                    onSaved: (input) => widget.user.value.phone = input,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              onPressed: () {
                _submit();
              },
              disabledColor: Theme.of(context).focusColor.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 14),
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
              child: Text(
                S.of(context).save,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();

      _con.update(widget.user.value);

      setState(() {
        widget.effectFunc();
      });
      Navigator.pop(context);
    }
  }
}
