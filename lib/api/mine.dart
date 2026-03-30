

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

//有参数
//page:1 pageSize:100
Future<GoodsDetailsItems>getGuessListAPI(Map<String,dynamic> param)async{

  return GoodsDetailsItems.fromJson( 
     await dioRequset.get(HttpConstants.GUESS_LIST,params: param)
     );


}