import 'package:fiestuki/util/csv_parser.dart';
import 'package:fiestuki/util/pop_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdivinaPeliculaRoute extends StatefulWidget {
  const AdivinaPeliculaRoute({Key? key}) : super(key: key);

  @override
  State<AdivinaPeliculaRoute> createState() => _AdivinaPeliculaRouteState();
}

class _AdivinaPeliculaRouteState extends State<AdivinaPeliculaRoute> {
  Future<void>? _initializeFuture;
  late List<List<String>> _texts;
  int index = 0;

  Future<void> _loadTexts() async {
    String raw =
        await rootBundle.loadString("assets/texts/adivina_pelicula.csv");
    _texts = await CsvParser.parse(raw);
    setState(() {
      _texts.shuffle();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _initializeFuture = _loadTexts();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popTwo(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Adivina la película"),
        ),
        body: FutureBuilder(
          future: _initializeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  index++;
                  if (index == _texts.length) {
                    index = 0;
                    _texts.shuffle();
                  }
                });
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        _texts[index][1],
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                      Text(
                        _texts[index][0],
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
