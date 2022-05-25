import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';
import 'package:testing_map/Objeto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class MapLevel extends StatefulWidget {
  MapLevel({Key? key}) : super(key: key);

  @override
  State<MapLevel> createState() => _MapLevelState();
}

class _MapLevelState extends State<MapLevel> {
  List<PointModel> points = [];
  double widthScreen = 0;

  @override
  // ignore: must_call_super
  void didChangeDependencies() {
    super.didChangeDependencies();
    widthScreen = MediaQuery.of(context).size.width;
    Future.microtask(()=>fetchData());
  }
  
  @override
  Widget build(BuildContext context) {
    final img = SvgPicture.network("https://intranet.colegiocima.edu.pe/file_matematica/map_vertical_2.svg");

    return Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: 
        (points.isNotEmpty) ? 
        GameLevelsScrollingMap.scrollable(
          imageUrl: "https://intranet.colegiocima.edu.pe/file_matematica/map_vertical.png",
//          backgroundImageWidget: SvgPicture.network("https://intranet.colegiocima.edu.pe/file_matematica/map_vertical_2.svg"),
          direction: Axis.vertical,
          reverseScrolling: true,
          svgUrl: 'https://intranet.colegiocima.edu.pe/file_matematica/map_vertical.svg',
          points: points) :
           Center(child: Text('Cargando...')),
      );
  }

  
  Widget testWidget(String data) {
    return InkWell(
      child: Center(child: 
        Container( alignment: Alignment.center,
                   width: widthScreen*0.07, 
//                   height: widthScreen*0.08,
                   child: Column(
                     children: [
                       Container(
                         width: widthScreen*0.07, 
                         height: widthScreen*0.07,
                         padding: EdgeInsets.all(widthScreen*0.01),
                         child: Image.network('https://pngimg.com/uploads/star/star_PNG41495.png'),
                         decoration: const BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle
                                            )
                       ),
                       const Text('***', textAlign: TextAlign.center)
                     ]
                   ))
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
  
      final uri = Uri.parse("https://api.colegiocima.edu.pe:8087/api/v1/topic/list");
      final response =
          await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
          final data = Objeto.fromJson(jsonResponse);
          for (final item in data.content!) {
            points.add(PointModel(widthScreen*0.08,testWidget(item.name!)));
          }
          setState(() {});
          print('CARGOOOOOOOOOOOOO');
      } else {
        throw Exception('Unexpected error occured!');
      }
  }
}