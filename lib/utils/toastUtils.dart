import 'package:flutter/material.dart';

class ToastUtils {
  //阀门控制
  static bool showLoading=false;
  static void showToast(BuildContext context, String? msg){

      if (ToastUtils.showLoading){
        return;
      }

      ToastUtils.showLoading=true;
      Future.delayed(Duration(seconds: 3),(){
          ToastUtils.showLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 180,
      behavior: SnackBarBehavior.floating, //悬浮状态
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(40) //圆角
      ),
      content: Text(msg ?? "加载成功",textAlign: TextAlign.center,)
      
      ));
  }
}