import 'package:flutter/material.dart';
import 'package:testing_map/mapLevel.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('contruyendo');
    
    
    return MaterialApp(
      title: 'Material App',
      home: MapLevel()
    );
  }
}
