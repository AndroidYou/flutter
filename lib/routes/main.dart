
 import 'package:flutter/material.dart';
 import 'package:flutter_github/common/Global.dart';
 import 'package:flutter_github/i10n/localization_intl.dart';
import 'package:flutter_github/routes/LanguageRoute.dart';
import 'package:flutter_github/routes/SplashRoute.dart';
import 'package:flutter_github/routes/themRoute.dart';
 import 'package:flutter_github/states/profile_change_notifier.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
 import 'package:provider/provider.dart';
 import 'package:flutter_localizations/flutter_localizations.dart';
 import 'HomeRoute.dart';

import 'package:flutter/material.dart';

import 'package:flutter_github/common/Global.dart';
import 'package:flutter_github/i10n/localization_intl.dart';
//import 'package:flutter_github/routes/HomeRoute.dart';
import 'package:flutter_github/states/profile_change_notifier.dart';
import 'HomeRoute.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
//
 void main() =>Global.init().then((value) => runApp(MyApp()));
//   // ;
//
 class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750,1080),//设计图尺寸
      allowFontScaling: true,//字体是否随系统缩放
        builder: ()=>
        MultiProvider(
          providers: <SingleChildCloneableWidget>[
            ChangeNotifierProvider.value(value: ThemeModel()),
            ChangeNotifierProvider.value(value: LocaleModel()),
            ChangeNotifierProvider.value(value: UserModel())
          ],
          child: Consumer2<ThemeModel,LocaleModel>(
            builder: (BuildContext context,themeModel,localeModel,Widget child){
              print(GmLocalizations.of(context));
              return MaterialApp(

                debugShowCheckedModeBanner: false,
                // title: 'Flutter Demo',
                theme: ThemeData(


                  primarySwatch: themeModel.theme,

                  // visualDensity: VisualDensity.adaptivePlatformDensity,
                ),

                home: SplashRoute(),
                locale: localeModel.getLocale(),
                supportedLocales: [
                  const Locale('en','US'),
                  const Locale('zh','CN')
                ],
                localizationsDelegates: [
                  // 本地化的代理类
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GmLocalizationsDelegate()
                ],
                localeResolutionCallback: (Locale _locale,Iterable<Locale> supportedLocales){
                  if(localeModel.getLocale()!=null){
                    //如果已选定语言，则不跟随系统
                    return localeModel.getLocale();
                  }else{
                    //跟随系统
                    Locale locale;
                    if(supportedLocales.contains(_locale)){
                      locale =_locale;
                    }else{
                      //如果系统语言不是中文简体或者美国英语，则默认使用英语
                      locale = Locale('en','US');
                    }
                    return locale;
                  }
                },
                routes: <String,WidgetBuilder>{
                  'themes':(context)=>ThemRoute(),
                  'language':(context)=>LanguageRoute(),
                  'home':(context)=>HomeRoute()

                },
              );
            },
          ),
        ) );
  }
}






