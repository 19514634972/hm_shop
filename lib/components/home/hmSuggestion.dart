import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

//推荐组件
class HmSuggesstion extends StatefulWidget { //父传子
  //接收特惠推荐数据模型
  final SpecialRecommendResult specialRecommendResult;

  HmSuggesstion({Key? key,required this.specialRecommendResult}) : super(key: key);

  @override
  _HmSuggesstionState createState() => _HmSuggesstionState();
}

class _HmSuggesstionState extends State<HmSuggesstion> {
  //只有取前3条
  List<GoodsItem> _getDisplayItems(){
    if (widget.specialRecommendResult.subTypes.isEmpty) return [];

    return widget.specialRecommendResult.subTypes.first.goodsItems.items.
    take(3).
    toList();

  }
  //特惠推荐顶部内容封装成函数返回以widget
  Widget _buildHeader(){
    return Row(
      children: [
        Text("特惠推荐",style:TextStyle(
          color: const Color.fromARGB(255, 82, 45, 45),
          fontSize: 18,
          fontWeight: FontWeight.w600,//加粗
          ),
       
        ),
        SizedBox(width: 10), //间距
        Text("精选省攻略",style:TextStyle(
          color: const Color.fromARGB(255, 90, 67, 67),
          fontSize: 12,
          fontWeight: FontWeight.w600,//加粗
          ),),
      ],
    );
  }

  //循环渲染前三条
  List<Widget> _getChildrenList(){
    List<GoodsItem> list=_getDisplayItems();
    return List.generate(list.length, (int index){
      return Column(
        children: [
          ClipRRect(//可以包裹子元素裁剪图片设置圆角
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
            errorBuilder: (context,error,stackTrace){
              //图片加载失败就替换一个本地图片
              return Image.asset(
                  "lib/assets/home_cmd_inner.png",
                  width:100 ,
                  height: 140,
                  fit: BoxFit.cover,
                );

              },
            list[index].picture,
            width:100 ,
            height: 140,
            fit: BoxFit.cover,
            ),

          ),
         SizedBox(height: 10,),
         Container(
          padding:EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:  Colors.red,
          ),
          child:Text("￥${list[index].price}",style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            )
    
          ),
          

         ),

        ],
      );

    });

  }
  //左侧内容
  Widget _builderLeft(){
    return Container(
      width:100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );

  }
  //完成渲染
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
       
       padding: EdgeInsets.all(10), //内边距
       decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_sm.png"),
          fit: BoxFit.cover,
        ),

       ),
       child:Column(
          children: [ //顶部内容
            _buildHeader(),
            SizedBox(height: 10), //间距
            Row(
              children:[
                _builderLeft(),
                Expanded( //占满右边剩余空间
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildrenList(),
                  ),
                  ),
      
              ]
            )
          ],
       ),
    );
  }
}