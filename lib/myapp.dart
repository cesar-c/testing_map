import 'dart:convert';

import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';
import 'package:testing_map/Objeto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<PointModel> points = [];

  @override
  // ignore: must_call_super
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(()=>fetchData());
  }

  @override
  Widget build(BuildContext context) {
    print('contruyendo');
    
    
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: 
        (points.isNotEmpty) ? 
        GameLevelsScrollingMap.scrollable(
          imageUrl: "https://intranet.colegiocima.edu.pe/file_matematica/map_vertical.png",
          direction: Axis.vertical,
          reverseScrolling: true,
          svgUrl: 'https://intranet.colegiocima.edu.pe/file_matematica/map_vertical.svg',
          points: points) :
           Center(child: Text('Cargando...')),
      ),
    );
  }

  Widget testWidget(String data) {
    return InkWell(
      child: Center(child: 
        Container(alignment: Alignment.center,width: 20, height: 20, color: Colors.red, child: Text(data))
      ),
      // ignore: avoid_print
      onTap: () => print(data));
  }

  List<String> getData(){
    List<String> lista = [];
    for(var i = 0 ; i <= 82 ; i++ ){
      lista.add('a');
    }
    lista.add('c');
    lista.add('d');
    lista.add('e');
    return lista;
  }

  Future<Null> fetchData() async {
  
      final uri = Uri.parse("https://intranet.colegiocima.edu.pe:8087/api/v1/topic/list");
      final response =
          await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
          final data = Objeto.fromJson(jsonResponse);
          for (final item in data.content!) {
            points.add(PointModel(0,testWidget(item.name!)));
          }
          setState(() {});
          print('CARGOOOOOOOOOOOOO');
      } else {
        throw Exception('Unexpected error occured!');
      }
  }
}