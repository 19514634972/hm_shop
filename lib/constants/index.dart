//全局常量
class GlobalConstants{
  static const String BASE_URL="https://meikou-api.itheima.net"; //基础地址
  static const int TIME_OUT=10; //超时时间
  static const String SUCCESS_CODE="1"; //成功状态码
  static const String TOKEN_KEY="hm_shop_token";
}

//请求地址接口的常量
class HttpConstants{
  static const String BANNER_LIST="/home/banner"; //轮播图
  static const String HOT_LIST="/home/category/head"; //分类列表、热门列表
  static const String PRODUCT_LIST="/hot/preference"; //特惠推荐
  
  static const String IN_VOGUE_LIST = "/hot/inVogue"; // 热榜推荐地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; // 一站式推荐地址
  static const String RECOMMEND_LIST = "/home/recommend"; // 推荐列表
  //请求地址有---类型GoodsItems类型---》HmMorList要的是List<GoodDetailItem>类型
  static const String GUESS_LIST = "/home/goods/guessLike"; // 猜你喜欢--》GoodsItems
  static const String LOGIN = "/login";
  static const String USER_PROFILE = "/member/profile";
 


}
