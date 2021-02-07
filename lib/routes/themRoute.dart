import 'package:flutter/material.dart';
import 'package:flutter_github/common/Global.dart';
import 'package:flutter_github/i10n/localization_intl.dart';
import 'package:flutter_github/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';
class ThemRoute extends StatefulWidget {
  @override
  _ThemRouteState createState() => _ThemRouteState();
}

class _ThemRouteState extends State<ThemRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:5,horizontal: 10 ),
              child: Container(
                color: e,
                height: 40,

              ),
            ),
            onTap: (){
              //更新主题
              Provider.of<ThemeModel>(context).theme =e;
            },

          );
        }).toList(),
      ),
    );
  }
}
