import 'package:flutter/material.dart';

import '../../common/appbar.dart';
import '../../common/drawer.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

  static const double titleSize = 24;
  static const double normalSize = 16;
  static const double sizedheight = 10;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      endDrawer: MyDrawer(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Text("  선박 이용 안전 수칙", style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),),
          SizedBox(height: sizedheight,),
          Text("   ＊ 질서를 지키며 승선하기", style: TextStyle(fontSize: normalSize),),
          SizedBox(height: sizedheight,),
          Text("   ＊ 계단 이용 시 손잡이 이용", style: TextStyle(fontSize: normalSize),),
          SizedBox(height: sizedheight,),
          Text("   ＊ 서둘러 내리지 않기", style: TextStyle(fontSize: normalSize),),
          SizedBox(height: sizedheight,),
          Text("   ＊ 질서를 지키며 하선하기", style: TextStyle(fontSize: normalSize),),
          SizedBox(height: 40,),
          Text("  선박 이용 안전 수칙", style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),),
          SizedBox(height: sizedheight,),
          Text("   ＊ 통로나 탈출로에 개인 물품 놓지 않기", style: TextStyle(fontSize: normalSize),),
          SizedBox(height: sizedheight,),
          Text("   ＊ 비상시를 대비하여 구명장비 사용법 및 보관 장소 숙지하기", style: TextStyle(fontSize: normalSize),),
          SizedBox(height: sizedheight,),
          Text("   ＊ 비상탈출 경로와 비상벨의 위치 등 확인하기", style: TextStyle(fontSize: normalSize),),
        ],
      ),
    );
  }
}
