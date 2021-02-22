import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github/models/Channel.dart';
import 'package:flutter_github/models/ChannelList.dart';
import 'package:flutter_github/states/profile_change_notifier.dart';
import 'package:flutter_rxbus/flutter_rxbus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChannelChoseRoute extends StatefulWidget {
  @override
  _ChannelChoseRouteState createState() => _ChannelChoseRouteState();
}

class _ChannelChoseRouteState extends State<ChannelChoseRoute> {
  List<ChoseList> mainTitles = [];
  List<ChoseList> unChoseTitles=[];
  Channel channelBean;
  SharedPreferences sp;

  @override
  void initState() {
    initTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        title: Text(
          "频道选择",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child:InkWell(
              child:  Icon(
                Icons.close,
                color: Colors.black,

              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
         // mainChannelWidget(mainTitles),
          DragTarget(builder: (BuildContext context,List<dynamic> accepted,List<dynamic> rejected){

              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: mainTitles.length,
                  padding: EdgeInsets.all(10),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10,childAspectRatio: 1.8),
                  itemBuilder: (context, index) {
                    return Draggable<ChoseList>(
                      ignoringFeedbackSemantics: true,
                      onDragStarted: (){
                        print("1111-开始移动");
                      },
                      onDragEnd: ( details){
                        print("1111-开始移动${details.offset}");
                      },
                      onDragCompleted: (){
                        setState(() {
                          print("1112-移动完成1");
                          mainTitles.removeAt(index);
                          saveJson();
                        });
                      },
                      //必须要有一个material，不然拖动时Text会出现双下划线
                      feedback: Material(
                        child: Container(
                          width: 90,
                          height: 50,

                          color: Provider.of<ThemeModel>(context).theme,
                          alignment: Alignment.center,
                          child: Text(
                            mainTitles[index].channelName,style: TextStyle(color: Colors.white),
                          ),

                        ),
                      ),
                      data: mainTitles[index],
                      child: Container(

                        color: Provider.of<ThemeModel>(context).theme,
                        alignment: Alignment.center,
                        child: Text(
                          mainTitles[index].channelName,style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  });

          },
            onAccept: (ChoseList list){
              print("1112-移动完成2");
            setState(() {
              mainTitles.add(list);
            });




            },
          ),
          SizedBox(height: 100,),
          DragTarget<ChoseList>(

            builder: (BuildContext context,List<dynamic> accepted,List<dynamic> rejected){
    return GridView.builder(
    shrinkWrap: true,
    itemCount: unChoseTitles.length,
    padding: EdgeInsets.all(10),
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10,childAspectRatio: 1.8),
    itemBuilder: (context, index) {
    return Draggable<ChoseList>(
    ignoringFeedbackSemantics: true,
    onDragStarted: (){
    print("1111-开始移动");
    },
    onDragEnd: ( details){
    print("1111-开始移动${details.offset}");
    },
    onDragCompleted: (){
    setState(() {
    print("1111-移动完成");
    unChoseTitles.removeAt(index);
    });
    },
    //必须要有一个material，不然拖动时Text会出现双下划线
    feedback: Material(
    child: Container(
    width: 90,
    height: 50,

    color: Provider.of<ThemeModel>(context).theme,
    alignment: Alignment.center,
    child: Text(
      unChoseTitles[index].channelName,style: TextStyle(color: Colors.white),
    ),

    ),
    ),
    data: unChoseTitles[index],
    child: Container(

    color: Provider.of<ThemeModel>(context).theme,
    alignment: Alignment.center,
    child: Text(
      unChoseTitles[index].channelName,style: TextStyle(color: Colors.white),
    ),
    ),
    );
    });


    },



            onAccept: (ChoseList channel){
             setState(() {
               unChoseTitles.add(channel);
             });

            },

          )
        ],
      ),
    );
  }



  void initTab() async {
    //默认tab
    sp = await SharedPreferences.getInstance();
    var channel = sp.getString("channel");
    var jsonData = json.decode(channel);
    channelBean= Channel.fromJson(jsonData);
    setState(() {
      mainTitles.addAll(channelBean.choseList);
      unChoseTitles.addAll(channelBean.unChoseList);
    });
  }
  void saveJson()async{
    channelBean.choseList = mainTitles;
    channelBean.unChoseList= unChoseTitles;
    var jsonData =json.encode(channelBean.toJson());
    sp.setString("channel", jsonData);
    RxBus.getInstance().post(111);
  }
}
