import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/common/LinearLayout.dart';
import 'package:flutter_github/models/NewsBean.dart';


import 'package:flutter_github/routes/NewsDetailsRoute.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class NewsRoute extends StatefulWidget {
  NewsRoute({@required this.type});
  final String type;
  @override
  _NewsRouteState createState() => _NewsRouteState();
}

class _NewsRouteState extends State<NewsRoute>  with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var dio = Dio(BaseOptions(
        baseUrl: "http://api.iclient.ifeng.com"
    ));
    print("resulttype=="+widget.type);
    Future<NewsBean> getNews({Map<String,dynamic> queryParameters}) async{
      var result =  await dio.get(
          "/ClientNews?id=${widget.type}&pullNum=1&uid=864678036850608&action=default",
          queryParameters: queryParameters
      );
    //  HttpClientRequest request =   await HttpClient().getUrl(Uri.parse("http://api.iclient.ifeng.com/ClientNews?id=TW73&action=default&pullNum=1&uid=864678036850608"));
    //  HttpClientResponse response = await request.close();
    // var s= await response.transform(utf8.decoder).join();


      print("result长度 = ${getNewsBeanList(result.data).first.item.length}");
      return getNewsBeanList(result.data).first;
      return null;
    }


    return Center(
      child: FutureBuilder(
          future: getNews(),
          builder: (BuildContext context,AsyncSnapshot<NewsBean> snapshot){
            if(snapshot.connectionState == ConnectionState.done){

              print("result1=c长度=${snapshot.data.item.length}");


              return ListView.builder(
                itemCount: snapshot.data.item.length,

                  itemBuilder: (BuildContext context,int index){
                print("result1=当前=$index");
                       var e =     snapshot.data.item[index];
                       print("flutter=${e.toString()}");

                         if(index==0&&e.type=="focus"){
                           List<String> list=  snapshot.data.item.map((e) => e.thumbnail).toList();
                           return Swiper(
                             itemCount: list.length,
                             itemBuilder: (BuildContext context, int index){
                               return Image.network(list[index]);
                             },
                           );
                         }
                         else if(e.type=="doc"&&e.style.view=="titleimg"){
                           return   Column(
                             children: [
                               ListTile(
                                 leading:  Image.network(e.thumbnail,width: 100,height: 80,fit: BoxFit.cover,),
                                 title: Text(e.title,style: TextStyle(fontSize: 14),),
                                 subtitle: Text(e.title,style: TextStyle(fontSize: 10),),
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                       NewsDetailsRoute(url: e.link.weburl, title: e.title)
                                   ));

                                 },
                               ),
                               //分割线
                               Divider(height: 2,color: Colors.black38,indent: 16,endIndent: 16,)
                             ],
                           );
                           //多图文章模式
                         }
                         else  if(e.type=="doc"&&e.style.view=="slideimg"){
                           print("111");
                           return
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding( padding:EdgeInsets.fromLTRB(10, 10, 10, 0) ,child: Text(e.title,),),
                                 LinearLayout(
                                   orientation: LayoutOrientation.horizontal,
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     SizedBox(width: 10,),
                                     Expanded(
                                       child:  Image.network(e.style.images[0],height: 120,),),
                                     SizedBox(width: 5,),
                                     Expanded(
                                       child:  Image.network(e.style.images[1],height: 120,),),
                                     SizedBox(width: 5,),
                                     Expanded(
                                       child:  Image.network(e.style.images[2],height: 120,),),
                                     SizedBox(width: 10,),
                                   ],
                                 ),
                                 Divider(height: 2,color: Colors.black38,indent: 16,endIndent: 16,)
                               ],
                             );
                         }
                         //视频类型
                         else if(e.type=="phvideo"){
                           return   Expanded(child: Padding(
                             padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                             child: Column(
                               children: [
                                 Padding(padding: EdgeInsets.fromLTRB(10,0,10,10),child: Text(e.title,textDirection: TextDirection.ltr,),),
                                 Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Image.network(e.thumbnail,height: 120,width:double.infinity,fit: BoxFit.cover,),
                                     Image.asset("imgs/ic_play.png")

                                   ],
                                 )

                               ],
                             ),
                           ));
                         }
                         else{
                           return Container();
                         // ignore: missing_return
                         }


                    /*  else {
                        return   Expanded(child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.fromLTRB(10,0,10,10),child: Text(e.title,textDirection: TextDirection.ltr,),),

                              Image.network(e.thumbnail,height: 120,width:double.infinity,fit: BoxFit.cover,),





                            ],
                          ),
                        ));
                      }*/











              });

            }
            else{
              return CircularProgressIndicator();
            }
           //
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
