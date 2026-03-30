

//封装一个api返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

//很重要,返回轮播图数据列表
Future<List<BannerItem>> getBannerListAPI()async{

  //返回请求
  final tt=((await dioRequset.get(HttpConstants.BANNER_LIST)) as List).map((item){

    return BannerItem.fromJson(item as Map<String,dynamic>);

  }).toList();

  return tt;

}


//分类列表
Future<List<HotCategory>> getHotCategoryListAPI()async{

  //返回请求
  final tt=((await dioRequset.get(HttpConstants.HOT_LIST)) as List).map((item){

    return HotCategory.fromJson(item as Map<String,dynamic>);

  }).toList();

  return tt;

}


//封装特惠推荐api
Future<SpecialRecommendResult> getSpecialRecommendListAPI()async{

  //返回请求
  final tt=SpecialRecommendResult.fromJson(await dioRequset.get(HttpConstants.PRODUCT_LIST));

  return tt;

}


 //热榜推荐
Future<SpecialRecommendResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialRecommendResult.fromJson(
    await dioRequset.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecialRecommendResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialRecommendResult.fromJson(
    await dioRequset.get(HttpConstants.ONE_STOP_LIST),
  );
}



// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequset.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}