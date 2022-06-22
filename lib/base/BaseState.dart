import 'package:flutter/material.dart';

class HttpState extends ChangeNotifier {
  late HttpRequestState state = HttpRequestState.Ready;
  String? message ="";

  setHttpRequestState(HttpRequestState state,{String? message}) {
    this.message=message??"";
    this.state = state;
    notifyListeners();
  }

 bool isFail()=>state==HttpRequestState.Fail;
}

enum HttpRequestState{
  Ready,
  Loading,
  Suc,
  Fail,
}
