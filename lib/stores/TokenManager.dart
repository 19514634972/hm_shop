

import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager{
  //返回持久化对象的单列对象
  Future<SharedPreferences> _getInstance(){
    return SharedPreferences.getInstance();

  }
  String _token="";
  init()async{
     final prefs = await _getInstance();
     _token=prefs.getString(GlobalConstants.TOKEN_KEY)?? "";
  }
  Future<void>setToken(String val) async {
    //获取持久化实列
    final prefs=await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY,val);
    _token=val;

  }
 String getToken()  {
    return _token;


  }
 Future<void> removeToken()async{
     final prefs=await _getInstance();
     prefs.remove(GlobalConstants.TOKEN_KEY);
     _token="";
  }

}


final tokenManager = TokenManager();