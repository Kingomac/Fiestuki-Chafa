import 'dart:async';

import 'package:fiestuki/util/csv_parser.dart';
import 'package:fiestuki/util/pop_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabuRoute extends StatefulWidget {
  const TabuRoute({Key? key}) : super(key: key);

  @override
  State<TabuRoute> createState() => _TabuRouteState();
}

class _TabuRouteState extends State<TabuRoute> {
  late List<List<String>> _texts;
  Future<void>? _initializeFuture;
  int _index = 0;
  late Timer _timer;
  int _remainingTime = 45;

  Future<void> _loadTexts() async {
    String raw = await rootBundle.loadString("assets/tabu.csv");
    _texts = await CsvParser.parse(raw);
    _texts.shuffle();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _initializeFuture = _loadTexts();
        _initializeFuture?.then((value) => startTimer());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popTwo(context),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Tabú"),
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
                width: double.maxFinite,
                height: double.maxFinite,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: () {
                    setState(() {
                      _index++;
                      if (_index == _texts.length - 1) {
                        _texts.shuffle();
                        _index = 0;
                      }
                      _remainingTime = 45;
                    });
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Text(_remainingTime.toString()),
                                  Text(_texts[_index][0],
                                      style: const TextStyle(fontSize: 22))
                                ],
                              ))
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (_remainingTime == 0)
                              const Text("Se acabó el tiempo",
                                  style: TextStyle(fontSize: 18))
                            else
                              Column(
                                children: [
                                  Text(
                                    _texts[_index][1],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(_texts[_index][2],
                                      style: const TextStyle(fontSize: 18)),
                                  Text(_texts[_index][3],
                                      style: const TextStyle(fontSize: 18))
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
