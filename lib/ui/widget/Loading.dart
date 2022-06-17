

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget CommonLoading(){
  return Lottie.asset(
    'assets/loading.json',
    width: 100,
    fit: BoxFit.cover,
    alignment: Alignment.center,
  );
}