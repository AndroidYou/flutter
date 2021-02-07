import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/i10n/localization_intl.dart';
import 'package:flutter_github/models/ChannelList.dart';
import 'package:flutter_github/routes/NewsRoute.dart';
import 'package:flutter_github/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeRoute extends StatefulWidget {

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute>  with SingleTickerProviderStateMixin{
  ///获取打包后的资源文件实际路径
  ///如assets/files/index.html
  String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }
  List<ChannelList> titles =[
    ChannelList("shehui", "社会"),
    ChannelList("guonei", "国内"),
    ChannelList("guoji", "国际"),
    ChannelList("yule", "娱乐"),
    ChannelList("tiyu", "体育"),
    ChannelList("keji", "科技"),
    ChannelList("caijing", "财经"),
    ChannelList("shishang", "时尚"),
  ];
  TabController _controller;
  @override
  void initState() {
   _controller =TabController(length: titles.length, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(


        title: Text(GmLocalizations.of(context).title),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: titles.map((e) => Tab(text: e.name,)).toList(),
          controller: _controller,
        ),
      ),

      body: TabBarView(
        controller:_controller ,
        children: titles.map<Widget>((e) => NewsRoute( type: e.type)).toList(),
      ),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    return WebView(

     initialUrl: getAssetsPath('html/echarts.html'),
      javascriptMode: JavascriptMode.unrestricted,
    );
  }





}



class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(context: context, //移除边距
          removeTop: true,
          child: ListView(
            children: [
              Container(
                height: 200,
                color: Provider.of<ThemeModel>(context).theme,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      CircleAvatar(
                        backgroundImage:NetworkImage("http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                        radius: 40,
                      ),
                      SizedBox(height: 15,),
                      Text("小小猫",style: TextStyle(color: Colors.black45),)
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.color_lens),
                title: Text(GmLocalizations.of(context).theme),
                onTap:()=>Navigator.pushNamed(context, "themes"),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(GmLocalizations.of(context).language),
                onTap: (){
                  Navigator.pushNamed(context, "language");
                },
              ),
            ],
          ) ),
    );

  }
}
