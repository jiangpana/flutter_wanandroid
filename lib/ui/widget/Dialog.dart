import 'package:flutter/material.dart';

import '../../main.dart';

 showCenterDialog( {Function? ok  ,title = "提示", required content}  ) {
   showDialog<void>(
     context: sContext,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Text(title),
         titlePadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
         titleTextStyle: TextStyle(
           color: Colors.blue,
           fontSize: 25,
         ),
         contentPadding: EdgeInsets.only(left: 15, right: 15),
         contentTextStyle: const TextStyle(
           color: Colors.grey,
           fontSize: 16,
         ),
         // 内容控件
         content: Container(
           height: 100,
           child: Column(
             children: [
               Padding(
                 padding: EdgeInsets.all(15),
               ),
               Text(content),
             ],
           ),
         ),
         backgroundColor: Colors.white,
         actionsPadding: EdgeInsets.all(15),
         actions: [
           TextButton(
               onPressed: () {
                 Navigator.pop(sContext, 'AlertDialog - Normal, cancel');
               },
               child: Text("取消")),
           TextButton(
             onPressed: () {
               ok?.call();
               Navigator.pop(sContext);
             },
             child: Text("确定"),
           ),
         ],
       );
     },
   );

}
