import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuienMasProbableRoute extends StatefulWidget {
  const QuienMasProbableRoute({Key? key}) : super(key: key);

  @override
  State<QuienMasProbableRoute> createState() => _QuienMasProbableRouteState();
}

class _QuienMasProbableRouteState extends State<QuienMasProbableRoute> {
  late List<String> _texts;
  int _index = 0;
  Future<void>? _initializeFuture;

  Future<void> loadTexts() async {
    final String raw = await rootBundle.loadString("assets/mas_probable.txt");
    _texts = LineSplitter.split(raw).toList();
    _texts.shuffle();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _initializeFuture = loadTexts();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quién es más probable que"),
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
                onTap: () {
                  setState(() {
                    if (_index == _texts.length - 1) {
                      _index = 0;
                      _texts.shuffle();
                    } else {
                      _index++;
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Quién es más probable que",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      _texts[_index],
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
