import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class YoNuncaRoute extends StatefulWidget {
  const YoNuncaRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YoNuncaRouteState();
}

class _YoNuncaRouteState extends State<YoNuncaRoute> {
  String _frase = '🔥pulsaría la pantalla🔥';
  late final Set<String> frases;
  int index = 0;

  _getFrases() async {
    final loaded = await rootBundle.loadString("assets/yo_nunca.txt");
    List<String> toRandomize = loaded.split("\n");
    toRandomize.shuffle();
    frases = toRandomize.toSet();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getFrases();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yo nunca'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            if (frases.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Se acabaron los yo nuncas 😥😥")));
              Navigator.pop(context);
              return;
            }
            _frase = frases.first;
            frases.remove(_frase);
          });
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(7),
          child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Yo nunca"),
                  Text(_frase,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22)),
                ],
              )),
        ),
      ),
    );
  }
}
