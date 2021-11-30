import 'package:flutter/cupertino.dart';
import 'package:todoapp/pages/home_page/home_page.dart';
import 'package:todoapp/pages/intro_page/intro_page.dart';

class AppRouter {
  static initRouter() {
    return <String, WidgetBuilder>{
      IntroPage.route(): (BuildContext context) => const IntroPage(),
      HomePage.route(): (BuildContext context) => const HomePage(),
    };
  }
}
