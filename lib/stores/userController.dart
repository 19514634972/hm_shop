import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

//需要共享的对象,要有一些共享属性,属性需要响应式更新
class UserController extends  GetxController{
  var user=UserInfo.fromJSON({}).obs;//user对象被监听了
  //取值user.value
  //更新方法
  updateUserInfo(UserInfo newUser){
    user.value=newUser;

  }


}