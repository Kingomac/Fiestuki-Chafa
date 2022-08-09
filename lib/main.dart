import 'package:fiestuki/adivina_influencer.dart';
import 'package:fiestuki/adivina_pelicula.dart';
import 'package:fiestuki/mas_probable.dart';
import 'package:fiestuki/matame_camion.dart';
import 'package:fiestuki/tabu.dart';
import 'package:fiestuki/tutorial.dart';
import 'package:fiestuki/util/csv_parser.dart';
import 'package:fiestuki/verdad_o_reto.dart';
import 'package:fiestuki/yo_nunca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

Widget getRoute(String juego) {
  switch (juego) {
    case "yoNunca":
      return const YoNuncaRoute();
    case "adivinaInfluencer":
      return const AdivinaInfluencerRoute();
    case "masProbable":
      return const QuienMasProbableRoute();
    case "matameCamion":
      return const MatameCamionRoute();
    case "tabu":
      return const TabuRoute();
    case "verdadReto":
      return const VerdadRetoRoute();
    case "adivinaPelicula":
      return const AdivinaPeliculaRoute();
    default:
      return const MyApp();
  }
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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<List<String>> _texts;
  Future<void>? _initialzeFuture;

  Future<void> _loadTexts() async {
    String raw = await rootBundle.loadString("assets/texts/menu.csv");
    _texts = await CsvParser.parse(raw);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _initialzeFuture = _loadTexts();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: _initialzeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  for (List<String> btn in _texts)
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: TextButton(
                          style: ButtonStyle(
                              alignment: Alignment.center,
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(12.0))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tutorial(
                                        cuerpo: btn[2],
                                        nombre: btn[1],
                                        route: getRoute(btn[0]))));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/imgs/menu/${btn[0]}.webp",
                                isAntiAlias: true,
                                fit: BoxFit.fitHeight,
                                width: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  btn[1],
                                  style: const TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        )
                        /*TextButton.icon(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(1000, 1000)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tutorial(
                                        cuerpo: btn[2],
                                        nombre: btn[1],
                                        route: getRoute(btn[0]))));
                          },
                          label: Text(btn[1]),
                          icon: Image.asset(
                            "assets/imgs/menu/${btn[0]}.png",
                            width: 20,
                            height: 20,
                            scale: 0.2,
                          ),
                        ),*/
                        ),
                ],
              ),
            );
          }),
    );
  }
}
