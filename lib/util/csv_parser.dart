import 'dart:convert';
import 'dart:isolate';

class AsyncParserArgs {
  final SendPort sendPort;
  final String text;

  AsyncParserArgs(this.sendPort, this.text);
}

class CsvParser {
  static Future<List<List<String>>> parse(String text) async {
    final p = ReceivePort();
    await Isolate.spawn(_parseThread, AsyncParserArgs(p.sendPort, text));
    return await p.first as List<List<String>>;
  }

  static void _parseThread(AsyncParserArgs args) {
    List<List<String>> toret = [];
    for (String line in LineSplitter.split(args.text)) {
      List<String> innerList = line.split(";;");
      toret.add(innerList);
    }
    Isolate.exit(args.sendPort, toret);
  }

  static List<List<String>> parseSync(AsyncParserArgs args) {
    List<List<String>> toret = [];
    for (String line in LineSplitter.split(args.text)) {
      List<String> innerList = line.split(";;");
      toret.add(innerList);
    }
    return toret;
  }
}
