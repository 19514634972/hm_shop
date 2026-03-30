import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';


//管理路由
//返回app根级组件
Widget getRootWidget() {
  return MaterialApp(
    // 允许在 Web/桌面端使用鼠标拖拽滚动
    scrollBehavior: const MaterialScrollBehavior().copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      },
    ),
    //配置命名路由
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

//返回该app的路由的配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) =>MainPage(), //主页组件
    "/login": (context) => LoginPage(), //登录组件
    
  };
}
