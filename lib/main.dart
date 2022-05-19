import 'dart:io';

import 'package:flutter/material.dart';

import 'myapp.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides(); // To solvent CERTIFICATE_VERIFY_FAILED
  runApp( MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }

}