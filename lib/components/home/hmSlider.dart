import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';


//父传子
class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key,required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _controller=CarouselSliderController(); //轮播图控制器
  int _currentIndex=0; //当前轮播图索引
  //样式切换动画效果
  Widget _getDots(){
    return  Positioned(
      left:0,
      right: 0,
      bottom: 10,
      child:SizedBox(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,//主轴居中
          children:List.generate(widget.bannerList.length, (int index){
            return GestureDetector(
              onTap: (){
                _controller.animateToPage(index);

              },
              child:AnimatedContainer( //动画切换
              duration: Duration(milliseconds: 300), //动画时长
              width: index==_currentIndex?40:20,
              height: 5,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index==_currentIndex?Colors.white:Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(3), //圆角
              ),
            ),
            );

          })
        ),
    )

  );
  }
  Widget _getSlider(){
    //返回轮播图插件
    //flutter中获取屏幕宽度的方法
    final double screenWidth=MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _controller, //轮播图控制器
      items:List.generate(widget.bannerList.length, (int idex){
        return Image.network(
          widget.bannerList[idex].imageUrl,
          fit: BoxFit.cover,
          width: screenWidth, //
          );
      }),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0, //适口占比
        autoPlay: true, //自动播放
        //outPlayInterval: Duration(seconds: 3), //自动播放间隔
        onPageChanged: (int index,CarouselPageChangedReason reason){
          setState(() {
            _currentIndex=index;
          });
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //stack-->轮播图，搜索框，指示导航
    return  Stack(
      children: [
        //轮播图
        _getSlider(),
        _getSearch(),
        _getDots(),
      ],
    );
  }
}


Widget _getSearch() {
  return Positioned(
    top: 10,
    left: 0,
    right: 0,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.circular(25),
        ), // BoxDecoration
        child: Text(
          "搜索...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ), // Text
      ), // Container
    ), // Padding
  ); // Positioned
}

