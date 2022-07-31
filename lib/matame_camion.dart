import 'dart:convert';

import 'package:fiestuki/util/pop_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MatameCamionRoute extends StatefulWidget {
  const MatameCamionRoute({Key? key}) : super(key: key);

  @override
  State<MatameCamionRoute> createState() => _MatameCamionRouteState();
}

class _MatameCamionRouteState extends State<MatameCamionRoute> {
  late List<String> _texts;
  Future<void>? _initializeFuture;
  int _index = 0;

  Future<void> _loadTexts() async {
    String raw = await rootBundle.loadString("assets/matame_camion.txt");
    _texts = LineSplitter.split(raw).toList();
    _texts.shuffle();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _initializeFuture = _loadTexts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Mátame camión"),
          ),
          body: FutureBuilder(
            future: _initializeFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _index++;
                      if (_index == _texts.length) {
                        _index = 0;
                        _texts.shuffle();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        _texts[_index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        onWillPop: () => popTwo(context));
  }
}
