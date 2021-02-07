import 'package:flutter/material.dart';
import 'package:flutter_github/i10n/localization_intl.dart';
import 'package:flutter_github/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';
class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localModel = Provider.of<LocaleModel>(context);
    var gm = GmLocalizations.of(context);
    Widget _buildLanguageItem(String lan,value){
      return ListTile(
        title: Text(lan,
          //对当前App语言进行高亮显示
          style: TextStyle(color: localModel.locale==value?color:null ),
        ),
        trailing: localModel.locale ==value?Icon(Icons.done,color: color,):null,
        onTap: (){
          localModel.locale =value;
        },

      );


    }
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          ListView(
            shrinkWrap: true,
            children: [
              _buildLanguageItem("中文简体", "zh_CN"),
              _buildLanguageItem("English", "en_US"),
              _buildLanguageItem(gm.auto, null),
            ],
          ),
        ],
      )
    );

  }

}
