import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  final String cuerpo;
  final String nombre;
  final Widget route;

  const Tutorial(
      {Key? key,
      required this.cuerpo,
      required this.nombre,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                cuerpo,
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => route));
                  },
                  child: const Text("que si abby que si"))
            ],
          ),
        ),
      ),
    );
  }
}
