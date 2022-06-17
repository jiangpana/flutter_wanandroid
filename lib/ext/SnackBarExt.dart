
import 'package:flutter/material.dart';

import '../main.dart';

showSnackBar(text){
  final snackBar = SnackBar(content: Text(text));
// 从组件树种找到ScaffoldMessager，并用它去show一个snackBar
  ScaffoldMessenger.of(sContext).showSnackBar(snackBar);

}