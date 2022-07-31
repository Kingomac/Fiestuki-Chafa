import 'package:flutter/material.dart';

Future<bool> popTwo(BuildContext context) async {
  Navigator.pop(context);
  Navigator.pop(context);
  return Future(() => true);
}