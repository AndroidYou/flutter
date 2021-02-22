

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/utils/GradientCircularProgressIndicator.dart';


class SplashRoute extends StatefulWidget {
  @override
  _SplashRouteState createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  var imageUrl = "http://api.dujin.org/bing/1920.php";
   int currentTimer = 0;
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer timer){
      currentTimer++;
        if(currentTimer==4){
          timer.cancel();
          Navigator.pushNamed(context, "home");
        }
        setState(() {

        });
    });
  }
  @override
  void dispose() {
    if(timer.isActive){
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
          Positioned(
              right: 10,
              top: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                GradientCircularProgressIndicator(
                value: currentTimer/4,
                radius: 20,),
                  Text('$currentTimer',textDirection: TextDirection.ltr,style:
                  TextStyle(fontSize: 15,decoration: TextDecoration.none,color: Colors.grey),

                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
