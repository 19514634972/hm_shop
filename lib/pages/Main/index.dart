
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/cart/index.dart';
import 'package:hm_shop/pages/category/index.dart';
import 'package:hm_shop/pages/home/index.dart';
import 'package:hm_shop/pages/mine/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/userController.dart';


class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //定义数据根据数据进行渲染4导航
  //一般应用程序的导航是固定的
  final List<Map<String,String>> _tableList=[
    {
      "icon":"lib/assets/ic_public_home_normal.png", //正常显示
      "active_icon":"lib/assets/ic_public_home_active.png", //激活点击状态下显示图标
      "text":"首页"
    },
    {
      "icon":"lib/assets/ic_public_pro_normal.png", //正常显示
      "active_icon":"lib/assets/ic_public_pro_active.png", //激活点击状态下显示图标
      "text":"分类"
    },
    {
      "icon":"lib/assets/ic_public_cart_normal.png", //正常显示
      "active_icon":"lib/assets/ic_public_cart_active.png", //激活点击状态下显示图标
      "text":"购物车"
    },
    {
      "icon":"lib/assets/ic_public_my_normal.png", //正常显示
      "active_icon":"lib/assets/ic_public_my_active.png", //激活点击状态下显示图标
      "text":"我的"
    }
  ];
  
  int _currentIndex=0;

  //堆叠返回
  List<Widget> _getChildren(){
    return  [HomeView(),CategoryView(),CartView(),MineView()];
  }

  void initState(){
    super.initState();
    _initUser();
  }

  final UserController _userController=Get.put(UserController());
  _initUser()async{
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty){
      //如果token有值就获取用户信息
      _userController.updateUserInfo( await getUserInfoAPI());

    }

  }
//返回底部渲染4个分类
  List<BottomNavigationBarItem> _getTableBarWidget(){
    return List.generate(4,(index){
      return BottomNavigationBarItem(
        icon: Image.asset(_tableList[index]["icon"]!,width: 30,height: 30,),
        activeIcon: Image.asset(_tableList[index]["active_icon"]!,width: 30,height: 30,),
        label: _tableList[index]["text"],
      );

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //上面展示内容
      //下面底部
      //上边安全区
      body: SafeArea( //避开安全区组件
        child:IndexedStack(//堆叠索引组件
          index: _currentIndex,
          children: _getChildren(),
    
        )
      ),
      //底部导航栏
      bottomNavigationBar:BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap:(index){
          setState(() {
            _currentIndex=index;
          });
        },
        currentIndex: _currentIndex,
        items:_getTableBarWidget(),
      ) ,
    );
  }
}