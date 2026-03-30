

//登录接口
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo>LoginApi(Map<String,dynamic> data)async{
  return UserInfo.fromJSON(
    await dioRequset.post(HttpConstants.LOGIN,data: data)
  );
  
}

Future<UserInfo>getUserInfoAPI()async{
  return UserInfo.fromJSON(
    await dioRequset.get(HttpConstants.USER_PROFILE)
  );
}