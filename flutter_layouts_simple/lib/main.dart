import 'package:flutter/material.dart';
import 'package:flutter_layouts_simple/button_col.dart';
import 'package:flutter_layouts_simple/title_row.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //
    var color = Theme.of(context).primaryColor;

    var image = Image.asset('images/lake.jpg', width: 600, height: 240, fit: BoxFit.cover);

    var titleSection = const TitleRow();

    var buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonColumn(color, Icons.call, 'CALL'),
        ButtonColumn(color, Icons.near_me, 'ROUTE'),
        ButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    var textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            image,
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }
}
