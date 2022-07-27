import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

enum VerdadRetoEstado { seleccion, verdad, reto }

class VerdadRetoRoute extends StatefulWidget {
  const VerdadRetoRoute({Key? key}) : super(key: key);

  @override
  State<VerdadRetoRoute> createState() => _VerdadRetoRouteState();
}

class _VerdadRetoRouteState extends State<VerdadRetoRoute> {
  VerdadRetoEstado estado = VerdadRetoEstado.seleccion;
  late final List<String> _verdades;
  int iverdades = 0;
  late final List<String> _retos;
  int iretos = 0;
  String texto = "";

  void loadRetos() async {
    String retos = await rootBundle.loadString("assets/reto.txt");
    _retos = retos.split("\n");
    _retos.shuffle();
  }

  void loadVerdades() async {
    String verdades = await rootBundle.loadString("assets/verdad.txt");
    _verdades = verdades.split("\n");
    _verdades.shuffle();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadRetos();
      loadVerdades();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verdad o reto"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (estado == VerdadRetoEstado.seleccion)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          estado = VerdadRetoEstado.verdad;
                          if (iverdades == _verdades.length) {
                            iverdades = 0;
                            _verdades.shuffle();
                          }
                          texto = _verdades[iverdades];
                          iverdades++;
                        });
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width / 2, 0))),
                      child: const Text("Verdad")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          estado = VerdadRetoEstado.reto;
                          if (iretos == _retos.length) {
                            iretos = 0;
                            _retos.shuffle();
                          }
                          texto = _retos[iretos];
                          iretos++;
                        });
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width / 2, 0))),
                      child: const Text("Reto"))
                ],
              ),
            if (estado != VerdadRetoEstado.seleccion)
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    estado = VerdadRetoEstado.seleccion;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      texto,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
