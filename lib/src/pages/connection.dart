import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectionPage extends StatefulWidget {
  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'İletişim',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                //  leading: Icon(
                //                    Icons.map,
                //                    color: Theme.of(context).hintColor,
                //                  ),
                title: Padding(
                  padding:  EdgeInsets.only(bottom:8.0),
                  child: Text(
                    "İletişim Bilgileri",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(

                      padding:  EdgeInsets.only(left: 0,right: 0, bottom: 4),
                      child: Text('Adres: Şişli/İstanbul'),
                    ),
                    Padding(

                      padding:  EdgeInsets.only(left: 0,right: 0, bottom: 4),
                      child: Text('E posta: hello@bahcemapp.com'),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 0,right: 0, bottom: 16),
                      child: Row(
                        children: [
                          Text('Müşteri Hizmetleri: '),
                          GestureDetector(onTap: (){
                            launch("tel://0212 813 66 16");
                          },child: Text('0212 813 66 16',style: TextStyle(decoration: TextDecoration.underline),)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom:8.0),
                      child: Text(
                        "Market Başvurusu",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Padding(

                      padding:  EdgeInsets.only(left: 0,right: 0, bottom: 4),
                      child: Text('E posta: basvuru@bahcemapp.com'),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 0,right: 0, bottom: 16),
                      child: Row(
                        children: [
                          Text('Müşteri Hizmetleri: '),
                          GestureDetector(onTap: (){
                            launch("tel://0212 813 66 16");
                          },child: Text('0212 813 66 16',style: TextStyle(decoration: TextDecoration.underline),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
