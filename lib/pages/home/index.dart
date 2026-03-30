import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/home/hmHot.dart';
import 'package:hm_shop/components/home/hmMoreList.dart';
import 'package:hm_shop/components/home/hmSlider.dart';
import 'package:hm_shop/components/home/hmCategory.dart';
import 'package:hm_shop/components/home/hmSuggestion.dart';
import 'package:hm_shop/utils/toastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem>_bannerList = [
    //   BannerItem(id: "1", imageUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"), 
    // BannerItem(id: "2", imageUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png"),
    // BannerItem(id: "3", imageUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  ];
  List<HotCategory>_hotCategoryList = [];


  //获取滚动容器内容
  List<Widget> _getScrollChildren(){
    return [
       //包裹普通的widget的sliver家族
       SliverToBoxAdapter(
        child:HmSlider(bannerList: _bannerList),//轮播图组件

       ),
       //设置间距组件
       SliverToBoxAdapter(child:SizedBox(height: 10)),
       //sliverGrid和sliverList只能纵向排列
       //只能用ListView或者gridView横向排列
       SliverToBoxAdapter(
        child:HmCategory(categoryList: _hotCategoryList),
       ),
      //设置间距组件
      SliverToBoxAdapter(child:SizedBox(height: 10)),
      SliverToBoxAdapter(
        child:HmSuggesstion(specialRecommendResult: _specialRecommendResult),
       ),

      SliverToBoxAdapter(child:SizedBox(height: 10)),

      SliverToBoxAdapter(
        child:Padding( //这是内边距
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal, //横向排列
            children: [
                Expanded(
                    child: HmHot(result: _inVogueResult, type: "hot"),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: HmHot(result: _oneStopResult, type: "step"),
                ),
          ],
        ),
          
      ),

       ),
      SliverToBoxAdapter(child:SizedBox(height: 10)),
       HmMoreList(recommendList: _recommendList), //无限滚动列表
    ];
  }

//声名一个特惠推荐数据模型
  SpecialRecommendResult _specialRecommendResult=SpecialRecommendResult(
    id: "", 
    title: "",
     subTypes: []
     );


SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );


  // 推荐列表
  List<GoodDetailItem> _recommendList = [];
  //页码
  int _page =1;
  bool isLoading= false; //当前正在加载的状态解决同时只能加载一个请求的
  bool _hasMore= true; //如果没有下一页不能再发起请求
  // 获取推荐列表
  Future<void> _getRecommendList() async {
    //当已经有请求正在加载或者已经没有下一页了,就放弃请求
    if (isLoading || !_hasMore){
      return;
    }
    isLoading=true;  //站住这个位置
    int requestLimit=_page*10;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    isLoading=false;
    setState(() {}); //数据更新
    if (_recommendList.length<10){
      _hasMore=false;
      return;

    }


    _page++;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getBannerList();
    // _getHotCategoryList();
    //  _getSpecialRecommendList();
    //  _getInVogueList();
    //  _getOneStopList();
    //  _getRecommendList();
    
     _registerEvent();

    //initState-->执行build----》下拉刷新组件---》才可以操作
    //Future.microTask //微任务
    Future.microtask((){
      _paddingTop=100;
      setState(() {
        
      });
      _key.currentState?.show();
    });


     

  }

  

//监听滚动到底部的事件
  void _registerEvent(){
    _controller.addListener((){
  
     if ( _controller.position.pixels>=(_controller.position.maxScrollExtent-50)){
      _getRecommendList();
     }

    });

  }

  // 获取热榜推荐列表
  Future<void>  _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  //获取特惠推荐列表
  Future<void> _getSpecialRecommendList() async{

    _specialRecommendResult=await getSpecialRecommendListAPI();

    setState(() {});
  }


  //获取分类列表
  Future<void> _getHotCategoryList() async{

    _hotCategoryList=await getHotCategoryListAPI();

    setState(() {});
  }
  
//获取轮播图列表
  Future<void> _getBannerList() async{

    _bannerList=await getBannerListAPI();

    setState(() {});
  }

 Future<void>_onRefresh()async{
  //下拉重新获取数据
    int _page =1;
    bool isLoading= false; 
    bool _hasMore= true; 
    await _getBannerList();
    await _getHotCategoryList();
   await  _getSpecialRecommendList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    //执行完刷新数据就成功了
  ToastUtils.showToast(context, "数据加载成功");
  _paddingTop=0;
  setState(() {});


 }

  //绑定一个scrollcontroller //监听滚动到底部事件
  final ScrollController _controller=ScrollController();
  //GlobalKey是一个方法可以创建一个key绑定到widget部件上可以操作widget
  final GlobalKey<RefreshIndicatorState> _key=GlobalKey<RefreshIndicatorState>();
  double _paddingTop=0;
  @override
  Widget build(BuildContext context) {  
    return RefreshIndicator( //触发下拉刷新
      key:_key, 
      onRefresh: _onRefresh,
      child: AnimatedContainer( //动画效果
        padding:EdgeInsets.only(top: _paddingTop),
        duration: Duration(microseconds: 300),
        child: CustomScrollView( //sliver家族必须是sliver家族内容
         controller: _controller, //绑定控制器//监听滚动底部事件
         slivers: _getScrollChildren(),
      ),
      
      )

    );

  }
}

//动画组件