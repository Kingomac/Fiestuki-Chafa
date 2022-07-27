import 'package:fiestuki/adivina_influencer_tutorial.dart';
import 'package:fiestuki/quien_mas_probable.dart';
import 'package:fiestuki/verdad_o_reto.dart';
import 'package:fiestuki/yo_nunca.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiestuki chafa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fiestuki chafa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const YoNuncaRoute()));
                        },
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VerdadRetoRoute()));
                        },
                        child: const Text('Verdad o reto')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const QuienMasProbableRoute()));
                        },
                        child: const Text('Quién es mas probable que')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Para meme el que no programó esto")));
                        },
                        child: const Text('Quiz de memes')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdivinaInfluencerTutorial()));
                        },
                        child: const Text('Adivina el influencer')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: () {},
                        child: const Text('Prueba')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
            SizedBox(
                height: 50,
                child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(1000, 1000)),
                        onPressed: _incrementCounter,
                        child: const Text('Yo nunca')))),
          ],
        ),
      ),
    );
  }
}
