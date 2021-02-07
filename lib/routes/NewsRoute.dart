import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_github/models/news.dart';
import 'package:flutter_github/routes/NewsDetailsRoute.dart';
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
        baseUrl: "http://v.juhe.cn/toutiao"
    ));
    Future<News> getNews({Map<String,dynamic> queryParameters}) async{
      var result =  await dio.get(
          "/index?type=${widget.type}&key=f09196790a659546b35a46df6158cfd2",
          queryParameters: queryParameters
      );
      print("result = "+result.data.toString());
      return News.fromJson(result.data);
    }


    return Center(
      child: FutureBuilder(
          future: getNews(),
          builder: (BuildContext context,AsyncSnapshot<News> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              print("result1==1");
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              print("result1==2");
              if(snapshot.data.errorCode==10012){
                return Text(snapshot.data.reason);
              }
              print("result1=="+snapshot.data.result.data[1].title);
              return ListView(
                  children:snapshot.data.result.data.map<Widget>((e) =>
                      Column(
                        children: [
                          ListTile(
                            leading:  Image.network(e.thumbnailPicS,width: 100,height: 80,fit: BoxFit.cover,),
                            title: Text(e.title,style: TextStyle(fontSize: 14),),
                            subtitle: Text(e.authorName,style: TextStyle(fontSize: 10),),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  NewsDetailsRoute(url: e.url, title: e.title)
                              ));

                            },
                          ),
                          //分割线
                          Divider(height: 2,color: Colors.black38,indent: 16,endIndent: 16,)
                        ],
                      )


                  ).toList()

              );

            }
            return CircularProgressIndicator();
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
