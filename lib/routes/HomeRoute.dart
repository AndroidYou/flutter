import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/i10n/localization_intl.dart';
import 'package:flutter_github/models/Channel.dart';
import 'package:flutter_github/models/ChannelList.dart';
import 'package:flutter_github/routes/ChannelChoseRoute.dart';
import 'package:flutter_github/routes/NewsRoute.dart';
import 'package:flutter_github/states/profile_change_notifier.dart';
import 'package:flutter_rxbus/flutter_rxbus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute>
    with TickerProviderStateMixin {
  ///获取打包后的资源文件实际路径
  ///如assets/files/index.html
  String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }

  List<ChoseList> titles = [];
  TabController _controller;
  int _selectedIndex;
  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();


    _controller = TabController(length: titles.length, vsync: this);
    initTab();
    RxBus.getInstance().register((event) {
      print("收到信息==$event");
      initTab();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    RxBus.getInstance().unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(GmLocalizations
          .of(context)
          .title),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: titles
              .map((e) =>
              Tab(
                text: e.channelName,
              ))
              .toList(),
          controller: _controller,

        ),
        actions: [
          GestureDetector(child: Icon(Icons.add), onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChannelChoseRoute();
            }));
          },)


        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: titles.map<Widget>((e) => NewsRoute(type: e.channelNo))
            .toList(),
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

  void initTab() async {
    titles.clear();
    _preferences = await SharedPreferences.getInstance();
    //新闻列表缓存
    var channels = _preferences.getString("channel");
    if (channels == null) {
      Future channel =
      DefaultAssetBundle.of(context).loadString("jsons/channel.json");

      channel.then((value) {
        _preferences.setString("channel", value);
        print("1进入=$value");
        var jsonData = json.decode(value);

        Channel channelData = Channel.fromJson(jsonData);
        print("channel12==${json.decode(value).toString()}");
        setState(() {
          print("1进入212");
          titles.addAll(channelData.choseList);
          _controller = TabController(length: titles.length, vsync: this);
        });
      });
    } else {
      var jsonData = json.decode(channels);
      Channel channelData = Channel.fromJson(jsonData);
      setState(() {
        titles.addAll(channelData.choseList);
        _controller = TabController(length: titles.length, vsync: this);
      });
    }
  }

}

class MyDrawer extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context, //移除边距
          removeTop: true,
          child: ListView(
            children: [
              Container(
                height: 200,
                color: Provider
                    .of<ThemeModel>(context)
                    .theme,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                          radius: 40,
                        ),
                        onTap: () {
                          showDialog(context);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "小小猫",
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.color_lens),
                title: Text(GmLocalizations
                    .of(context)
                    .theme),
                onTap: () => Navigator.pushNamed(context, "themes"),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(GmLocalizations
                    .of(context)
                    .language),
                onTap: () {
                  Navigator.pushNamed(context, "language");
                },
              ),
            ],
          )),
    );
  }

  showDialog(context) {
    return showModalBottomSheet(
        context: context, builder: (BuildContext context) {
      return Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              child: Center(


                child: InkWell(
                  child: Text("拍照",),
                  onTap: () {
                    _takePhoto();
                  },
                ),
              ),
            ),
            Divider(height: 1,),
            Container(
              height: 49,
              child: Center(
                  child: InkWell(
                    child: Text("相册",),
                    onTap: () {
                      _openGallery();
                    },

                  )
              ),
            )
          ],
        ),
      );
    });
  }

  //拍照
  _takePhoto() async {
    var image = await picker.getImage(source: ImageSource.camera);
  }


  //相册
  _openGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
  }


}


