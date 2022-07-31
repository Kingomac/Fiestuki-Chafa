import 'package:fiestuki/util/csv_parser.dart';
import 'package:fiestuki/util/pop_two.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AdivinaInfluencerRoute extends StatefulWidget {
  const AdivinaInfluencerRoute({Key? key}) : super(key: key);

  @override
  _AdivinaInfluencerRouteState createState() => _AdivinaInfluencerRouteState();
}

class _AdivinaInfluencerRouteState extends State<AdivinaInfluencerRoute> {
  YoutubePlayerController? _controller;
  int index = 0;
  late List<List<String>> _textos;
  Future<void>? _initialFuture;

  Future<void> _loadTexts() async {
    String a = await rootBundle.loadString("assets/adivina_influencer.csv");
    _textos = await CsvParser.parse(a);
    _textos.shuffle();
    setState(() {
      _controller = YoutubePlayerController(
        initialVideoId: _textos[index][1],
        params: const YoutubePlayerParams(
          autoPlay: false,
          interfaceLanguage: "es",
          showControls: true,
          showFullscreenButton: true,
          desktopMode: false,
          privacyEnhanced: true,
          useHybridComposition: true,
        ),
      );
      _controller?.onEnterFullscreen = () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      };
    });
  }

  @override
  void initState() {
    super.initState();
    _initialFuture = _loadTexts();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popTwo(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Adivina el influencer"),
        ),
        body: FutureBuilder(
            future: _initialFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _controller != null
                        ? YoutubePlayerIFrame(controller: _controller)
                        : const Center(child: CircularProgressIndicator()),
                  ),
                  Text(
                    _textos[index][0],
                    style: const TextStyle(fontSize: 22, height: 5),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        index++;
                        if (index == _textos.length) {
                          _textos.shuffle();
                          index = -1;
                        }
                        setState(() {
                          index++;
                          _controller?.load(_textos[index][1]);
                        });
                      },
                      child: const Text("Siguiente"))
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
