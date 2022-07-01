

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//https://pub.dev/packages/flutter_list_view
CityChoose( List<String> data ){
  var controller = ScrollController();

   var cityListView = ListView.builder(
       controller:controller,
       itemBuilder: (context,index){
    bool isABC = (data[index].length ==1 );
    return Container(height:40,color: isABC ? Colors.grey :Colors.white, padding :EdgeInsets.all(10) , child: Text(data[index]),);
  },itemCount:data.length);

   var abcListData =data.where((element) => element.length ==1).toList();
   var slideBar = Listener(onPointerMove :(event){
     print("move ${event.position.dy}");
     var dy =event.position.dy;
     if(dy>=150 && dy<=600){

       controller.jumpTo( 40*(dy - 150)%20);
     }

   },child: Align(alignment :Alignment.centerRight,child: Listener(child: Column(
     mainAxisSize:MainAxisSize.min,
     children: List.generate(abcListData.length, (index) => Container(height: 20,child: Text(abcListData[index]),)),
   ),) ,),);

   return Stack(children: [
    cityListView,
     slideBar
  ],);

}