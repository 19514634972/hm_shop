import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';


class HmCategory extends StatefulWidget {
  //分类列表
  final List<HotCategory> categoryList;
  HmCategory({Key? key,required this.categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    //不能使用listView不能设置高度
    //container和sizedBox可以设置高度
    return SizedBox(
      height: 100,
      child:ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(), // 确保即使内容不足也能滑动
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index){
          //widget获取分类列表
          final category=widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            height: 100,
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 224, 229),
              borderRadius: BorderRadius.circular(40),
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture,width: 50,height: 50),
                Text(category.name,style: TextStyle(color: Colors.black)),
                
              ],

            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
          );

        },

      )


    );
  }
}